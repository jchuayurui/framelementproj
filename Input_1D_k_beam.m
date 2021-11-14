function KGlobal = Input_1D_k_beam(k )
Ktemp = zeros(6,6);
Ktemp(2,2) = k(1,1);
Ktemp(2,3) = k(1,2);
Ktemp(2,5) = k(1,3);
Ktemp(2,6) = k(1,4);

Ktemp(3,2) = k(2,1);
Ktemp(3,3) = k(2,2);
Ktemp(3,5) = k(2,3);
Ktemp(3,6) = k(2,4);

Ktemp(5,2) = k(3,1);
Ktemp(5,3) = k(3,2);
Ktemp(5,5) = k(3,3);
Ktemp(5,6) = k(3,4);

Ktemp(6,2) = k(4,1);
Ktemp(6,3) = k(4,2);
Ktemp(6,5) = k(4,3);
Ktemp(6,6) = k(4,4);
KGlobal = Ktemp;
end