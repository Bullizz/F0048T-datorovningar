function fotonflodeLaser()
    % Indata Nd:YAG
    l0   = 1.064e-6; % Nd:YAG våglängd
    dv   = 150e9;    % bandbredd
    s0   = 3e-23;    % transitions area
    t_sp = 230e-6;   % spontan livslängd
    Na   = 5e25;     % Nd:YAG tillstånd / m^3
    
    % Indata pump
    Ipump = 1: 100;  % pump intensitet
    lp    = 805e-9;  % pump vådlängd
    sp    = 6e-19;   % transitions area
    
    % indata resonator
    n  = 1.82; % brytningsindex
    d  = 0.01; % avstånd mellan speglar i resonator
    R1 = 1;    % reflektans spegel 1
    R2 = 0.95; % reflektans spegel 2
    
    % fysikaliska konstanter
    c0 = 3e8;       % ljusets hastighet i vakum
    h  = 6.626e-34; % Planck's konstant
    
    % ar - "loss coefficient for resonator"
    ar = 1 / 2 / d * log(1 / R2);
    
    % tp - "photon lifetime"
    tp = 1 / (ar * c0 / n);
    
    % I loopen så skall ni beräkna fotonflödet från en resonator med lasring 
    % från en Nd:YAG kristall, för pump intensitet Ipump = 1 : 100
    F = zeros(size(Ipump));
    for Ip = Ipump
        % Fp - "Photon flux density" från pumpen
        Fp  = Ip * lp / (h * c0);
        
        % Wp - "Probability for stimulated emission"
        W = Fp * sp;
        
        % N0 - "Low-photon population"
        N0 = (t_sp * Na * W) / (1 + (t_sp * W));
        
        % g0 - "Maximum gain coefficient"
        g0 = N0 * s0;
        
        % ts - "Saturation time constant"
        ts = t_sp / (1 + (t_sp * W));
        
        % Fsi - "Saturation photon flux density"
        Fsi = 1 ./ (ts * s0);
        
        % F - "Photon flux density" från resonatorn
        Nt = ar / s0;
        F(Ip) = Fsi * ((N0 / Nt) - 1);
    end
    
    % I - Intensitet i resonatorn som funktion av "photon flux density"
    I = F .* h * (c0 / l0);
    
    % T -"Transimission mirror 2"
    T = 1 - R2; 
    
    % Iout - "Output intensity of the laser"
    Iout = (I .* T) ./ 2;
    
    % P - Uteffekt för en stråle med tvärsnittsdiameter på 1 mm
    P = Iout * pi * ((1e-3 / 2)^2);
    
    
    figure();
        plot(Ipump, P, 'linewidth', 2);
        ylabel('Power [W]');
        xlabel('Pump intensity [W/m^2]');
end