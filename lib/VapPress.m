%=================================
function Psat = VapPress(Tk, Comps)
%=================================

% Calculate Vapor Pressures (Pa) 
%of Components in Mixture at Tk

 Psat =  Comps.AntCoef.A  ...
         .- Comps.AntCoef.B ./ (Tk + Comps.AntCoef.C) ;
 Psat = 1e5 * (10.^Psat)  ; % in Pascals

endfunction
