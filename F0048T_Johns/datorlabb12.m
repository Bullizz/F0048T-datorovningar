% Skript för att kalla på resonator funktionen
R       = 0.99;   % Reflektansen från speglarna
d       = 1.5e-6; % Längd resonator
lambda  = 500e-9; % Center våglängden
v0      = 3e8/lambda; % Center frekvensen
dnu     = 3e8/(2*d); %
nuM     = v0-0.5*dnu;
nuP     = v0+0.5*dnu;
nu      = linspace(nuM,nuP,1000);

I       = resonator(1,R,R,d,c,nu); % Intensiteten

% Plotta resultatet
figure(1)
plot(nu,I)
title('Itensiteten i en resonator','fontsize',18)
xlabel('Frekvens [Hz]','fontsize',16)
ylabel('Iintensitet [w/m^2]','fontsize',16)

