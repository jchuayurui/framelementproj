function Ke = Sub_beam_stiffness(node_1_coord, node_2_coord, elem_type)
%   Returns a 4 by 4 element stiffness matrix
%   Inputs: global x-coordinates of node 1 and node 2
%   Requires E & A function for beam
  
  % Load Young's Modulus
  E = get_material_prop('E', elem_type);

  % Obtain the length of element
  L = sqrt((node_2_coord(1)-node_1_coord(1))^2 + (node_2_coord(2)-node_1_coord(2))^2);

  % Load moment of inertia
  b = get_material_prop('b', elem_type);
  h = get_material_prop('h', elem_type);
  I = b * h^3 / 12;
  
  % For Gauss quadrature sum
  Ke = (E*I/L^3) * [ 12,       6*L,    -12,       6*L; 
                6*L,   4*(L^2),   -6*L,   2*(L^2);
                -12,      -6*L,     12,      -6*L;
                6*L,   2*(L^2),   -6*L,  4*(L^2)];
  
end