%  Helper function to plot triangular mesh
%

%  Load node coordinates and element connectivity
nodes = load('Input_node_coord.txt');
elems = load('Input_elem_connect.txt');

clf;

patch('Faces',elems,'Vertices',nodes,'FaceColor','g','FaceAlpha', 0.1)
hold on;

force_data = load('Input_bc_traction_truss.txt');
force_data_size = size(force_data);
for j=1:force_data_size(1);
    node1 = force_data(j,1);
    node2 = force_data(j,2);
    x = [nodes(node1,1), nodes(node2,1) ];
    y = [nodes(node1,2), nodes(node2,2) ];
    line(x,y,'Color','red','linewidth',2)
end

disp_data = load('Input_bc_disp_truss.txt');
disp_data_size = size(disp_data);
for j=1:disp_data_size(1);
    
    node = disp_data(j,1);
    dirn = disp_data(j,2);
    x = [nodes(node,1)];
    y = [nodes(node,2)];
    if (dirn == 1 )
        plot(x,y,'b>');
    elseif (dirn == 2)
        plot(x,y,'b^');
    end
end

axis equal

hold off