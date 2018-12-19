function LNGComps = LNGMix2()
% Same as LNGMix1 but uses NIST Data set
% Parameters

Nc = 4 ;
CH4 = 1 ; C2H6 = 2 ; C3H8 = 3 ; N2 = 4 ;
Name = {"Methane", "Ethane","Propane", "Nitrogen"};
Mw = [16.0 30.0 44.0 28.0]';		% Molecular weights
pc = [4.600 4.884 4.246 3.394]'*1e6 ; 	% Critical Pressure (Pa) 
w  = [0.0080  0.0980 0.1520 0.0400]' ; 	% Eccentricity Factor
Tc = [190.7 305.4 369.8 126.2]' ; 	% Critical Temperature (K)

%log10(P(bar) = A - B / (T(K) + C) ;
% Data sourced from webbook.nist.gov
AntCoef.A = [4.22, 3.94, 3.98, 3.74]';
AntCoef.B = [516.7, 659.7, 819.3, 264.6]';
AntCoef.C = [11.2, -16.7, -24.4, -6.79]';

% Ideal Gas Specific Heat 
%CpIG = Sum (CCp[i] * Tk^i) i=1:4   (J/mol) or (kJ/kmol)
%CCp = [1.9874E+01, 5.0208E-02, 1.2678E-05, -1.1004E-08;
%       6.8952E+00, 1.7255E-01, -6.4015E-05, 7.2802E-09;
%       6.8000E+01, 2.2600E-01, -1.3100E-04, 3.1700E-08;
%       2.8882E+01, -1.5703E-03, 8.0751E-06, -2.8706E-09];  % Cp Ideal gas Poly Coefs.  

CCp = [2.0038e+01   6.5387e-02  -1.3626e-05   6.8806e-10
       1.4122e+01   1.5620e-01  -5.6199e-05   7.1108e-09
       2.0531e+01   1.9595e-01  -2.4797e-05  -1.6328e-08
       2.9489e+01  -5.0739e-03   1.3195e-05  -4.9663e-09];

% Interacion Parameters 
k(CH4, CH4)   = 0   ; k(CH4, C2H6) = -0.003 ; k(CH4, C3H8) = 0.016 ; k(CH4, N2) = 0.03 ;
k(C2H6, C2H6) = 0   ; k(C2H6, C3H8) = 0.001  ; k(C2H6, N2) = 0.044  ;
k(C3H8, C3H8) = 0   ; k(C3H8, N2)   = 0.078  ; 
k(N2, N2)     = 0   ; 
k = k + k';
%k = k * 0 ;

LNGComps.k = k ; LNGComps.Mw = Mw ; LNGComps.pc = pc ;
LNGComps.w = w ; LNGComps.Tc = Tc ; LNGComps.CCp = CCp ;
LNGComps.Name = Name ; LNGComps.Nc = Nc ;
LNGComps.AntCoef=AntCoef ;
endfunction
