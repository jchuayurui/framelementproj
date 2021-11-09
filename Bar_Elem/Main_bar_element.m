%  Simple finite element analysis code
%
%  ME4291 FEA
%  Capable of non-uniform bar and with traction
%

%  Load node coordinates and element connectivity
nodes = load('Input_node_coord_2.txt');
elems = load('Input_elem_connect_2.txt');

%  Determine the number of nodes
node_size = size(nodes);
num_of_nodes = node_size(1);

%  Allocate space for [K] matrix and [F] vector
K = zeros(num_of_nodes, num_of_nodes);
F = zeros(num_of_nodes, 1);

%  Determine the number of elements
elem_size = size(elems);
num_of_elem = elem_size(1);

%  Loop through every element
for j = 1:num_of_elem
    %  obtain node coordinates
    node_1 = elems(j,1);
    node_2 = elems(j,2);
    node_1_coord = nodes(node_1);
    node_2_coord = nodes(node_2);

    %  Form element stiffness matrix
    Ke = Sub_bar_stiffness(node_1_coord, node_2_coord);

    % Assemble into global matrix
    global_dof = elems(j,:);
    K( global_dof, global_dof ) = K( global_dof, global_dof ) + Ke;

    % Form the nodal force vector for each element
    Q = Sub_bar_body_force(node_1_coord, node_2_coord);

    % Assemble into global force vector
    F( global_dof) = F( global_dof ) + Q;

end
%  End of for-loop for each element 

%  Apply force boundary condition
%    Last node has a force 10kN
% F(num_of_nodes) = F(num_of_nodes) + 10e3;

%  Apply displacement boundary condition
%    Node 1 has zero displacement
F_copy = F(1);
K_copy = K(1,:);
F(1) = 0;
K(1,:) = zeros(1,num_of_nodes);
K(1,1) = 1;


%  Solve for the displacements
u = K\F

% Calculate reaction force
R = K_copy * u - F_copy
