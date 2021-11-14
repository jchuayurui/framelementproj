% node_coord = load('test_input_node_coord.txt');
% elem_connect = load('test_input_elem_connect.txt');
% node_disp = load('test_delta_node_disp.txt');

% node_coord = load('test_input_node_coord_lec.txt');
% elem_connect = load('test_input_elem_connect_lec.txt');
% node_disp = load('test_delta_node_disp_lec.txt');

node_coord = load('input_node_coord.txt');
elem_connect = load('input_elem_connect.txt');
node_disp = load('delta_node_disp1.txt');

%input deformation scale and material properties
deformation_scale = 1;
E = 1; %Young's modulus
h = 1; %height of beam

elem_num = size(elem_connect,1);
elem_stress = zeros(elem_num,1);

hold on
for i = 1:elem_num
    %determine which nodes for each element
    node_1 = elem_connect(i,1);
    node_2 = elem_connect(i,2);

    %extracting undeformed node coordinates
    X1 = node_coord(node_1, 1);
    Y1 = node_coord(node_1, 2);
    X2 = node_coord(node_2, 1);
    Y2 = node_coord(node_2, 2);
    L_undeformed = sqrt((Y2-Y1)^2 + (X2-X1)^2);

    %calculating undeformed rotation of element
    r_elem = atan2((Y2-Y1) , (X2-X1));
    %calculating undeformed tangent of element
    t_elem = (Y2-Y1) / (X2-X1);

    %plot undeformed
    plot([X1 X2], [Y1 Y2], 'Color', '#555555');

    %extracting nodal displacements X, Y, rotation
    %multiplied by a scaling factor for better visualisation
    D1 = node_disp(3*node_1-2 : 3*node_1) * deformation_scale;
    D2 = node_disp(3*node_2-2 : 3*node_2) * deformation_scale;

    %calculating deformed node coordinates
    X1 = X1 + D1(1);
    Y1 = Y1 + D1(2);
    X2 = X2 + D2(1);
    Y2 = Y2 + D2(2);
    L_deformed = sqrt((Y2-Y1)^2 + (X2-X1)^2);

    %calculating deformed tangent at each node
    t1 = tan(r_elem + D1(3));
    t2 = tan(r_elem + D2(3));

    %calculating stress and plotting deformed results
    elem_bending_stress = ferguson_plot(X1, Y1, t1, X2, Y2, t2, E, h);
    elem_axial_stress = E * abs(L_deformed - L_undeformed);
    elem_stress(i) = elem_axial_stress + elem_bending_stress;
end
hold off

elem_stress