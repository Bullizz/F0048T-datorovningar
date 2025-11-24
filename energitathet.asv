function energitathet()
%%%
% I = |U|^2 = |A_0|^2
% P = IA
% E = PT = IAT
% W = I / c
%   W_1 = I_1 / c
%   W_2 = I_2 / c


% I_1z = E_1^2 * n1 s_z1 / 2 * eta_0
% I_2z = E_1^2 * |t|^2 * n_2 * s_z2 / 2 * eta_0
% I_3z = E_1^2 * |r|^2 * n_1 * s_z1 / 2 * eta_0 

%%%

nLuft       = 1;
nGlas       = 1.6;
thetaLuft   = 20;
lambda      = 1e-6;
alfaLuft    = 0;
alfaGlas    = 0;
c           = 3e8;

% Kant vektorerna för beräknings områderna
y           = linspace(0, 10e-6, 800);
zLuft       = linspace(-5e-6, 0, 400);
zGlas       = linspace(0, 5e-6,  400);

% Definera riktningsvektorn för vågen i luft
sLuft       = [sind(thetaLuft), cosd(thetaLuft)];

% Definera riktningsvektorn för vågen i glas
thetaGlas   = asind(sind(thetaLuft) * (nLuft / nGlas));
sGlas       = [sind(thetaGlas), cosd(thetaGlas)];

% Generera planen i luft och glas
ULuft       = planewave(y, zLuft, sLuft, lambda / nLuft, alfaLuft);
UGlas       = planewave(y, zGlas, sGlas, lambda / nGlas, alfaGlas);

% Skala vågen i glas
[tp]    = TransCoef(sLuft, sGlas, nLuft, nGlas);
UGlas   = UGlas .* tp;

% Slå samman de två vågorna
U       = [ULuft, UGlas];

% Beräkna itensiteterna
ILuft = abs(ULuft).^2;
IGlas = abs(UGlas).^2;

% Beräkna energitättheterna
WLuft   = ILuft ./ c;
WGlas   = IGlas ./ c;

% Slå samman energitätheterna
W = [WLuft, WGlas];

% Genererera resultat figurer
% Beräkna fas och intensitet
Fas     = angle(U);
I       = abs(U).^2;
Wsnitt  = mean([WLuft, WGlas]);
Isnitt  = mean([ILuft, IGlas]);

% Fixa vektorer till x och y axlar till figuren
zAxis = [zLuft, zGlas] * 1e6;
yAxis = y * 1e6;

% Fasen
figure(1); clf;
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
figure(2); clf;
    imagesc(zAxis, yAxis, I);
    colormap('gray');
    Chdl = colorbar;
    set(Chdl.Title, 'String', '[W/m^2]');
    axis xy;
    axis square;
    title('Intensity', 'fontsize', 18);
    xlabel('z [\mum]','fontsize', 16)
    ylabel('y [\mum]', 'fontsize', 16);

% Tvärsnitt av intensiteten och energitätheten
figure(3); clf;
    subplot(1,2,1);
        plot(zAxis, Isnitt, 'linewidth', 2);
        title("Intensitet [W/m^2]", "FontSize", 18);
        xlabel("z [\mum]", 'FontSize', 16);
        ylabel("y [\mum]", 'FontSize', 16);
        
    subplot(1, 2, 2);
        plot(zAxis, Wsnitt, 'linewidth', 2);
        title("Energitäthet [W/m^2]", "FontSize", 18);
        xlabel("z [\mum]", 'FontSize', 16);
        ylabel("y [\mum]", 'FontSize', 16);
end