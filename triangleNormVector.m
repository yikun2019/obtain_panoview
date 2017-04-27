function normVector = triangleNormVector(pt1, pt2, pt3)
%TRIANGLEAREA3D Area of a 3D triangle
%
%   normVector = triangleNormVector(P1, P2, P3)
%   Computes normVector of the 3D triangle whose vertices are given by P1, P2 and
%   P3. Each vertex is either a 1-by-3 row vector, or an array with 3
%   columns, each column representing coordinate of a vertex.
%   The result AREA has as many rows as the number of rows of the largest
%   input array.

%   Concatenates vertex coordinates in a 3-by-3 array. Each row of the
%   array contains coordinates of one vertex.
%
%
%   Example
%   triangleNormVector([10 10 10], [30 10 10], [10 40 10])
%   ans = 
%       300

if nargin == 1
    pt2 = pt1(2,:);
    pt3 = pt1(3,:);
    pt1 = pt1(1,:);
end

% compute individual vectors
v12 = bsxfun(@minus, pt2, pt1);
v13 = bsxfun(@minus, pt3, pt1);

% compute area from cross product
normVector = cross(v12,v13,2);
sqrtNorm = vectorNorm3d(normVector);
addColunm = eps*ones(size(sqrtNorm, 1), 1);
sqrtNorm = [sqrtNorm, addColunm];
sqrtNorm = repmat(max(sqrtNorm,[],2),1,3);
normVector = normVector./sqrtNorm;
end