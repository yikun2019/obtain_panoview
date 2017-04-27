function myCylinder = cylinderConstruct(pointSet, cylinderSize)
%construct an cylinder
%[X, Y, Z, orig]
if(nargin == 2)
    nhordiv = cylinderSize(1);
    nverdiv = cylinderSize(2);
else
    nhordiv = 800;%2*pi*1
    nverdiv = 400;%round(nhordiv*(zmax-zmin)/(2*pi));
end
zmax = max(pointSet(:,3));
zmin = min(pointSet(:,3));
[x,y,z] = cylinder(ones(nverdiv,1),nhordiv);
x = x-mean(mean(x)*(mean(x(:))>10e-3));
y = y-mean(mean(y)*(mean(y(:))>10e-3));
maxz = max(max(z));   
minz = min(min(z));
z = (z-minz)*(zmax - zmin)/(maxz-minz)+zmin ;

origX = mean(pointSet(:,1));
origY = mean(pointSet(:,2));
origZ = 0;
orig = [origX, origY, origZ];

myCylinder.X = x;
myCylinder.Y = y;
myCylinder.Z = z;
myCylinder.orig = orig;
end

