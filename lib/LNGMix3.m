function LNGComps = LNGMix3()
% Author: Ravi Saripalli
% Date: 6th April 2016
% All data based on NIST database
% Warning:  Interaction parameters are not fully populated
% Parameters

Nc = 7 ;
CH4 = 1 ; C2H6 = 2 ; C3H8 = 3 ; N2 = 4; iC4H10 = 5 ; C4H10 = 6 ; iC5H12 = 7 ;
Name = {"Methane", "Ethane","Propane", "Nitrogen", "iButane", "Butane", "iPentane"};
Mw = [16.04, 30.07, 44.09, 28.01, 58.12, 58.12, 72.15 ]';		% Molecular weights
pc = [4.600, 4.884, 4.246, 3.394, 3.65, 3.80, 3.33 ]'*1e6 ; 	% Critical Pressure (Pa) 
w  = [0.0080,  0.0980, 0.1520, 0.0400, 0.176, 0.193, 0.227 ]' ; 	% Eccentricity Factor
Tc = [190.7, 305.4, 369.8, 126.2, 407.7, 425.0, 461.0]' ; 	% Critical Temperature (K)

%log10(P(bar) = A - B / (T(K) + C) ;
% Data sourced from webbook.nist.gov
AntCoef.A = [4.22, 3.94, 3.98, 3.74, 3.944, 4.708, 3.909]'; 
AntCoef.B = [516.7, 659.7, 819.3, 264.6, 912.1, 1200.5, 1018.5]';
AntCoef.C = [11.2, -16.7, -24.4, -6.79, -29.81, -13.01, -40.08]';

% Ideal Gas Specific Heat 
%CpIG = Sum (CCp[i] * Tk^i) i=0:3   (J/mol) or (kJ/kmol)

CCp = [   2.0038e+01   6.5387e-02  -1.3626e-05   6.8806e-10
          1.4122e+01   1.5620e-01  -5.6199e-05   7.1108e-09
          2.0531e+01   1.9595e-01  -2.4797e-05  -1.6328e-08
          2.9489e+01  -5.0739e-03   1.3195e-05  -4.9663e-09
          1.5918e+01   3.1008e-01  -9.7711e-05   1.0660e-09
          2.4012e+01   2.8408e-01  -7.5088e-05  -5.0029e-09
         -2.9049e+00   4.7556e-01  -2.2843e-04   4.2135e-08  ] ;

% Interacion Parameters 
% Need more data here ....  for now what we have is for first four components
%CH4 = 1 ; C2H6 = 2 ; C3H8 = 3 ; N2 = 4 iC4H10 = 5 ; C4H10 = 6 ; iC5H12 = 7 ;
k=zeros(Nc, Nc) ;
k(CH4, CH4)   = 0   ; k(CH4, C2H6) = -0.003 ; k(CH4, C3H8) = 0.016 ; k(CH4, N2) = 0.03 ;
k(C2H6, C2H6) = 0   ; k(C2H6, C3H8) = 0.001  ; k(C2H6, N2) = 0.044  ;
k(C3H8, C3H8) = 0   ; k(C3H8, N2)   = 0.078  ; 
k(N2, N2)     = 0   ; 
k = k + k';

LNGComps.k = k ; LNGComps.Mw = Mw ; LNGComps.pc = pc ;
LNGComps.w = w ; LNGComps.Tc = Tc ; LNGComps.CCp = CCp ;
LNGComps.Name = Name ; LNGComps.Nc = Nc ;
LNGComps.AntCoef = AntCoef ;
end
