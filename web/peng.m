%Author: Ravi Sariplli
%Date: 6th April 2016

function peng(z, bPMax, dPMax)
global Comps

% Typical LNG composition
% z  = [0.92 0.05 0.01 0.02]' ;
% z  = [0.95 0.03 0.01 0.00 0 0.01 0]' ;
% z  = 100*[0.97 0.03 0 0 0 0 0 0 0 0]' ;
  z = z' / 100 ;  % Composition in fractions
  Bprange = [1:bPMax]; Dprange = [1:dPMax];
  Tdguess = -50 + 273.15 ; Tbguess = -50 + 273.15 ;

  Comps = LNGMix(0) ; % 0 -> using interaction params
  [bubData, dewData] = phaseEnv (z, Bprange, Dprange,
                            Tdguess, Tbguess) ; 

  xd = [dewData(:).Tdew] ; yd = [dewData(:).p];
  xb = [bubData(:).Tbub];  yb = [bubData(:).p];

%let us produce the phase Envelope plot  
  if (h=figure()) 
    set(h,'visible',false);
  endif 

  hold off ; plot(xd, yd, '-r');
  hold on ;  plot(xb, yb, '-b');
  legend({"DewPt", "BubPt"},"location","northwest") ;
  grid on ; xlabel("T(C)"); ylabel("Pressure(bar)");

  %Add interpolation bit
   %[xi, yi] = joinSpline(xd,yd,xb,yb) ;
   %plot(xi,yi,'-m');

%Save plot 
  print(gcf,"peng.png","-S640,480");

%Save plot Data
DewPointCurve=[xd' yd'];
BubPointCurve=[xb' yb'];
%IntpolCurve=[xi' yi'];
LNGComposition=z;
CompNames=sprintf("%s : ",Comps.Name{});
save  peng.txt CompNames LNGComposition DewPointCurve BubPointCurve ;
endfunction
