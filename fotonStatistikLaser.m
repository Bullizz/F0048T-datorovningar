function fotonStatistikLaser()
    % Indata Cameraman och detektor
    A   = imread('cameraman','tiff');
    I   = double(A);
    mask= I / max(max(I));
    dA  = (2e-6)^2;
    dt  = 1e-3;
    
    % Indata Nd:YAG
    l0  = 1.064e-6; % Nd:YAG vågläng
    dv  = 150e9;    % bandbredd
    s0  = 3e-23;    % transitions area
    t_sp = 230e-6;   % spontan livslängd
    Na  = 5e25;     % Nd:YAG tillstånd / m^3
    
    % Indata pump
    Ipump   = [10, 40, 90]; % pump intensitet
    lp      = 805e-9;       % pump vådlängd
    sp      = 6e-19;        % transitions area
    
    % indata resonator
    n   = 1.82; % brytningsindex
    d   = 0.01; % avstånd mellan speglar i resonator
    R1  = 1;    % reflektans spegel 1
    R2  = 0.95; % reflektans spegel 2
    
    % fysikaliska konstanter
    c0  = 3e8;       % ljusets hastighet i vakuum
    h   = 6.626e-34; % Planck's konstant
    
    % ar - "loss coefficient for resonator"
    ar = 1 / 2 / d * log(1 / R2);
    
    bild = zeros(size(mask, 1), size(mask, 2), length(Ipump));
    for i = 1: length(Ipump)
        Ip = Ipump(i);
        
        % Fp - "Photon flux density" från 805nm pumpen
        Fp = Ip / (h * (c0 / lp));
        
        % Wp - "Probability for stimulated emission" i Nd:YAG kristallen
        W = Fp * sp;
        
        % N0 - "Low-photon population"
        N0 =(t_sp * Na * W) / (1 + t_sp * W);
        
        % g0 - "Maximum gain coefficient"
        g0 = N0 .* s0;
        
        % ts - "Saturation time constant"
        ts = t_sp / (1 + (t_sp * W));
        
        % Fsi - "Saturation photon flux density"
        Fsi = (ts * s0).^(-1);
        
        % F - "Photon flux density" från resonatorn
        Nt = ar / s0;
        F = Fsi * ((N0 / Nt) - 1);
        
        T = 1 - R2;
        Fout = F * (T / 2);
    
        % medelvärdet av antalet detekterade fotoner
        nbar = Fout * dA * dt * 0.1 * (1e-4)^2;
        
        % Bilden modulerad med antalet detekterade fotoner
        Ep = nbar * mask;
        
        %
        bild(:, :, i) = random('poiss', Ep);
        
        % generera subfigurer för Ip
        subplot(1, 3, i);
            titel = sprintf('Pump = %d [W/m^2]', Ip);
            imagesc(bild(:, :, i));
            colormap(gray(256));
            axis('image');
            title(titel);
    end
end