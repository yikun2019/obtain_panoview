function [primaryAxies, U, area]= find_main_axies(vertex, face, opt, orig)
%% parameter preprocess
if(isfield (opt,'axiesStyle'))
    axiesStyle = opt.axiesStyle;
else
    axiesStyle = 'point';
end

%% compute the axies
if strcmp(axiesStyle,'point')
    area = [];
    [primaryAxies, U] = pca_axies(vertex);
else
    tri1 = vertex(face(:,1),:);
    tri2 = vertex(face(:,2),:);
    tri3 = vertex(face(:,3),:);
    normVerctor = triangleNormVector(tri1,tri2,tri3);
    area = triangleArea3d(tri1,tri2,tri3);
    for i =1:length(area)
        normVerctor(i,:) = normVerctor(i,:)*area(i);
    end
    [primaryAxies, U] = pca_axies(normVerctor);   
end
%% debug info
% if(isfield(opt, 'dbug') && opt.dbug)
%     ratio = 50;
%     if ~(nargin == 4)
%         orig = [0, 0, 0];
%     end
%     %primaryAxies =[0,0,1];
%     figure, title('primaryAxiesDisplay'), trisurf(face, vertex(:,1),vertex(:,2),vertex(:,3),'FaceAlpha', 0.5);
%     line('XData',orig(1)+[0 ratio*primaryAxies(1)],'YData',orig(2)+[0 ratio*primaryAxies(2)],'ZData',...
%     orig(3)+[0 ratio*primaryAxies(3)],'Color','r','LineWidth',3)
% end

end


function [primaryAxies, U] = pca_axies(pointSet)
%compute the primaryAxies of pointSet, n*1 vector will be returned
% pointSet is a m*n mat, m denotes the num of point
X = pointSet; % just for convience
m = size(X, 1);
Cov = 1 / m * X' * X;
[U, ~, ~] = svd(Cov);
primaryAxies = U(:,1);
primaryAxies = primaryAxies/(sum(primaryAxies(:).^2));
if primaryAxies(end,:)<0
    primaryAxies = -1*primaryAxies;
end
end

