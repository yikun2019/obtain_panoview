function map=cylinderMap_New(myCylinder, vertex, face)
	orig = myCylinder.orig;
	origX = orig(1);
	origY = orig(2);
	X = myCylinder.X;
	Y = myCylinder.Y;
	Z = myCylinder.Z;

	vert1 = vertex(face(:,1),:);
	vert2 = vertex(face(:,2),:);
	vert3 = vertex(face(:,3),:);

	[m,n,myTri1,myTri2,myTri3]=triangleProjection(myCylinder, vertex, face);
    
    %tic
	whole=wholeFunc(myTri1,myTri2,myTri3,m,n);
    %toc

	[tmp1,~]=size(whole);
    
    	C = zeros(m,n);

    	%tic
	for i=1:tmp1
        	if isempty(whole{i})==0
			[tmp2,~]=size(whole{i});
			for j=1:tmp2
				x=whole{i}(j,1)+1;
				y=whole{i}(j,2)+1;      

				direction = [X(y,x),Y(y,x),0];     % ray's direction
        			direction = direction/sqrt(sum((direction.^2)));
       				[intersect, t, ~,~,~] = TriangleRayIntersection (...
            			[origX,origY,Z(y,x)], direction, vert1(i,:), vert2(i,:), vert3(i,:));
        			if sum(intersect) 
            				[CC,~] = max(t(intersect==1));
            				if CC>=C(y,x)
            					C(y,x) = CC;
               		 		end
            			end
       			end
       	 	end
    	end
    	%toc
	map = mat2gray(C);
end



