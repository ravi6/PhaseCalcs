function CpNIST

%Gurvich, Veyts, et al., 1989    p=1 bar. Because of more precise method of calculation, the recommended values are more accurate, especially at high temperatures, than those obtained by [ McDowell R.S., 1963] and often regarded as reference data [ Friend D.G., 1989].; GT
MethaneCpTk = [ 33.28   100.0; 33.51   200.0; 35.69   298.150; 35.76   300.0;
40.63   400.0; 46.63   500.0; 52.74   600.0; 58.60   700.0; 64.08   800.0;
69.14   900.0; 73.75   1000.0; 77.92   1100.0; 81.68   1200.0; 85.07   1300.0;
88.11   1400.0; 90.86   1500.0; 93.33   1600.0; 95.58   1700.0; 97.63   1800.0;
99.51   1900.0; 101.24  2000.0; 102.83  2100.0; 104.31  2200.0; 105.70  2300.0;
107.00  2400.0; 108.23  2500.0; 109.39  2600.0; 110.50  2700.0; 111.56  2800.0;
112.57  2900.0; 113.55  3000];

% Gurvich, Veyts, et al., 1989    p=1 bar. Recommended entropies and heat capacities are in good agreement with those obtained from other statistical thermodynamic calculations [ Pitzer K.S., 1944, Chao J., 1973, Pamidimukkala K.M., 1982].; GT
EthaneCpTk = [ 35.70   100.0; 42.30   200.0; 52.49   298.150; 52.71   300.0;
65.46   400.0; 77.94   500.0; 89.19   600.0; 99.14   700.0; 107.94  800.0;
115.71  900.0; 122.55  1000.0; 128.55  1100.0; 133.80  1200.0; 138.39  1300.0;
142.40  1400.0; 145.90  1500.0; 148.98  1600.0; 151.67  1700.0; 154.04  1800.0;
156.14  1900.0; 158.00  2000.0; 159.65  2100.0; 161.12  2200.0; 162.43  2300.0;
163.61  2400.0; 164.67  2500.0; 165.63  2600.0; 166.49  2700.0; 167.28  2800.0;
168.00  2900.0; 168.65  3000.0]; 

%Chao J., 1973   Recommended values are in good agreement with those calculated by [ Pitzer K.S., 1944].; GT
PropaneCpTk = [34.06   50.0; 41.30   100.0; 48.79   150.0; 56.07   200.0;
68.74   273.150; 73.60   298.150; 73.93   300.0; 94.01   400.0; 112.59  500.0;
128.70  600.0; 142.67  700.0; 154.77  800.0; 165.35  900.0; 174.60  1000.0;
182.67  1100.0; 189.74  1200.0; 195.85  1300.0; 201.21  1400.0; 205.89  1500.0];


NitrogenCpTk = [ 29.1 112.0; 29.4 466; 31.03 740; 32.7 1002; 34 1257 ; 34.84 1497]; 
                 

%Scott D.W., 1974, 2 Recommended values were obtained from the consistent correlation scheme for alkanes [ Scott D.W., 1974, Scott D.W., 1974, 2]. This approach gives a better agreement with experimental data than the statistical thermodynamics calculation [ Pitzer K.S., 1944, Pitzer K.S., 1946].; GT
PentaneCpTk = [ 93.55   200.0; 112.55  273.150; 120.0  298.150; 120.62  300.0;
152.55  400.0; 182.59  500.0; 208.78  600.0; 231.38  700.0; 250.62  800.0;
266.94  900.0; 281.58  1000.0; 293.72  1100.0; 304.60  1200.0; 313.80  1300.0;
322.17  1400.0; 330.54  1500]; 

