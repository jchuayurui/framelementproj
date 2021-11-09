function T = Input_2D_traction(X,Y)
%
%  Returns the traction values [TX ; TY] for global coordinates (X,Y)
%   

TX = 0;
%self weight
TY = 2710 * 9.81 * Input_2D_A(X,Y);

T = [TX; TY];

end