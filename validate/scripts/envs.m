function envs 

%Test how sensitive is the Phase Env to composition Changes
  figure(); %let us produce the phase Envelope plot
  hold on ;
  %z = [0.92 0.05 0.02 0.01]' ; testme(z) ; 
  %z = [0.92 0.04 0.03 0.01]' ; testme(z) ; 
  %z = [0.95 0.01 0.03 0.01]' ; testme(z) ;
  z = [0.95 0.02 0.01 0.02 0 0 0]' ; testme(z) ;
% z = [0.95 0.02 0.00 0.02 0.00 0.00 0.01]' ; testme(z) ;

  legend({"DewPt", "BubPt"},"location","northwest") ;
  grid on ; xlabel("T(C)"); ylabel("Pressure(bar)");
endfunction

function testme(z)
global Comps
  Bprange = [1:52]  ; Dprange = [1:52] ;
  Tdguess = -50 + 273.15 ; Tbguess = -50 + 273.15 ;
  Trange = [-70 : 0.5 : -63] ; % Interpolation near critical region

  Comps = LNGMix4(true); 
  [bubData, dewData] = phaseEnv (z, Bprange, Dprange,
                            Tdguess, Tbguess, Trange) ; 

  xd = [dewData(:).Tdew] ; yd = [dewData(:).p];
  xb = [bubData(:).Tbub]; yb = [bubData(:).p];

  plot(xd, yd, '-r');
  plot(xb, yb, '-b');

   [xi, yi] = joinSpline(xd,yd,xb,yb) ;
   plot(xi,yi,'-m');

endfunction
