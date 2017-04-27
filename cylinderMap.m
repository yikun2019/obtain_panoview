function map = cylinderMap(myCylinder, vertex, face)
orig = myCylinder.orig;
origX = orig(1);
origY = orig(2);
X = myCylinder.X;
Y = myCylinder.Y;
Z = myCylinder.Z;

vert1 = vertex(face(:,1),:);
vert2 = vertex(face(:,2),:);
vert3 = vertex(face(:,3),:);
[m, n] = size(X);
C = zeros(m, n);
for i = 1:m;
    parfor j = 1:n
        direction = [X(i,j),Y(i,j),0];     % ray's direction
        direction = direction/sqrt(sum((direction.^2)));
        [intersect, t, ~,~,~] = TriangleRayIntersection (...
            [origX,origY,Z(i,j)], direction, vert1, vert2, vert3);
        if(sum(intersect))
            [CC,~] = max(t(intersect==1));
            C(i,j) =  CC;
        else
            C(i,j) = 0;
        end
    end
end
map = mat2gray(C);
end