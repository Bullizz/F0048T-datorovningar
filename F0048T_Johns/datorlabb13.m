% Parametrar
R           = 0.99;     % Spegel reflektansen
c           = 3e8;      % Ljusets hastighet
lambda_goal = 532e-9;   % Våglängd som ska filtrerar ut
lambda_min  = 520e-9;   % längsta våglängdsinnehåll
lambda_max  = 560e-9;   % Högstavåglängdsinnehåll
lambda      = linspace(lambda_min,lambda_max,100001); % Våglängds vektorn
v           = c./lambda; % konvertera från våglängd till frekvens
I0          = 1; % Initial ljusintensitet

% Lägg till din kod här
%max_d=0.9*c/2*(c/lambda_goal-c/lambda_max);
%q=(1:5);
%if (lambda_goal*q/2 < max_d)%
%   d = lambda_goal*q/2;
%end

%d=max(d);

%Tilldela värdet på resonator variabler:
I_in = 1-R;
R1 =R;
R2 =R;
delta_nu = (c/lambda_goal-c/lambda_max);
d= 0.9*(c/(2*delta_nu));

I = resonator(I_in,R1,R2,d,c,v);        %


I_ut =I*(1-R);         % Lägg till värdet på intensiteten ut

figure(1)
plot(lambda,I_ut)
A = sprintf('d = %5.4f µm',d/1e-6);
title(A)
xlabel('Wavelength [nm]')