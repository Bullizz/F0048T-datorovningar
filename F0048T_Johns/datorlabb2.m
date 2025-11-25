% Parametrar till beräkningarna
nLuft       = 1;
nGlas       = 1.6;
thetaLuft   = 20;
lambda      = 1e-6;
alfaLuft    = 0;
alfaGlas    = 0;

% Kant vektorerna för beräknings områderna
y           = linspace(0, 10*10^-6, 800);
zLuft       = linspace(-5*10^-6, 0, 400);
zGlas       = linspace(0e-6, 5e-6, 400);

% Definera riktningsvektorn för vågen i luft
sLuft       = [sind(thetaLuft), cosd(thetaLuft)];

% Definera riktningsvektorn för vågen i glas
thetaGlas   = asind(sind(thetaLuft) / nGlas);
sGlas       = [sind(thetaGlas), cosd(thetaGlas)];

% Generera planen i luft
ULuft       = planewave(y,zLuft,sLuft,lambda/nLuft,alfaLuft);

% Generera planen i glas
UGlas       = planewave(y,zGlas,sGlas,lambda/nGlas,alfaGlas);

% Slå samman de två vågorna
U           = [ULuft UGlas];

%% Generera en resultat figur
% Beräkna fasen
Fas = angle(U);

% Fixa vektorer till x och y axlar förö figuren
yAxis = y * 1e6;
zAxis = (zLuft + zGlas) * 1e6;


% PLota resultatet
figure(1)
imagesc(zAxis,yAxis,Fas)
colormap("gray")
cHandel = colorbar;
set(cHandel.Title,"String","[-\pi,\pi]")
axis xy
axis square
title("Fas","fontsize",18)
xlabel("z [\mum]","fontsize",16)
ylabel("y [\mum]","fontsize",16)





