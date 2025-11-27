function laserforstarkare()
    % Indata Nd:YAG
    l0  = 1.064e-6;  % Nd:YAG våglängd
    dv  = 150e9;     % bandbredd
    s0  = 3e-23;     % transitions area
    t_sp = 230e-6;    % spontan livslängd
    Na  = 5e25;      % Nd:YAG tillstånd / m^3
    
    % Indata pump
    Ip  = 100;      % pump intensitet
    lp  = 805e-9;   % pump vådlängd
    sp  = 6e-19;    % transitions area
    
    % fysikaliska konstanter
    c0  = 3e8;      % ljusets hastighet i vakum
    h   = 6.626e-34;% Planck's konstant
    
    % Fp - "Photon flux density"
    Fp = Ip * lp / (h * c0);
    
    % W - "Probability for stimulated emission"
    W = Fp * sp;
    
    % [s, v] - Lorentzian for Nd:YAG crystal and corresponding frequency vector
    [s, v] = Lorentz(s0, l0, dv);
    
    % N0 - "Low-photon population difference"
    N0 = (t_sp * Na * W) / (1 + (t_sp * W));
    
    g0 = N0 * s;
    
    % Plot av resultat
    figure(); clf;
        plot(v, g0, 'linewidth', 2);
        xlabel('Frequency [Hz]');
        legend('gain');
end