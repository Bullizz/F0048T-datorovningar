function svartKroppsStralning()
    % Indata
    T       = [2, 3, 4] .* 1e3;             % Temperatur - 2000K, 3000K, 4000K
    r       = 1e-3;             % Radie på 
    R       = 100e-3;             % Fokallängd = avstånd från källa
    c       = 3e8; % Speed of light
    vmin    = c / 400e-9;             % Undre frekvens
    vmax    = c / 700e-9;             % Övre frekvens
    v       = linspace(vmin, vmax, 1000);             % Frekvens array
    dv      = (v(end) - v(1)) / length(v);             % Frekvens differens
    NA      = 0.3;             % Numerisk Apertur
    dA      = (2e-6)^2;             % Detektor area
    dt      = 1;             % Exponeringstid
    f       = R;
    
    figure(1); clf;
        hold on;
        for i = 1 : length(T),
            % Använd Blackbody funktionen med parametrarna: v, T(i), r, R, NA
            F = Blackbody(v, T(i), r, f, NA);
            
            % Detekterade antalet fotoner
            E = F * dA * dt * dv;
            
            plot(v, E, 'linewidth', 2);
        end
        
        xlabel('Frequency [Hz]');
        ylabel('Photons');
        legend('2000K','3000K','4000K');
        hold off;
end