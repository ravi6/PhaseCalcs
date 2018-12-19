function phFlash

global LNGComps
 
  LNGComps = getLNGComps() ;
 
  z = [0.5 0.4 0.05 0.05]' ; p = 3 * 1e5 ; T = -150 + 273 ;
  mix.p = p ; mix.T = T ; mix.z = z ; mix.phase = "V" ;
  mix = pr (mix, LNGComps) ; 
  disp(mix.H); H = mix.H ;

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
     pTflash(p, T, z, X(1:4)', X(5:8)', X(9)), Xguess);
 [resid, x, y, vf] =  pTflash(p, T, z, X(1:4)', X(5:8)', X(9))

break ; 

 [resid, x, y] = phaseEqnIdeal(p, X(1), z, "L"); % Call this to get y 
 Xguess = [X(1) y'];  % Bub Temp and Composition

 Xguess = [mix.T 0.0 z' [0.2 0.2 0.2 0.2]];
 [X, fval, info] = fsolve(@(X) 
  phFlashEqn(p,z,H, X(1),X(2),X(3:6)',X(7:10)'), Xguess);
  printme(info, p, H, X, fval) ;

i=1 ; Hold = H ;
for i = 1:0
 H = H + abs(H) * 0.001 ;
 [X, fval, info] = fsolve(@(X) 
  phFlashEqn(p,z,H, X(1),X(2),X(3:6)',X(7:10)'), Xguess);
  printme(info, p, H, X, fval) ;
 
  Xguess = X ;
  i = i + 1;
 end
endfunction

%==========================================
function resid = phFlashEqn(p,z,H,T,vf,x,y)
%==========================================
global LNGComps
     

     mix.p = p ; mix.T = T ; 
     mix.z = x ; mix.phase = "L" ;
     mix = pr (mix, LNGComps) ; phiL = mix.phi ; hL = mix.H ;

     mix.z = y ; mix.phase = "V" ;
     mix = pr (mix, LNGComps) ;  phiV = mix.phi ; hV = mix.H ;

     del = 1e-8 ;
     penalty1 =   sigmoid(vf,del) + sigmoid(1-vf,del);
     penalty2 =   sum(sigmoid(x,del)) + sum(sigmoid(y,del)) ;
     penalty3 =   sum(sigmoid(1-x,del)) + sum(sigmoid(1-y,del)) ;
     penalty = penalty1 + penalty2 + penalty3;

     resid(1) = 1 - vf * hV / H - (1 - vf) * hL / H    + penalty ;
     resid(2) = sum(x) - sum(y)  + penalty   ;
     resid(3:6) = (phiV .* y)  .- (phiL .* x)   + penalty ;
     resid(7:10) = z .- vf * y .- (1 - vf) * x + penalty  ;
endfunction

function printme(info, p, H, X, fval)
  printf("[%i] p=%5.1f H=%5.1f  T=%5.1f Vf=%5.1f", 
          info, p*1e-5, H*1e-3, X(1)-273, X(2));  printf("   ") ;
  printf("%5.2f",  X(3:6)); printf("    ") ; printf("%5.2f",  X(7:10)); 
  printf("  Max.fval = %g",max(abs(fval))); 
  printf("\n");
endfunction

%=================================================
function [resid, x, y, vf] = pTflashIdeal(p,T,z,vf)  
%=================================================

global LNGComps
     K =  VapPress(T, LNGComps) ./  p ; 
     x = z ./ ( 1 .+ vf * (K .- 1) ) ;
     y = K .* x ;
     del = 1e-10;
     penalty =   sigmoid(vf,del) + sigmoid(1-vf,del);

       resid = sum(y) - sum(x) + penalty  ;
endfunction

%================================================
function [resid, x, y, vf] = pTflash(p,T,z,x,y,vf)
%================================================
global LNGComps
     
     mix.p = p ; mix.T = T ; mix.z = x ; mix.phase = "L" ;
     mix = pr (mix, LNGComps) ;  phiL = mix.phi ; 

     mix.z = y ; mix.phase = "V" ;
     mix = pr (mix, LNGComps) ;  phiV = mix.phi ;

     K =  phiL ./ phiV ;

     del = 1e-10;
     penalty =   sigmoid(vf,del) + sigmoid(1-vf,del);
     resid(1) = sum(y) - sum(x) + penalty ;
     resid(2:5) = (phiV .* y)  .- (phiL .* x) ;
     resid(6:9) = x - z ./ ( 1 .+ vf * (K .- 1) ) ;
endfunction
