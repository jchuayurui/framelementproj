function EA = Input_bar_EA(X)
%   Returns the EA value for bar
%   Input: Global coordinate X

E = 70e9;
A = (1+sin(pi*X))*1e-4;

EA = E*A;

end