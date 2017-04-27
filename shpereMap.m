function shpereMap(filename)
orig  = [0 0 0];          % ray's origin
%filename = 'chair_0891.off';%'night_stand_0201.off';%'shpere.off';%%'chair_0891.off';'night_stand_0201.off';
[vertex,face] = read_off(filename);
vertex = vertex';
face =face';
vert1 = vertex(face(:,1),:);
vert2 = vertex(face(:,2),:);
vert3 = vertex(face(:,3),:);

[x,y,z]=sphere(100);
x=x(:);y=y(:);z=z(:);
x=x-mean(x);
y = y-mean(y);
z = z-mean(z);
tri = convhull([x y z]);


nx = length(x);
C = zeros(nx, 1);
for i = 1:nx;
    dir = [x(i),y(i),0];         % ray's direction
    orig(3)  = z(i);             % ray's origin
    dir = dir/sqrt(sum(dir.^2));
    [intersect, t, ~,~,~] = TriangleRayIntersection (...
        orig, dir, vert1, vert2, vert3, 'border','normal');
    if(sum(intersect))
        [CC,~] = max(t(intersect==1));
        C(i) =  CC;
    else
        C(i) = 0;
    end
end
figure,h=trisurf(tri,x,y,z,C,'facecolor','interp');
filename = [filename(1:end-4),'.fig'];
saveas(h,filename,'fig');
end




