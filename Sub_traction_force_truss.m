function Q = Sub_traction_force_truss(node_1_coord, node_2_coord )
%
%  Returns a 4 by 1 element force vector for the forces at two nodes
%
%  Inputs: global x- and y- coordinates of node 1 and node 2
%  
%  Requires:
%    Input_2D_traction.m
%    Gauss_xx.txt

  
  % Load Gauss data
  Gauss_data = load('Gauss_04.txt');
  Gauss_point = Gauss_data(:,1);
  Gauss_weight = Gauss_data(:,2);

  % Obtain the length of element
  L = norm(node_2_coord - node_1_coord);

  % For Gauss quadrature sum
  sum_1 = [0; 0];   % for node 1, 2x1 vector
  sum_2 = [0; 0];   % for node 2, 2x1 vector
  for j=1:length(Gauss_point)
    % Calculate the shape functions N1 and N2 at the Gauss point
    N1 = (1 - Gauss_point(j))/2;
    N2 = (1 + Gauss_point(j))/2;
    % Calculate the global coordinates of Gauss point
    X = N1 * node_1_coord(1) + N2 * node_2_coord(1);
    Y = N1 * node_1_coord(2) + N2 * node_2_coord(2);
    % Obtain the traction and thickness values
    T = Input_2D_traction_truss(X,Y);  % returns 2x1 vector
    
    sum_1 = sum_1 + Gauss_weight(j)*T*N1; % 2x1 vector
    sum_2 = sum_2 + Gauss_weight(j)*T*N2; % 2x1 vector
  end
  sum_1 = sum_1/2*L;
  sum_2 = sum_2/2*L;

  % Return the nodal forces [node_1_FX; node_1_FY; node_2_FX; node_2_FY]
  Q =  [sum_1; sum_2]  % 4x1 vector
  
end