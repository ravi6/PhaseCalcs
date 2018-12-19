%=================================================
function [xp, yp] = joinSpline(xd,yd,xb,yb)
%=================================================
    %pick n points of each segment (bub and dew curves)
    % use arclength for interpolation/extrapolation
    % no need to worry about x being monotonic
       n = 3 ;
       x = [xb(end-n:end) xd(end:-1:end-n)] ; % top end of curve segment
       y = [yb(end-n:end) yd(end:-1:end-n)] ; %       ""
       s(1) = 0 ;

       for i = 2:size(x,2) 
	       s(i) = s(i-1) + (x(i)-x(i-1))^2 + (y(i)-y(i-1))^2 ;
       end 
       
       % Now get points in the gap smoothly
       s1 = s(n+1) ; s2 = s(n+2) ; alen = [s1 : (s2-s1)/10 : s2] ;
       xp = spline(s,x,alen);
       yp = spline(s,y,alen); 
end % joinSpline
