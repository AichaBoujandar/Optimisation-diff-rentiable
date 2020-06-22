function [F,G,ind]=OracleGP(q,ind)
 global    r pr    Ar   B q0;
 
 phi=r.*q.*abs(q);
 if ind==2 
     F = 1/3 * q'*phi + pr'*Ar*q;
 end
 if ind==3
    G = Ar'*pr+phi;
 end
 if ind==4
     F = 1/3 * q'*phi + pr'*Ar*q;
     G = Ar'*pr+phi;
 end
end
