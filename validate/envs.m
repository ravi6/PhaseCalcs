function envs()

%Names=["C1","C2","C3","iC4","nC4","iC5","N2"];
%z = [92.02 5.09 1.95 0.34 0.45 0.02 0.12];

  figure(); %let us produce the phase Envelope plot
  hold on ;
%Names=["C1","C2","C3","N2", "iC4","nC4","iC5"];
z = [92.02 5.09 1.95 0.12 0.34 0.45 0.02]'/100;
CCs = LNGMix4(false) ;testme(z,CCs);
  z = [92 4 3 0.4 0.38 0.22 0.00]'/100 ; testme(z,CCs) ;
%CCs = LNGMix3 ;testme(z,CCs);

data = load("data") ;
plot(data(:,1),data(:,2)+1,'o');
  legend({"DewPt", "BubPt"},"location","northwest") ;
  grid on ; xlabel("T(C)"); ylabel("Pressure(bar)");
endfunction

function testme(z,CCs)
global Comps
  Comps = CCs ;
  Bprange = [1:65]  ; Dprange = [1:65] ;
  Tdguess = -50 + 273.15 ; Tbguess = -50 + 273.15 ;
  Trange = [-70 : 0.5 : -63] ; % Interpolation near critical region

  [bubData, dewData] = phaseEnv (z, Bprange, Dprange,
                            Tdguess, Tbguess, Trange) ; 

   plot([dewData(:).Tdew], [dewData(:).p], '-r');
   plot([bubData(:).Tbub], [bubData(:).p], '-b');

endfunction
