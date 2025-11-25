function vagledardispertion()
    E       = 1e-9;                         % Pulsenergi [J]
    a       = 4e-6;                         % Kärnradie [m]
    n1      = 1.545;                        % Brytningsindex kärna
    n2      = 1.542;                        % Brytningsindex mantel
    lambda0 = 1.5e-6;                       % Vakumvåglängd [m]
    c       = 3e8;                          % Ljusets hastighet [m/s]
    s       = 100e9;                        % Spektralbandbredd [Hz]
    T       = linspace(-5e-11,5e-11,1000);  % Lokal tid [s]
    delta_nu = 2*s;
    
    % Beräkna de tre frekvenserna där propageringskonstanterna ska beräknas
    v_0 = c / lambda0;
    v_1 = v_0 - delta_nu;
    v_2 = v_0 + delta_nu;
    
    % Exempel hur man anropar singelmodfunktionen
    % [ ~, b, ~, ~, ~ ] = singelmod(n1,n2,lambda0,a );  
    % Beräkna mha singelmod() beta för tre olika frekvenserna
    
    [ ~, bm, ~, ~, ~ ] = singelmod(n1, n2, c / v_1, a); % frekvensen lägre än center frekvensen
    [ ~, b0, ~, ~, ~ ] = singelmod(n1, n2, c / v_0, a); % center frekvensens konstant
    [ ~, bp, ~, ~, ~ ] = singelmod(n1, n2, c / v_2, a); % frekvensen högre än center frekvensen
    
    % Beräkna dispersionskonstanten
    db2_dt2 = (bm - (2 * b0) + bp) / (delta_nu^2);
    D = (1 / (2 * pi)) * db2_dt2;
    
    z0 = 1 / (pi * (s^2) * D);
    sL = sqrt((D * z0) / pi);
    
    % Beräkna de tre olika pulserna
    
    % Pulsen vid z = 0
    z1      = 0;                                                                % Propagerings avståndet
    sigma1  = sL * sqrt(1 + ((z1 / z0)^2));                                     % enligt ekvation (2)
    P1      = sqrt(2 / pi) * (E / sigma1) * exp(-((2 * (T.^2)) / (sigma1^2)));  % Effektprofilen vid 0km
    
    % Pulsen vid z = 1km
    z2      = 1e3;                                                              % Propagerings avståndet
    sigma2  = sL * sqrt(1 + ((z2 / z0)^2));                                     % enligt ekvation (2)
    P2      = sqrt(2 / pi) * (E / sigma2) * exp(-((2 * (T.^2)) / (sigma2^2)));
    
    % Pulsen vid z = 5km
    z3      = 5e3;                                                              % Propagerings avståndet
    sigma3  = sL * sqrt(1 + ((z3 / z0)^2));                                     % enligt ekvation (2)
    P3      = sqrt(2 / pi) * (E / sigma3) * exp(-((2 * (T.^2)) / (sigma3^2)));
    
    % Visa alla plottar i samma figur
    figure(1);
        plot(T,P1,T,P2,T,P3)
        title('Pulses plotted together','fontsize',18);
        xlabel('[ps]','fontsize',16);
        legend('z = 0 km','z = 1km', 'z = 5km');
end