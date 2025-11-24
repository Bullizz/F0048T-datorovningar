function brytningPlantGransskikt()
    % Parametrar till beräkningarna
    nLuft       = 1;
    nGlas       = 1.6;
    thetaLuft   = 20;   % [deg.]
    lambda      = 1e-6;
    alfaLuft    = 0;
    alfaGlas    = 0;
    % thetaGlas   = asind((nLuft / nGlas) * sind(thetaLuft));
    
    % Kant vektorerna för beräknings områderna
    y           = linspace(0, 10e-6, 800);
    zLuft       = linspace(-5e-6, 0, 400);
    zGlas       = linspace(0,  5e-6, 400);
    
    % Definera riktningsvektorn för vågen i luft
    sLuft       = [sind(thetaLuft), cosd(thetaLuft)];
    
    % Definera riktningsvektorn för vågen i glas
    thetaGlas   = asind((nLuft / nGlas) * sind(thetaLuft));
    sGlas       = [sind(thetaGlas), cosd(thetaGlas)];
    
    % Generera planen i luft
    ULuft       = planewave(y, zLuft, sLuft, lambda, alfaLuft);
    
    % Generera planen i glas
    UGlas       = planewave(y, zGlas, sGlas, lambda / nGlas, alfaGlas);
    
    % Slå samman de två vågorna
    U           = [ULuft, UGlas];
    
    %%%
    % Generera en resultat figur
    %%%
    % Beräkna fasen
    Fas = angle(U);
    
    % Fixa vektorer till x och y axlar förö figuren
    yAxis = y * 1e6;            % [m] --> [µm]
    zAxis = [zLuft, zGlas];
    zAxis = zAxis * 1e-6;       % [m] --> [µm]
    
    
    % PLota resultatet
    figure(1);
    imagesc(zAxis, yAxis, Fas);
    colormap('gray');
    colorbar;
    
    cHandel = colorbar;
    set(cHandel.Title,'String','[-\pi,\pi]');
    axis xy;
    axis square;
    title("Fas", 'FontSize', 18);
    xlabel('z [\mum]', 'fontsize', 16);
    ylabel('y [\mum ]', 'fontsize', 16);
end

function [U] = planewave(y,z,s,lambda,alfa)
    % U = planewave(y,z,s,lambda)
    % This function generates the complex amplitude for a plane wave.
    % Input:
    %   y       - The vector defining the y edge of the calculation grid
    %   z       - The vector defining the z edge of the calculation grid
    %   s       - The direction of porpagation, s = [ydirection,zdirection]
    %   lambda  - The wavelength
    %   alpha   - The phase of the plane wave
    % Output:
    %   U       - The complex amplitude of the plane wave
    
    % Define the calculation grid
    [Z, Y] = meshgrid(z, y);
    Z = Z * s(2);
    Y = Y * s(1);

    % Define the wavenumber
    k = (2 * pi) / lambda;
    
    % Define the complex amplitude
    A_0 = 1;
    U = (A_0 * exp(1i * ((k * [Y + Z]) + alfa)));
end