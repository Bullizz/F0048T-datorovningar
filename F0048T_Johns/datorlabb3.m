% Parametrar till beräkningarna
nLuft       = 1;
nGlas       = 1.6;
thetaLuft   = 20;
lambda      = 1e-6;
alfaLuft    = 0;
alfaGlas    = 0;

% Kant vektorerna för beräknings områderna
y           = linspace(0,10e-6,800);
zLuft       = linspace(-5e-6,0,400);
zGlas       = linspace(0,5e-6,400);

% Definera riktningsvektorn för vågen i luft
sLuft       = [sind(thetaLuft) cosd(thetaLuft)];

% Definera riktningsvektorn för vågen i glas
thetaGlas   = asind(sind(thetaLuft)*nLuft/nGlas);
sGlas       = [sind(thetaGlas) cosd(thetaGlas)];

% Generera planen i luft och glas
ULuft       = planewave(y,zLuft,sLuft,lambda/nLuft,alfaLuft);
UGlas       = planewave(y,zGlas,sGlas,lambda/nGlas,alfaGlas);

% Skala vågen i glas
[tp]    = TransCoef(sLuft, sGlas, nLuft, nGlas);
UGlas   = tp * UGlas;

% Slå samman de två vågorna
U       = [ULuft UGlas];

%% Genererera resultat figurer
% Beräkna fas och intensitet
Fas = angle(U);
I   = abs(U)^2;

% Fixa vektorer till x och y axlar till figurerna
zAxis = [zLuft zGlas]*1e6;
yAxis = y*1e6;

% PLota resultatet
figure(1)
imagesc(zAxis,yAxis,Fas)
colormap('gray')
cHandel = colorbar;
set(cHandel.Title,'String','[-\pi,\pi]')
axis xy
axis square
title('Phase','fontsize',18)
xlabel('z [\mum]','fontsize',16)
ylabel('y [\mum]','fontsize',16)

figure(2)
imagesc(zAxis,yAxis,I)
colormap('gray')
Chdl = colorbar;
set(Chdl.Title,'String','')
axis xy
axis square
title('Intensity [W/\mum^2]','fontsize',18)
xlabel('z [\mum]','fontsize',16)
ylabel('y [\mum]','fontsize',16)