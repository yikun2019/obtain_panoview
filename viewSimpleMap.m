clc,clear;

srcModel = '../roughTest/srcModel/';
savePath = '../roughTest/simpleMap/';
fileList = ls([srcModel, '*.off']);

nfile = length(fileList);
fileList = cellstr(fileList);
for i = 1:nfile
    fileName = strcat(srcModel, fileList{i});
    [vertex,face] = read_off(fileName);
    vertex = vertex';
    face = face';
    tri1 = vertex(face(:,1),:);
    tri2 = vertex(face(:,2),:);
    tri3 = vertex(face(:,3),:);
    area = triangleArea3d(tri1,tri2,tri3);
    meantri = (tri1+tri2+tri3)/3;
    for jj = 1:size(meantri, 1)
        meantri(jj,:) = meantri(jj,:)*area(jj);
    end
    orig = sum(meantri,1)./sum(area);
    
    zmin = min(vertex(:,3));
    zmax = max(vertex(:,3));
    h = figure;
    trisurf(face, vertex(:,1),vertex(:,2),vertex(:,3),'FaceAlpha', 0.5);
    P = [orig(1), orig(2), zmin; orig(1), orig(2), zmax];
    line(P(:,1),P(:,2),P(:,3),'Color','r','LineWidth',3);
    saveas(h,[savePath, fileList{i}, '.fig'], 'fig');
    if mod(i,20)==0
        close all;
    end
end
    
    
