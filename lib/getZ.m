%==========================
function Z = getZ(Mix)
%==========================

% Solve for Compressibility for  given T and p from EOS in Cubic Form
% c is the Cubic Equation Coefficient vector 
% If only one real root we are in super-critical or single phase
 
c = Mix.EOS.Cubic ;
r    = roots(c) ;  % roots of a polynomial given its coeffs.

% Grab Real roots only
j    = 0 ;
for i = 1:3
 if abs(imag(r(i)) == 0) 
    j = j + 1;
    rr(j) = real(r(i));
 end
end

if (j == 0) 
   disp("ERROR: No real roots for EOS");
end

if Mix.phase == "L"
  Z =  min(rr);
else
  Z =  max(rr) ;
end

endfunction  % end of Molar Volume Calulation
