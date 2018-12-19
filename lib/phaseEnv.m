% Cacluate and display phase envelope of a mixture
% Author: Ravi Saripalli
% Date  : 6th April 2016

%============================================================
function [bubData, dewData] = phaseEnv (z, Bprange, Dprange, 
                                        Tdguess, Tbguess) 
%============================================================

global Comps

  Nc = Comps.Nc ;

i = 1; 

for p = Dprange*1e5
 if ( i == 1 ) 

  %Calculation of Dew  Point (approximate) to get it started
  [X, fval, info] = fsolve(@(X) phaseEqnIdeal(p, X(1), z, "V"), Tdguess) ;
  [resid, x, y] = phaseEqnIdeal(p, X(1), z, "V") ; %we call this to get x
  Xguess = [X(1) x'] ; % Dew Temp and Composition
 end

  %Calculation of Dew  Point (exact)
  [X, fval, info] = fsolve(@(X) phaseEqn(p, X(1), X(2:Nc+1)', z), Xguess);
  [resid, hL, hV] = phaseEqn(p, X(1), X(2:Nc+1)', z);
  Xguess = X ; % ready for next iteration

% Push result into a data structure
  if (info == 1)
    dewData(i).info = info ; dewData(i).p = p*1e-5 ;
    dewData(i).Tdew = X(1)-273.15 ; dewData(i).x = X(2:Nc+1) ;
    dewData(i).hV = hV ;
    i = i + 1 ;
  end
end

%---------------------------------------------------

i = 1; 
for p = Bprange * 1e5

  if (i==1) % Start Guess with ideal assumption 
    %Calculation of Bubble Point (approximate)
   [X, fval, info] = fsolve(@(X) phaseEqnIdeal(p, X(1), z, "L"), Tbguess);
   [resid, x, y] = phaseEqnIdeal(p, X(1), z, "L"); % Call this to get y 
   Xguess = [X(1) y'];  % Bub Temp and Composition
  end

  %Calculation of Bubble  Point (exact)
   [X, fval, info] = fsolve(@(X) phaseEqn(p, X(1), z, X(2:Nc+1)'), Xguess);
   [resid, hL, hV] = phaseEqn(p, X(1), z, X(2:Nc+1)');
   Xguess = X ; % ready for next iteration

% Push result into a data structure
  if (info == 1)
    bubData(i).info = info ; bubData(i).p = p*1e-5 ;
    bubData(i).Tbub = X(1)-273.15 ; bubData(i).x = X(2:Nc+1) ;
    bubData(i).hL = hL ;
     i = i + 1 ;
  end
end

endfunction  %PhaseEnv

%=================================================
function [resid, x, y] = phaseEqnIdeal(p,T,z,phase)  
%=================================================
% x is returned for Vapor - Dew compositon
% y is returned for Liquid - Bub composition

global Comps
     Ki =  VapPress(T, Comps) ./  p ; 
     if (phase == "L")
       y = z .* Ki  ; 
       resid = sum(y) - 1 ;
     else
       x = z ./  Ki ;
       resid = sum(x) - 1 ;
     end
endfunction

%==========================================
function [resid, hL, hV] = phaseEqn(p,T,x,y)
%==========================================
global Comps
     
     mix.p = p ; mix.T = T ; mix.z = x ; mix.phase = "L" ;
     mix = pr (mix, Comps) ;  phiL = mix.phi ; hL = mix.H ; 

     mix.z = y ; mix.phase = "V" ;
     mix = pr (mix, Comps) ;  phiV = mix.phi ; hV = mix.H ;

     resid(1) = sum(y) - sum(x) ;
     resid(2:Comps.Nc+1) = (phiV .* y)  .- (phiL .* x) ;
endfunction
