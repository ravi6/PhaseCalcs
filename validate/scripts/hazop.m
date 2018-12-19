function hazop(opt)
%All thermodynamic properties are derived from
% Peng Robinson EOS for Mitures under Non-ideal conditions

% Calculations with Typical LNG composition
%CH4 = 1 ; C2H6 = 2 ; C3H8 = 3 ; N2 = 4 ;
Feed.z  = [0.92 0.05 0.01 0.02] ;
Mw = [16 28 44 28];
Feed.Mw =   Mw * Feed.z' ;

% CpIG values from spreadsheet
Feed.P = 8 ; % Inlet pressure (bar absoulte)
Feed.T = -160 ;

% Feed is completely liquid phase since
% Since T < Tbub
if(opt==1)
  Feed.H = -11411;  %Enthalpy of feed stream (kJ/kmol)
else
  Feed.H = -11151;
end
Feed.RhoL =   Feed.Mw / 3.45e-2 ;

Feed.lpmSTD  = 1200 ;
vflowSTD = Feed.lpmSTD * 1e-3 / 3600 ; % m3/s (at 15C, 1atm)
rhomSTD = 1.013e5 / (8314.5 * 288.15);   % molar density (ideal gas)
Molarflow = vflowSTD * rhomSTD;    % kgmol/s
Feed.Kgh = Molarflow * Feed.Mw  * 3600;

% Bubble and Dew points of mixture at 8bar(a)
Feed.Tbub = -131.0 ; % Bubble pt. Temp. (C) 
if(opt==1)
  Feed.Hbub = -10389 ; % Liq. Enthalpy at Bubble Point (kJ/kmol) 
else
  Feed.Hbub = -10207 ; % Liq. Enthalpy at Bubble Point (kJ/kmol) 
end

Feed.Tdew =  -84.0 ;   % Dew Point (C)
if(opt==1)
  Feed.Hdew = -2162  ;  % Vap. Enthalpy at Dew Point (kJ/kmol)
else
  Feed.Hdew = -2081  ;  % Vap. Enthalpy at Dew Point (kJ/kmol)
end

Feed.Lambda = (Feed.Hdew - Feed.Hbub)  ; % Latent Heat of Vaporization (kJ/kgmol)


Heater.QkW = 0.5;   % kW
Prod.H =  Feed.H +  Heater.QkW / Molarflow ;  % kJ/kmol
Prod.P = Feed.P ;

Prod.H
  QkwVap = Molarflow * Feed.Lambda 
  Feed
  Prod
  Heater
end
