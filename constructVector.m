function U = constructVector(zAxies)

assert(norm(zAxies)>eps);
xAxies =zeros(1,3);
yAxies =zeros(1,3);
xAxies = rand(1,3);
i = 0;
while (~norm(xAxies))||(~norm(yAxies))
    i = i+1;
    m = mod(i-1,3)+1;
    n = mod(i+1,3)+1;
    if zAxies(i)
        xAxies(i) = -(xAxies(m)*zAxies(m)+xAxies(n)*zAxies(n))/zAxies(i);
        xAxies = xAxies/sqrt(norm(xAxies));
        yAxies = cross(xAxies, zAxies);
    end
end
yAxies = yAxies/sqrt(norm(yAxies));
U = [xAxies;yAxies;zAxies];
x = dot(U(1,:),U(2,:));
y = dot(U(1,:),U(3,:));
z = dot(U(3,:),U(2,:));
end


