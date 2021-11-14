nodes = load('nodes.txt');
elems = load('elems.txt');
%  Split the elements recursively
[nodes,elems] = elementsplit(nodes,elems,5);

%  Determine the number of nodes
node_size = size(nodes);
num_of_nodes = node_size(1);

%  Allocate space for [K] matrix and [F] vector
K = zeros(3*num_of_nodes, 3*num_of_nodes);

%  Determine the number of elements
elem_size = size(elems);
num_of_elem = elem_size(1);

%Assembly
for j = 1:num_of_elem
    
    %   Obtain global node numbers
    node_1 = elems(j,1);
    node_2 = elems(j,2);

    %   Obtain element type
    elem_type = elems(j,3);

    %transformation
    p = 0;
    if (nodes(node_2,1) - nodes(node_1,1)< 0)
        p = p+pi;
    end
    p = p+ atan((nodes(node_2,2) - nodes(node_1,2))/ (nodes(node_2,1) - nodes(node_1,1)));
    A2 = zeros(6,6);
    %p = angle from x axis
    A2([1,2],[1,2]) = Transformation2D( p,0 );
    A2(3,3) = 1;
    A2([4,5],[4,5]) = Transformation2D( p,0 );
    A2(6,6) = 1;
    
    %	Flocal = A2Inv * K * A2 * ulocal
    K_bar = Sub_bar_stiffness(nodes(node_1,:), nodes(node_2,:), elem_type);
    K_bar_global = A2 * Input_1D_k(K_bar) * A2';
    
    K_beam = Sub_beam_stiffness(nodes(node_1,:), nodes(node_2,:), elem_type);
    K_beam_global = A2 * Input_1D_k_beam(K_beam) * A2';
    K_elem_global = K_bar_global + K_beam_global;
   
    %divide K_bar_global into 4 matrices (6x6)
    first_first = K_elem_global(1:3,1:3);
    first_second = K_elem_global(1:3,4:6);
    second_first = K_elem_global(4:6,1:3);
    second_second = K_elem_global(4:6,4:6);
    
    elem_global_dof_1 = (3*node_1 - 2 : 3*node_1);
    elem_global_dof_2 = (3*node_2 - 2 : 3*node_2);
    
    K( elem_global_dof_1, elem_global_dof_1 ) = K( elem_global_dof_1, elem_global_dof_1 ) + first_first;
    K( elem_global_dof_1, elem_global_dof_2 ) = K( elem_global_dof_1, elem_global_dof_2 ) + first_second;
    K( elem_global_dof_2, elem_global_dof_1 ) = K( elem_global_dof_2, elem_global_dof_1 ) + second_first;
    K( elem_global_dof_2, elem_global_dof_2 ) = K( elem_global_dof_2, elem_global_dof_2 ) + second_second;
    
end

% Load force and moment 
F = Input_2D_Force(nodes,elems);

%  Apply disp boundary condition
disp_data = load('Input_bc_disp_truss.txt');
disp_nodes = disp_data(:,1);
disp_dof = disp_data(:,2);
disp_values = disp_data(:,3);
num_of_disp = length(disp_values);

for j = 1:num_of_disp
    % Determine global dof
    if (disp_dof(j) == 1)
        global_dof = 3*disp_nodes(j) - 2; % X direction
    elseif (disp_dof(j) == 2) 
        global_dof = 3*disp_nodes(j) - 1;  % Y direction
    else
        global_dof = 3*disp_nodes(j);
    end   
    F(global_dof) = disp_values(j);
    K(global_dof,:) = zeros(1,3*num_of_nodes);
    K(global_dof,global_dof) = 1   ; 
end

%  Solve for the displacements
u = K\F;

%input deformation scale and material properties
deformation_scale = 10;
elem_stress = zeros(num_of_elem,1);

hold on
for i = 1:num_of_elem
    %determine which nodes for each element
    node_1 = elems(i,1);
    node_2 = elems(i,2);

    %extract material properties
    elem_type = elems(i,3);
    E = get_material_prop('E', elem_type);
    h = get_material_prop('h', elem_type);

    %extracting undeformed node coordinates
    X1 = nodes(node_1, 1);
    Y1 = nodes(node_1, 2);
    X2 = nodes(node_2, 1);
    Y2 = nodes(node_2, 2);
    L_undeformed = sqrt((Y2-Y1)^2 + (X2-X1)^2);

    %calculating undeformed rotation of element
    r_elem = atan2((Y2-Y1) , (X2-X1));
    %calculating undeformed tangent of element
    t_elem = (Y2-Y1) / (X2-X1);

    %plot undeformed
    switch elem_type
        case 1
            plot([X1 X2], [Y1 Y2], 'Color', '#333333');
        case 2
            plot([X1 X2], [Y1 Y2], 'Color', '#C07300');
    end

    %extracting nodal displacements X, Y, rotation
    D1 = u(3*node_1-2 : 3*node_1);
    D2 = u(3*node_2-2 : 3*node_2);

    %calculating deformed node coordinates
    x1 = X1 + D1(1);
    y1 = Y1 + D1(2);
    x2 = X2 + D2(1);
    y2 = Y2 + D2(2);
    L_deformed = sqrt((y2-y1)^2 + (x2-x1)^2);

    %calculating deformed tangent at each node
    t1 = tan(r_elem + D1(3));
    t2 = tan(r_elem + D2(3));

    %calculating stress
    elem_bending_stress = calc_bending_stress(x1, y1, t1, x2, y2, t2, E, h);
    elem_axial_stress = E * abs(L_deformed - L_undeformed)/L_undeformed;
    elem_stress(i) = (elem_axial_stress + elem_bending_stress);

    %multiply displacement by a scaling factor for better visualisation
    D1 = D1 * deformation_scale;
    D2 = D2 * deformation_scale;

    %calculating node coordinates and tangent after scaled deformations
    X1 = X1 + D1(1);
    Y1 = Y1 + D1(2);
    X2 = X2 + D2(1);
    Y2 = Y2 + D2(2);
    t1 = tan(r_elem + D1(3));
    t2 = tan(r_elem + D2(3));

    %cplot deformed results
    ferguson_plot(X1, Y1, t1, X2, Y2, t2);
end
hold off

elem_stress;
max(elem_stress)