%Scott D.W., 1974    Recommended values were obtained from the consistent correlation scheme for alkanes [ Scott D.W., 1974, 2, Scott D.W., 1974]. This approach gives a better agreement with experimental data than the statistical thermodynamics calculations [ Pitzer K.S., 1946, Scott D.W., 1951].; GT
iPentaneCpTk = [84.94   200.0; 110.37  273.15; 118.9   298.15; 119.50  300.0;
152.88  400.0; 183.26  500.0; 210.04  600.0; 233.05  700.0; 253.13  800.0;
270.70  900.0; 286.19  1000.0; 299.57  1100.0; 311.29  1200.0; 322.17  1300.0;
330.54  1400.0; 338.90  1500.0]; 

% Chen S.S., 1975 Recommended values are in good agreement with those calculated by [ Pitzer K.S., 1946].; GT
iButaneCpTk = [34.81   50.0; 47.28   100.0; 60.29   150.0; 71.84   200.0;
89.91   273.15; 96.65   298.15; 97.15   300.0; 124.43  400.0; 149.24  500.0;
170.37  600.0; 188.28  700.0; 203.64  800.0; 216.94  900.0; 228.45  1000.0;
238.49  1100.0; 247.15  1200.0; 254.72  1300.0; 261.29  1400.0; 267.02  1500;];

ButaneCpTk = [38.07   50.0; 55.35   100.0; 67.32   150.0; 76.44   200.0;
92.30   273.150; 98.49   298.150; 98.95   300.0; 124.77  400.0; 148.66  500.0;
169.28  600.0; 187.02  700.0; 202.38  800.0; 215.73  900.0; 227.36  1000.0;
237.48  1100.0; 246.27  1200.0; 253.93  1300.0; 260.58  1400.0; 266.40  1500];

%Chase, M.W., Jr., NIST-JANAF Themochemical Tables, Fourth Edition, J. Phys. Chem. Ref. Data, Monograph 9, 1998, 1-1951.
CO2TkCp = [298.0 37.12; 300.0 37.22; 400.0 41.34; 500.0	44.61;
600.0 47.32; 700.0 49.57; 800.0 51.44; 900.0 53.00;
1000.0 54.30; 1100.0 55.40; 1200.0 56.35;];
CO2CpTk =[CO2TkCp(:,2) CO2TkCp(:,1)] ;

% Scott D.W., 1974, ;
HexaneCpTk=[110.58 200; 133.55 273.15; 142.6  298.15; 143.26 300;
181.54 400; 217.28 500; 248.11 600; 274.05 700; 296.23 800; 315.06 900;
331.37 1000; 345.18 1100; 357.31 1200; 368.19 1300; 376.56 1400; 389.11 1500;];


figure ; Coef(1,:) = plotme(MethaneCpTk, "Methane");
figure ; Coef(2,:) = plotme(EthaneCpTk, "Ethane");
figure ; Coef(3,:) = plotme(PropaneCpTk, "Propane");
figure ; Coef(4,:) = plotme(ButaneCpTk, "Butane");
figure ; Coef(5,:) = plotme(PentaneCpTk, "Pentane");
figure ; Coef(6,:) = plotme(HexaneCpTk, "Hexane");
figure ; Coef(7,:) = plotme(iButaneCpTk, "iButane"); 
figure ; Coef(8,:) = plotme(iPentaneCpTk, "iPentane");
figure ; Coef(9,:) = plotme(CO2CpTk, "CO2");
figure ; Coef(10,:) = plotme(NitrogenCpTk, "Nitrogen");

Coef
endfunction


function P = plotme(Data, name)
    Tk = Data(:,2) ; Cp = Data(:,1); 
    P=polyfit(Tk, Cp,3) ;
    Tk1 = [Tk(1):Tk(end)];
    Y=polyval(P,Tk1);
    plot(Tk, Cp, 'o', Tk1, Y, '-') ;
    title(strcat(name, " - NIST data"));
    xlabel("Temperature(K)");
    ylabel("Cp_IdealGas (kJ/kgmol)");
      str = sprintf( "CpIG = %6.3e + (%6.3e) Tk + (%6.3e) Tk^2 + (%6.3e) Tk^3",  P(4), P(3), P(2), P(1));
    legend(str);
    str
    grid on ;
    P = rotdim(P)';  % want it in reverse order
endfunction

