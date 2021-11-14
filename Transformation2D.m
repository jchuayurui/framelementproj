function A = Transformation2D( p,dir )
%Global to Local, dir = 1
if (dir ==1 )
    A = [cos(p), sin(p); -sin(p) , cos(p)];
 %Local to Global, dir = 0
elseif (dir == 0)
    A = [cos(p), -sin(p); sin(p) , cos(p)];
   
end