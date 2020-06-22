function Px=Projection(q,Ad,fd)


Px = q - Ad'*inv(Ad*Ad')*(Ad*q-fd);

end