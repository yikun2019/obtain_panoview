function flag = AreaMth(P, Triangle)
	A = Triangle(1, :);
	B = Triangle(2, :);
	C = Triangle(3, :);
	% Compute vectors
	v0 = C - A;
	v1 = B - A;
	v2 = P - A;
	% Compute dot products
	dot00 = dot(v0, v0);
	dot01 = dot(v0, v1);
	dot02 = dot(v0, v2);
	dot11 = dot(v1, v1);
	dot12 = dot(v1, v2);
	% Compute barycentric coordinates
	invDenom = 1 / (dot00 * dot11 - dot01 * dot01);
	u = (dot11 * dot02 - dot01 * dot12) * invDenom;
	v = (dot00 * dot12 - dot01 * dot02) * invDenom;
	% Check if point is in triangle
	if u > 0 && v > 0 && u + v < 1
   	 	flag = 1;
	elseif u == 0 || v == 0 || u + v == 1
    	flag = 0;
	else
    	flag = -1;
	end
end