function p_dst = pixel2polar(p_src, orgin)
%p_src the pixel to be converted
%orgin is the orgin point 

d_vector = (p_src-orgin);

x = d_vector(1);
y = d_vector(2);
z = d_vector(3);

distance = sqrt(sum(d_vector.^2));
theta = acos(z/distance)*180/pi;%0~180
fai = atan2(y,x)*180/pi;%-180~180

p_dst =[theta, fai, distance];
