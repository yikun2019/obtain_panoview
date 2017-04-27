function whole=wholeFunc(myTri1,myTri2,myTri3,m,n)

	max_tri=max(max(myTri1,myTri2),myTri3);
	min_tri=min(min(myTri1,myTri2),myTri3);
	mid_tri=min(min(max(myTri1,myTri2),max(myTri1,myTri3)),max(myTri2,myTri3));
    
    diff1=max_tri-min_tri;
    diff2=mid_tri-min_tri;

	i1=find(diff1(:,1)>n/2);
    myTri1(i1(myTri1(i1,1)==max_tri(i1,1)),1)=myTri1(i1(myTri1(i1,1)==max_tri(i1,1)),1)-n;
    myTri2(i1(myTri2(i1,1)==max_tri(i1,1)),1)=myTri2(i1(myTri2(i1,1)==max_tri(i1,1)),1)-n;
    myTri3(i1(myTri3(i1,1)==max_tri(i1,1)),1)=myTri3(i1(myTri3(i1,1)==max_tri(i1,1)),1)-n;
    
    i2=find(diff2(:,1)>n/2);
    myTri1(i2(myTri1(i2,1)==mid_tri(i2,1)),1)=myTri1(i2(myTri1(i2,1)==mid_tri(i2,1)),1)-n;
    myTri2(i2(myTri2(i2,1)==mid_tri(i2,1)),1)=myTri2(i2(myTri2(i2,1)==mid_tri(i2,1)),1)-n;
    myTri3(i2(myTri3(i2,1)==mid_tri(i2,1)),1)=myTri3(i2(myTri3(i2,1)==mid_tri(i2,1)),1)-n;
    
    max_tri=max(max(myTri1,myTri2),myTri3);
	min_tri=min(min(myTri1,myTri2),myTri3);
	%mid_tri=min(min(max(myTri1,myTri2),max(myTri1,myTri3)),max(myTri2,myTri3));

	[x,~]=size(myTri1);

	whole=cell(x,1);

	parfor j=1:x
		bottom_x=ceil(min_tri(j,1));
		top_x=floor(max_tri(j,1));
		long_x=top_x-bottom_x+1;
		%temp_x=[];
		%q=1;
		%for p=bottom_x:top_x
		%	temp_x(q)=p;
		%	q=q+1;
        %end
        
        temp_x=bottom_x:1:top_x;

		bottom_y=ceil(min_tri(j,2));
		top_y=floor(max_tri(j,2));
		long_y=top_y-bottom_y+1;
		%temp_y=[];
		%q=1;
		%for p=bottom_y:top_y
		%	temp_y(q)=p;
		%	q=q+1;
        %end
        temp_y=bottom_y:1:top_y;
        

        

        temp=[];
		q=1;
		for a=1:long_x
			for b=1:long_y
				%point=[temp_x(a),temp_y(b)];
				%triangle=[myTri1(j,1),myTri1(j,2);myTri2(j,1),myTri2(j,2);myTri3(j,1),myTri3(j,2)];
				%flag=AreaMth(point,triangle);
				%if flag~=-1
					if temp_x(a)<0
						temp_x(a)=temp_x(a)+n;
					end
					temp(q,:)=[temp_x(a),temp_y(b)];
                    q=q+1;
               % end
			end
		end
		whole{j}=temp;
    end
end






