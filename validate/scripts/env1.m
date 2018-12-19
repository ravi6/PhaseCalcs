function env1 
global Comps

  z = [0.5 0.4 0.05 0.05]' ; 
  Bprange = [1:79]  ; Dprange = [1:79] ;
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

endfunction
