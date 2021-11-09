function KGlobal = Input_1D_k(k )
Ktemp = zeros(4,4);
Ktemp(1,1) = k(1,1);
Ktemp(3,1)= k(2,1);
Ktemp(1,3)= k(1,2);
Ktemp(3,3) = k(2,2);
KGlobal = Ktemp;
end