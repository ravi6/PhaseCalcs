function [xi, yi] = bezier(x,y)
%Simple bezier interpolation between two points
%End point points are connected points
%Middle points are just control points

cx = 3*(x(2) - x(1)) ;
bx = 3*(x(3) - x(2)) - cx ;
ax = x(4) - x(1) - cx - bx ;

cy = 3*(y(2) - y(1)) ;
by = 3*(y(3) - y(2)) - cy ;
ay = y(4) - y(1) - cy - by ;

t=[0:0.05:1] ;
xi=ax * t.^3 + bx * t.^2 + cx * t + x(1)  ;
yi=ay * t.^3 + by * t.^2 + cy * t + y(1)  ;
end
