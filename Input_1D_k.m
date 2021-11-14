function KGlobal = Input_1D_k(k )
Ktemp = zeros(6,6);
Ktemp(1,1) = k(1,1);
Ktemp(4,1)= k(2,1);
Ktemp(1,4)= k(1,2);
Ktemp(4,4) = k(2,2);
KGlobal = Ktemp;
end