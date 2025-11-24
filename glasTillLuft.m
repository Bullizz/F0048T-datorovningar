function glasTillLuft()
    %%% Ett script för att simulera en plan våg som bryts vid ett plant gränsskikt
    %%% Definera simulerings parametrar och vektorer
    nLuft       = 1;
    nGlas       = 1.6;
    thetaGlas   = 20;
    lambda      = 1e-6;
    alfaLuft    = 0;
    alfaGlas    = 0;
    c           = 3e8;
    
    % Kant vektorerna för beräknings områderna
    y           = linspace(0, 10e-6, 800);
    zGlas       = linspace(-5e-6, 0, 400);
    zLuft       = linspace(0, 5e-6, 400);
    
    % Definera riktningsvektorn för vågen i luft och glas
    sGlas       = [sind(thetaGlas), cosd(thetaGlas)];
    thetaLuft   = asind((nGlas / nLuft) * sind(thetaGlas));
    sLuft       = [sind(thetaLuft), cosd(thetaLuft)];

    % Generera vågen i luft och glas
    ULuft       =  planewave(y, zLuft, sLuft, lambda / nLuft, alfaLuft);
    UGlas       =  planewave(y, zGlas, sGlas, lambda / nGlas, alfaGlas);
    
    % Beräkna transmissions koefficienten och skala den komplexa
    % amplituden för vågen i glas och slå samman amplituderna
    tp          = TransCoef(sGlas, sLuft, nGlas, nLuft);
    ULuft       = ULuft .* tp;
    U           = [UGlas, ULuft]; 
    
    % Beräkna itensiteterna för att kuna beräkna energitätheterna
    ILuft       = abs(ULuft) .^ 2;
    IGlas       = abs(UGlas) .^ 2;
    
    % Beräkna energitättheterna
    WGlas       = IGlas / c;
    WLuft       = ILuft / c;
    W           = [WGlas, WLuft];
    
    %%% Genererera resultat figurer
    % Beräkna fas och intensitet
    Fas     = angle(U);
    I       = abs(U).^2;
    Wsnitt  = W(500, :) * 1e9;
    Isnitt  = I(500, :);
    
    % Fixa vektorer till x och y axlar till figuren
    zAxis = [zGlas, zLuft] * 1e6;
    yAxis = y * 1e6;
    
    % Fasen
    figure(1);
        imagesc(zAxis, yAxis, Fas);
        colormap('gray');
        Chdl = colorbar;
        set(Chdl.Title, 'String', '[-\pi,\pi]');
        axis xy;
        axis square;
        title('Phase', 'fontsize', 18);
        xlabel('z [\mum]', 'fontsize', 16);
        ylabel('y [\mum]', 'fontsize', 16);
    
    % Itensiteten
    figure(2);
        imagesc(zAxis, yAxis, I);
        colormap('gray');
        Chdl = colorbar;
        set(Chdl.Title, 'String', '[W/m^2]');
        axis xy;
        axis square;
        title('Intensity', 'fontsize', 18);
        xlabel('z [\mum]', 'fontsize', 16);
        ylabel('y [\mum]', 'fontsize', 16);
    
    % Tvärsnitt av intensiteten och energitätheten
    figure(3);
        subplot(1, 2, 1);
            plot(zAxis, Isnitt, 'linewidth', 2);
            title('Intensitet', 'fontsize', 18);
            xlabel('z [\mum]', 'fontsize', 16);
            ylabel('Itensitet [W/m^2]', 'fontsize', 16);
        
        subplot(1, 2, 2);
            ax = plot(zAxis, Wsnitt, 'linewidth', 2);
            title('Energitäthet', 'fontsize', 18);
            xlabel('z [\mum]', 'fontsize', 16);
            ylabel('Energitäthet [n J/m^3]', 'fontsize', 16);
            ytickformat('%,.3f');
end