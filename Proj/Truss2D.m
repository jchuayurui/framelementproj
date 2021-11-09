nodes = load('Input_node_coord.txt');
elems = load('Input_elem_connect.txt');

%  Determine the number of nodes
node_size = size(nodes);
num_of_nodes = node_size(1);

%  Allocate space for [K] matrix and [F] vector
K = zeros(2*num_of_nodes, 2*num_of_nodes);
F = zeros(2*num_of_nodes, 1);

%  Determine the number of elements
elem_size = size(elems);
num_of_elem = elem_size(1);

%Assembly
for j = 1:num_of_elem

    %   Obtain global node numbers
    node_1 = elems(j,1);
    node_2 = elems(j,2);
    p = 0;
    if (nodes(node_2,1) - nodes(node_1,1)< 0)
        p = p+pi;
    end
    p = p+ atan((nodes(node_2,2) - nodes(node_1,2))/ (nodes(node_2,1) - nodes(node_1,1)));
    A2 = zeros(4,4);
    %p = angle from x axis
    A2([1,2],[1,2]) = Transformation2D( p,0 );
    A2([3,4],[3,4]) = Transformation2D( p,0 );
    
    %	Flocal = A2Inv * K * A2 * ulocal
    K1D = Sub_bar_stiffness(nodes(node_1,:), nodes(node_2,:));
    KGlobal = A2 * Input_1D_k(K1D) * A2';

    %   Assemble into global matrix
    global_dof = [2*node_1-1, 2*node_1, 2*node_2-1, 2*node_2 ];
    K( global_dof, global_dof ) = K( global_dof, global_dof ) + KGlobal
    
end

%  Apply force boundary condition
force_data = load('Input_bc_traction_truss.txt');
force_data_size = size(force_data);
num_of_force = force_data_size(1);
% Loop through all edges
for j = 1:num_of_force
   % get nodes of edge
   node_1 = force_data(j,1);
   node_2 = force_data(j,2);
   % Calculate Q vector
   Q = Sub_traction_force_truss( nodes(node_1,:), nodes(node_2,:) );
   % Assemble Q into F
   global_dof = [2*node_1-1, 2*node_1, 2*node_2-1, 2*node_2 ];
   F( global_dof ) = F( global_dof ) + Q;
end


%  Apply disp boundary condition
disp_data = load('Input_bc_disp_truss.txt');
disp_nodes = disp_data(:,1);
disp_dof = disp_data(:,2);
disp_values = disp_data(:,3);
num_of_disp = length(disp_values);

for j = 1:num_of_disp
    % Determine global dof
    if (disp_dof(j) == 1)
        global_dof = 2*disp_nodes(j) - 1; % X direction
    else 
        global_dof = 2*disp_nodes(j) ;  % Y direction
    end   
    F(global_dof) = disp_values(j);
    K(global_dof,:) = zeros(1,2*num_of_nodes);
    K(global_dof,global_dof) = 1   ; 
end
%  Force at Node
F(8) = F(8)+ -500
F(10)= F(10) + -500
%  Solve for the displacements
u = K\F
