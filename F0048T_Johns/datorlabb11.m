E       = 1e-9;         %Pulsenergi
a       = 4e-6;         %Kärnradie
n1      = 1.545;       %Brytningsindex kärna
n2      = 1.542;       %Brytningsindex mantel
lambda0 = 1.5e-6; %Vakumvåglängd
c       = 3e8;          %Ljusets hastighet
s       = 100e9;        %Spektralbandbredd
T       = linspace(-5e-11,5e-11,1000);  %Lokal tid
dndv    = 2.5e-17; %Frekvensberoendet på brytningsindex
delta_nu = 2*s
dndnu = 2.5e-17

%Lägg in din kod här

% Calculate center frequency and shifted frequencies
f0 = c / lambda0;   % Center frequency [Hz]
f_plus = f0 + s;    % Higher frequency [Hz]
f_minus = f0 - s;   % Lower frequency [Hz]

% Convert frequencies to wavelengths
lambda_f0 = c / f0;
lambda_f_plus = c / f_plus;
lambda_f_minus = c / f_minus;

beta_material_f0 = -2 * pi * n1 * dndnu * f0 / c;
beta_material_f_plus = -2 * pi * n1 * dndnu * f_plus / c;
beta_material_f_minus = -2 * pi * n1 * dndnu * f_minus / c;


% Exempel hur man anropar singelmodfunktionen
% [ ~, b, ~, ~, ~ ] = singelmod(n1,n2,lambda0,a );
% Beräkna mha singelmod() beta för tre olika frekvenserna
[ ~, bm, ~, ~, ~ ] =singelmod(n1, n2, lambda_f_minus, a); % frekvensen lägre än center frekvensen
[ ~, b0, ~, ~, ~ ] =singelmod(n1, n2, lambda0, a); % center frekvensens konstant
[ ~, bp, ~, ~, ~ ] =singelmod(n1,n2,lambda_f_plus,a ); % frekvensen högre än center frekvensen

b0 = b0 + beta_material_f0;
bp = bp + beta_material_f_plus;
bm = bm + beta_material_f_minus;

% Beräkna dispersionskonstanten
D = (1 / (2 * pi)) * ((bp - 2 * b0 + bm) / (s^2));

z0=1/(pi*s^2*D);
sigt=sqrt(z0*D/pi);


% Beräkna de tre olika pulserna


% Pulsen vid z = 0
z1      = 0 ; % Propagerings avståndet
sigma1  = sigt* sqrt(1+(z1/z0)^2); % enligt ekvation (2)
%P1      = sqrt(2/pi) * E / sigma1 * exp(-2.*T.^2 / sigma1^2); % Effektprofilen vid 0km

% Pulsen vid z = 1km
z2      = 1e3; % Propagerings avståndet
sigma2  = sigt* sqrt(1+(z2/z0)^2); % enligt ekvation (2)
%P2      = sqrt(2/pi) * E / sigma2 * exp(-2.*T.^2 / sigma2^2); % Effektprofilen vid 1km

% Pulsen vid z = 5km
z3      = 5e3; % Propagerings avståndet
sigma3  = sigt* sqrt(1+(z3/z0)^2); % enligt ekvation(2)
%P3      = sqrt(2/pi) * E / sigma3 * exp(-2.*T.^2 / sigma3^2); % Effektprofilen vid 5km


P0 = sqrt(2/pi) * E / sigma1 * exp(-2.*T.^2 / sigma1^2);                    %Effektprofil vid 0km
P1 = sqrt(2/pi) * E / sigma2 * exp(-2.*T.^2 / sigma2^2);                   %Effektprofil vid 1km
P5 = sqrt(2/pi) * E / sigma3 * exp(-2.*T.^2 / sigma3^2);                   %Effektprofil vid 5km



% Visa alla plottar i samma figur
figure(1)
plot(T,P0,T,P1,T,P5)
title('Pulses plotted together')
xlabel('[ps]')
legend('z = 0km','z = 1km','z = 5km')
