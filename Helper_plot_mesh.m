%  Helper function to plot triangular mesh
%

%  Load node coordinates and element connectivity
nodes = load('Input_node_coord_truss.txt');
elems = load('Input_elem_connect_truss.txt');

size_e = size(elems);
elems = elems(1:size_e(1), 1:2);


clf;

patch('Faces',elems,'Vertices',nodes,'FaceColor','g','FaceAlpha', 0.1)
hold on;


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