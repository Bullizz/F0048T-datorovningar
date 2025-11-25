% Indata
c   = 3e8;
T       = (2:4) * 1e3;             % Temperatur - 2000K, 3000K, 4000K
r       = 1e-3;             % Radie på 
R       = 100e-3;             % Fokallängd = avstånd från källa
vmin    = 3e8 / 1e-6; % Undre frekvens
vmax    = 3e8 / 0.4e-6; % Övre frekvens
v       = linspace(vmin, vmax);             % Frekvens array
dv      = v(2) - v(1);             % Frekvens differens
NA      = 0.3;             % Numerisk Apertur
dA      = (2e-6)^2;             % Detektor area
dt      = 1e-3;             % Exponeringstid

figure(1); hold on
for i = 1 : length(T)
    % Använd Blackbody funktionen med parametrarna: v, T(i), r, R, NA
    F = Blackbody(v, T(i), r, R, NA);
    % Detekterade antalet fotoner
    E = F.*dA.*dt.*dv;
    
    plot(v, E, 'linewidth', 2)
end

xlabel('Frequency [Hz]')
ylabel('Photons')
legend('2000K','3000K','4000K')
hold off