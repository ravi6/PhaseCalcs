function pTFlash(p, T, z)

global Comps

 Nc = Comps.Nc 

 Xguess = 0 ;
 for i = 1:3
   [X, fval, info] = fsolve(@(X) 
     pTflashIdeal(p, T, z, X(1)), Xguess);
   [resid, x, y, vf] =  pTflashIdeal(p, T, z, X(1));
   Xguess = X(1) ;
 end
 [resid, x, y, vf] =  pTflashIdeal(p, T, z, X(1))

Xguess = [x' y' vf];
 [X, fval, info] = fsolve(@(X) 
     pTflash(p, T, z, X(1:Nc)', X(Nc+1:2*Nc)', X(2*Nc+1)), Xguess);
 [resid, x, y, vf] = ...
     pTflash(p, T, z, X(1:Nc)', X(Nc+1:2*Nc)', X(2*Nc+1))

endfunction

%=================================================
function [resid, x, y, vf] = pTflashIdeal(p,T,z,vf)  
%=================================================

global Comps
     K =  VapPress(T, Comps) ./  p ; 
     x = z ./ ( 1 .+ vf * (K .- 1) ) ;
     y = K .* x ;
     del = 1e-10;
     penalty =   sigmoid(vf,del) + sigmoid(1-vf,del);
     resid = sum(y) - sum(x) + penalty  ;
endfunction

%================================================
function [resid, x, y, vf] = pTflash(p,T,z,x,y,vf)
%================================================
global Comps
     
     mix.p = p ; mix.T = T ; mix.z = x ; mix.phase = "L" ;
     mix = pr (mix, Comps) ;  phiL = mix.phi ; 

     mix.z = y ; mix.phase = "V" ;
     mix = pr (mix, Comps) ;  phiV = mix.phi ;

     K =  phiL ./ phiV ;

     del = 1e-10;
     penalty =   sigmoid(vf,del) + sigmoid(1-vf,del);
     resid(1) = sum(y) - sum(x) + penalty ;
     resid(2:5) = (phiV .* y)  .- (phiL .* x) ;
     resid(6:9) = x - z ./ ( 1 .+ vf * (K .- 1) ) ;
endfunction
