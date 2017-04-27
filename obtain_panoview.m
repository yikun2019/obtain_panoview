function exMap = obtain_panoview(fileName)
%tic
[vertex,face] = read_off(fileName);
vertex = vertex';
face =face';
%% use main axies
%[primaryAxies, U, area] = find_main_axies(vertex, face, opt);
%vertex = transformCoord(vertex, primaryAxies, U);

%% construct cylinder for panoramic rendering
myCylinder = cylinderConstruct(vertex);

%% find the origin of the cylinder by using face area as weights
tri1 = vertex(face(:,1),:);
tri2 = vertex(face(:,2),:);
tri3 = vertex(face(:,3),:);
area = triangleArea3d(tri1,tri2,tri3);
meantri = (tri1+tri2+tri3)/3;
for jj = 1:size(meantri, 1)
    meantri(jj,:) = meantri(jj,:)*area(jj);
end
myCylinder.orig = sum(meantri,1)./sum(area);
origMap = cylinderMap_New(myCylinder, vertex, face);
exMap = extendMap(origMap);
%toc
end