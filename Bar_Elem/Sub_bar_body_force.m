function Q = Sub_bar_body_force(node_1_coord, node_2_coord )
%   Returns a 2 by 1 element force vector
%   Inputs: global x-coordinates of node 1 and node 2
%   Requires Gauss quadrature data
%   Requires traction function for bar

  % Load Gauss data
  Gauss_data = load('Gauss_04.txt');
  Gauss_point = Gauss_data(:,1);
  Gauss_weight = Gauss_data(:,2);

  % Obtain the length of element
  L = node_2_coord - node_1_coord;

  % For Gauss quadrature sum
  sum = [0; 0];
  for j=1:length(Gauss_point)
    % Calculate the shape functions [N1; N2] at the Gauss point
    N1 = (1 - Gauss_point(j))/2;
    N2 = (1 + Gauss_point(j))/2;
    N = [ N1; N2];
    % Calculate the global coordinate of Gauss point
    X = (node_2_coord + node_1_coord)/2 + (node_2_coord - node_1_coord)/2 * Gauss_point(j);
    sum = sum + Gauss_weight(j) * Input_bar_traction(X)*N;
  end
  sum = sum/2*L;

  Q = sum;
  
end