function Mix = pr(Mix, Comps)

% Peng-Robinson EoS computation and property calculations

% Comps is a structure that holds all Component parametric data
% including binary interaction parameters, critical constants etc.

% Mix is a Component Mixture Structure with follwoing Properties
% Mixture properies as a whole
% These are inputs
% z   = mole fraction of  species 
% p   = pressure [Pa]
% T   = temperature [K]
% phase = "L" or "V"

% Mixture Properties of Liq. and Vap Phases (Mix.Vap, Mix.Liq)
% These are the outputs
% Z   = compressibility factor
% V   = Molar volume (m3/gmol)
% phi = fugacity coefficient
% H   = enthalpy [J/gmol]

% Tref = Reference Temp. for Enthalpy Calculations (K)

R  = 8.314; % m3 Pa/(mol K) = J/mol-K
Tref = 298.15; % K

e  = 1 - sqrt(2);
s  = 1 + sqrt(2);
m    =  0.37464 + 1.54226 * Comps.w - 0.26992 * Comps.w .^ 2;
alfa =  (1 + m .* (1 - (Mix.T ./ Comps.Tc) .^ 0.5)) .^ 2;
ai   =  0.45724 * (R^2) * (Comps.Tc .^ 2) ./ Comps.pc .* alfa;
bi   =  0.07780 * R * Comps.Tc ./ Comps.pc;
Q    =  ((ai * ai') .^ 0.5) .* (1 - Comps.k);

dQdT =  0.45724 * (R^2) * (Comps.k - 1) .* (Comps.Tc * Comps.Tc') ./ ...
        ((Comps.pc * Comps.pc') .^ 0.5) .* (1/(2 * Mix.T^0.5)) .* ...
        ((m ./ (Comps.Tc .^ 0.5)) * (alfa .^ 0.5)' + (alfa .^ 0.5) * (m ./ (Comps.Tc .^ 0.5))');

dadT = Mix.z' * (Q - Mix.T * dQdT) * Mix.z;

% Coefficients of the Mixture EoS model equation in Cubic Form
% in  Compressibility
Mix.EOS.a = Mix.z' * Q * Mix.z;
Mix.EOS.b = Mix.z' * bi;
Mix.EOS.A = Mix.EOS.a * Mix.p / (R * Mix.T)^2  ;  % Dimensionless
Mix.EOS.B = Mix.EOS.b * Mix.p / (R * Mix.T)  ;  % Dimensionless

% Z^3 + (B-1) * Z^2 + (A-2B-3B^2) * Z + B * (B^2 + B - A) = 0
Mix.EOS.Cubic(1) = 1;
Mix.EOS.Cubic(2) = Mix.EOS.B - 1;
Mix.EOS.Cubic(3) = Mix.EOS.A - 2 * Mix.EOS.B - 3 * Mix.EOS.B^2 ; 
Mix.EOS.Cubic(4) = Mix.EOS.B * (Mix.EOS.B^2 + Mix.EOS.B - Mix.EOS.A) ;

abar = (2 * Mix.z' * Q - Mix.EOS.a * ones(1,length(Mix.z)))'; 
bbar = bi;

% Now all other properties of Mixture for both Phases
Mix.Z = getZ(Mix);

# Looks like these two expressions wont hold
Mix.Tc = Comps.Tc' * Mix.z;
Mix.pc = Comps.pc' * Mix.z;

Mix.V = (Mix.Z * R * Mix.T) / Mix.p ;   %  Mixture molar volume

% Fuagcity Coefficeint (I need to derive it)
  Mix.phi  = exp( (Mix.Z - 1) * bbar / Mix.EOS.b ...
            - log((Mix.V - Mix.EOS.b) * Mix.Z / Mix.V) ...
            + (Mix.EOS.a / (Mix.EOS.b * R * Mix.T)) / (e - s) ...
                 *  log((Mix.V + s * Mix.EOS.b) / (Mix.V + e * Mix.EOS.b)) ...
                 *  (1 + abar / Mix.EOS.a - bbar / Mix.EOS.b) ...
          );

% Enthalpy deviation (from ideal)
  Mix.Hdev  = R * Mix.T * (Mix.Z - 1) - dadT/(2 * (s - 1) * Mix.EOS.b) ...
                  *  log((Mix.V + s * Mix.EOS.b)/(Mix.V + e * Mix.EOS.b));

  Mix.Hig = Mix.z' * ( Comps.CCp(:,1) * (Mix.T - Tref) ...
           + Comps.CCp(:,2) * ((Mix.T - Tref)^2) / 2.0 ...
           + Comps.CCp(:,3) * ((Mix.T - Tref)^3) / 3.0 ...
           + Comps.CCp(:,4) * ((Mix.T - Tref)^4) / 4.0) ;
       
  Mix.H   = Mix.Hig + Mix.Hdev;

end  % End of Peng-Robinson EOS for Mixture of Species
