%=================================================
function [xp, yp] = joinBezier(xd,yd,xb,yb)
%=================================================
% Thick clunky code is to circumvent buggy interp1 
% we choose two control points in the gap
% choose these points such that when each curve is locally
% linearly extrapolated into he gap quarter the horizontal
% gap length (in x direction) Then use bezier curve to fillet.

 dx = (xd(end) - xb(end))/3.0 ;
 x = [xb(end) xb(end)+dx xd(end)-dx xd(end)]; 
 y2 = yb(end) + (x(2)-xb(end)) \
            * (yb(end)-yb(end-1))/(xb(end)-xb(end-1)) ;
 y3 = yd(end) + (x(3)-xd(end)) \
            * (yd(end)-yd(end-1))/(xd(end)-xd(end-1)) ;
 y = [yb(end) y2 y3 yd(end)]; 

      plot(x,y,'og');
      [xp,yp]= bezier(x,y);
%      plot(xp,yp,'-m');  % Interpolated curve
end % End of joinCurves
