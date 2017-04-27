function [m,n,myTri1,myTri2,myTri3]=triangleProjection(myCylinder, vertex, face)

	X = myCylinder.X;
	orig=myCylinder.orig;

	[face_x,~]=size(face);
	%[vertex_x,vertex_y]=size(vertex);
	%triangle=zeros(face_x,2);

	tri1 = vertex(face(:,1),:);
	tri2 = vertex(face(:,2),:);
	tri3 = vertex(face(:,3),:);

	tri1(:,1)=tri1(:,1)-orig(1);
	tri1(:,2)=tri1(:,2)-orig(2);
	tri2(:,1)=tri2(:,1)-orig(1);
	tri2(:,2)=tri2(:,2)-orig(2);
	tri3(:,1)=tri3(:,1)-orig(1);
	tri3(:,2)=tri3(:,2)-orig(2);


	myTri1=zeros(face_x,2);
	myTri2=zeros(face_x,2);
	myTri3=zeros(face_x,2);

	[m,n]=size(X);

	[TH,R,Z] = cart2pol(tri1(:,1),tri1(:,2),tri1(:,3));	
	TH(TH<0)=TH(TH<0)+2*pi;
	myTri1(:,1)=TH/(2*pi)*m+1;
	myTri1(:,2)=(Z-min(Z))/(max(Z)-min(Z))*n+1;
    
    [TH,R,Z] = cart2pol(tri2(:,1),tri2(:,2),tri2(:,3));	
	TH(TH<0)=TH(TH<0)+2*pi;
	myTri2(:,1)=TH/(2*pi)*m+1;
	myTri2(:,2)=(Z-min(Z))/(max(Z)-min(Z))*n+1;

	[TH,R,Z] = cart2pol(tri3(:,1),tri3(:,2),tri3(:,3));
	TH(TH<0)=TH(TH<0)+2*pi;
	myTri3(:,1)=TH/(2*pi)*m+1;
	myTri3(:,2)=(Z-min(Z))/(max(Z)-min(Z))*n+1;
end


