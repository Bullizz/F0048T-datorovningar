function laser()
    % Indata Nd:YAG
    l0   = 1.064e-6; % Nd:YAG våglängd
    dv   = 150e9;    % bandbredd
    s0   = 3e-23;    % transitions area
    t_sp = 230e-6;   % spontan livslängd
    Na   = 5e25;     % Nd:YAG tillstånd / m^3
    
    % Indata pump
    Ip  = 100;    % pump intensitet
    lp  = 805e-9; % pump vådlängd
    sp  = 6e-19;  % transitions area
    
    % indata resonator
    n   = 1.82; % brytningsindex
    d   = 0.01; % avstånd mellan speglar
    R1  = 1;    % reflektans spegel 1
    R2  = 0.95; % reflektans spegel 2
    
    % fysikaliska konstanter
    c0 = 3e8;       % ljusets hastighet i vakum
    h  = 6.626e-34; % Planck's konstant
    c  = c0 / n;
    
    % ar - "Loss factor of resonator"
    ar = (1 ./ (2 .* d)) .* log(1 ./ (R1 .* R2));
    
    % vF - "Frequency spacing"
    vF = c / (2 * d);
    
    % F - "Finesse"
    F = pi * sqrt(sqrt(R1) * sqrt(R2)) / (1 - abs(sqrt(R1) * sqrt(R2)));
    
    % Fp - "Photon flux density"
    Fp   = Ip * lp / (h * c0);
    
    % W - "Probability for stimulated emission"
    W = Fp * sp;
    
    % [s, v] - Lorentzian for Nd:YAG crystal and corresponding frequency vector
    [s, v] = Lorentz(s0, l0, dv);
    
    % N0 - "Low-photon population difference"
    N0 = (t_sp * Na * W) / (1 + (t_sp * W));
    
    % g0s - "gain coefficient"
    g0s = N0 * s;
    
    % I - Intensity distribution in resonator as a function of frequency
    I = (1 + (((2 * F) ./ pi).^2) .* ((sin((pi .* v) ./ vF)).^2)).^(-1);
    
    % g0 - "gain coefficient" modulated by the intensity distribution in the resonator
    g0 = g0s .* I;
    
    % Förlustfaktor to plot
    a = ar * ones(size(v));
    
    % Plot av resultat
    figure();
        plot(v, g0, v, a, 'linewidth', 2);
        xlabel('Frequency [Hz]');
        legend('gain', 'loss');
end