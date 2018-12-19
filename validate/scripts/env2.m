function env2 
global Comps

% Typical LNG composition
  z  = [0.92 0.05 0.01 0.02]' ;
  Bprange = [1:56]  ;
  Dprange = [[1:56] [56.5:0.5:57]] ;
  Tdguess = -50 + 273.15 ; Tbguess = -50 + 273.15 ;
  Trange = [-70 : 0.5 : -63] ; % Interpolation near critical region

  Comps = LNGMix1 ; 
  [bubData, dewData] = phaseEnv (z, Bprange, Dprange,
                            Tdguess, Tbguess, Trange) ; 

  figure(); %let us produce the phase Envelope plot
   hold off ; plot([dewData(:).Tdew], [dewData(:).p], '-r');
   hold on ; plot([bubData(:).Tbub], [bubData(:).p], '-b');
  legend({"DewPt", "BubPt"},"location","northwest") ;
  grid on ; xlabel("T(C)"); ylabel("Pressure(bar)");

  print(gcf,"phaseEnv.png","-S640,480");
endfunction
