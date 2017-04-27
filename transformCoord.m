function pointSet = transformCoord(pointSet, primaryAxies, U)
%% transform axies z to primaryAxies, and hold the same origin
if U(3,1)<0
    U = -1*U;
end
transR = [U(:,3),U(:,2),U(:,1)]';
% testSet = pointSet*[U(:,3)/norm(U(:,3)), U(:,2)/norm(U(:,2)),U(:,1)/norm(U(:,1))];
pointSet = pointSet/transR;
% error = testSet - pointSet;
% norm(error(:))
end