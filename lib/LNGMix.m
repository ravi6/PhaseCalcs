function LNGComps = LNGMix(intOFF)
% Author: Ravi Saripalli
% Date: 12th Aug. 2016
% All data based on NIST database
% Warning:  Interaction parameters are not fully populated
% Parameters
% Interaction Parameter on/off switch for testing

Nc = 10;
CH4 = 1 ; C2H6 = 2 ; C3H8 = 3 ;  C4H10 = 4 ;  C5H12 = 5 ; C6H14 = 6 ;
                                iC4H10 = 7 ; iC5H12 = 8 ; CO2 = 9 ; N2 = 10;
Name = {"Methane", "Ethane", "Propane", "Butane", "Pentane", "Hexane", "iButane", "iPentane", "CO2", "Nitrogen"};

Mw = [16.04, 30.07, 44.09, 58.12, 72.15, 86.17, 58.12, 72.15, 44.0, 28.01]' ;     % Molecular weights
pc = [4.600, 4.884, 4.246, 3.800, 3.360, 3.030, 3.650, 3.330, 3.04, 3.394]'*1e6 ;  % Critical Pressure (Pa)
w =  [0.008, 0.098, 0.152, 0.193, 0.251, 0.296, 0.176, 0.227, 0.225, 0.040]' ;       %Eccentricity Factor
Tc = [190.7, 305.4, 369.8, 425.0, 469.8, 508.0, 407.7, 461.0, 738.0, 126.2]' ;     % Critical Temperature (K)

%log10(P(bar) = A - B / (T(K) + C) ;
% Data sourced from webbook.nist.gov
AntCoef.A = [4.22, 3.94, 3.98, 4.708, 3.989, 3.456, 3.944, 3.909, 6.81, 3.74]';
AntCoef.B = [516.7, 659.7, 819.3, 1200.5, 1070.6, 1044.0, 912.1, 1018.5, 1301.7, 264.6]' ;
AntCoef.C = [11.2, -16.7, -24.4, -13.01, -40.45, -53.89,  -29.81, -40.08, -3.494, -6.79]' ;


% Ideal Gas Specific Heat 
%CpIG = Sum (CCp[i] * Tk^i) i=0:3   (J/mol) or (kJ/kmol)

CCp = [
   2.0038e+01   6.5387e-02  -1.3626e-05   6.8806e-10
   1.4122e+01   1.5620e-01  -5.6199e-05   7.1108e-09
   2.0531e+01   1.9595e-01  -2.4797e-05  -1.6328e-08
   2.4012e+01   2.8408e-01  -7.5088e-05  -5.0029e-09
   8.6040e+00   4.3719e-01  -1.9470e-04   3.0475e-08
   5.8063e+00   5.4461e-01  -2.6979e-04   5.0668e-08
   1.5918e+01   3.1008e-01  -9.7711e-05   1.0660e-09
  -2.9049e+00   4.7556e-01  -2.2843e-04   4.2135e-08
   2.0452e+01   6.9577e-02  -4.9462e-05   1.3696e-08
   2.9489e+01  -5.0739e-03   1.3195e-05  -4.9663e-09 ]; 


% Interacion Parameters 
% Need more data here ....  for now what we have is for first four components
%CH4 = 1 ; C2H6 = 2 ; C3H8 = 3 ;  C4H10 = 4 ;  C5H12 = 5 ; C6H14 = 6 ;
%                                iC4H10 = 7 ; iC5H12 = 8 ; CO2 = 9 ; N2 = 10;

% Interaction Parameters extracted from 
%Ref: Semi-empirical correlation for binary interaction parameters
%of the Peng–Robinson equation of state with the van der
%Waals mixing rules for the prediction of high-pressure vapor–liquid equilibrium
%Seif-Eddeen K. Fateen * , Menna M. Khalil, Ahmed O. Elnabawy,
%Journal of Advanced Research (2013) 4, 137–145
k = zeros(Nc, Nc);

k(CH4, C2H6) = -0.0026; 
k(CH4, C3H8) = 0.014; 
k(CH4, C4H10) =  0.0133; 
k(CH4, C5H12) = 0.023;
k(CH4, C6H14) = 0.0422;
k(CH4, iC4H10) = 0.0256; 
k(CH4, iC5H12) = 0.0230;
k(CH4, N2) = 0.0311;
k(CH4, CO2) =  0.1322;


k(C2H6, C3H8) = 0.0011; 
k(C2H6, C4H10) =  0.0096; 
k(C2H6, C5H12) = 0.0;
k(C2H6, C6H14) = -0.01;
k(C2H6, iC4H10) = -0.0067; 
k(C2H6, iC5H12) = 0.0 ;
k(C2H6, N2) = 0.0515;
k(C2H6, CO2) = 0.1322;


k(C3H8, C4H10) = 0 ; 
k(C3H8, C5H12) = 0;
k(C3H8, C6H14) = 0;
k(C3H8, iC4H10) = -0.0078; 
k(C3H8, iC5H12) = 0.0111;
k(C3H8, N2) = 0.0852; 
k(C3H8, CO2) = 0.1241; 

k(C4H10, C5H12) =0.0  ;
k(C4H10, C6H14) = 0.0;
k(C4H10, iC4H10) = 0.0;
k(C4H10, iC5H12) = 0.0;
k(C4H10, N2) =  0.08;
k(C4H10, CO2) = 0.1333 ;


k(C5H12, C6H14) = 0;
k(C5H12, iC4H10) =0 ;
k(C5H12, iC5H12) =0 ;
k(C5H12, N2) =  0.1;
k(C5H12, CO2) =  0.1222;


k(C6H14, iC4H10) = 0 ;
k(C6H14, iC5H12) =  0;
k(C6H14, N2) =   0.1496;
k(C6H14, CO2) =  0.11;


k(iC4H10, iC5H12) = 0;
k(iC4H10, N2) = 0 ;
k(iC4H10, CO2) = 0.12  ;

k(iC5H12, N2) = 0 ;
k(iC5H12, CO2) =  0.1219;

k(N2, CO2) = -0.017  ;

k = k + k' ;
if (intOFF) 
	k = 0 ;
end

LNGComps.k = k ; LNGComps.Mw = Mw ; LNGComps.pc = pc ;
LNGComps.w = w ; LNGComps.Tc = Tc ; LNGComps.CCp = CCp ;
LNGComps.Name = Name ; LNGComps.Nc = Nc ;
LNGComps.AntCoef = AntCoef ;
end
