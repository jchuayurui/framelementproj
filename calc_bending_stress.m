function max_M = calc_bending_stress(X1, Y1, t1, X2, Y2, t2, E, h)
%number of steps 100
n = 100;

L = X2 - X1;
t1 = t1 * L;
t2 = t2 * L;

S = [Y1; Y2; t1; t2];
C = [1 0 0 0;
     0 0 1 0;
     -3 3 -2 -1;
     2 -2 1 1];
A = C * S;

Qx = zeros(n,1); %global X
Qy = zeros(n,1); %global Y
Curv = zeros(n,1); %curvature

for i = 1:(n+1)
    u = (i-1)/n;
    Qx(i) = u * L + X1;
    y = [1 u u^2 u^3] * A;
    Qy(i) = y;
    
    dy = A(2) + 2 * u * A(3) + 3 * u^2 * A(4);
    ddy = abs(2 * A(3) + 6 * u * A(4));
    Curv(i) = ddy / (1+ dy^2)^1.5;
end

max_M = E * h/2 * max(Curv);