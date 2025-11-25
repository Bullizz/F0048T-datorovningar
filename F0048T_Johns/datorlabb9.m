%Fibre core radius
a = 5e-6;

% Core refractive index
n_1 = 1.545;

% Cladding refractive index
n_2 = 1.542;

% Vacume Wavelength and wavenumber
lambda0 = 1.5e-6;
k = 2*pi/lambda0;

%TODO: 
% Use the singlemod function to calculate the crosssection U
% and the propagation constants (b,g,kt), calculate the intensity and
% assign it to the variable I.

% Exempel på hur man använder singelmod
[ U, beta, gamma, kt, r] = singelmod(n_1,n_2,lambda0,a)

% Tilldela det beräknade effektiva brytningsindex
n_eff = beta / k;

% Tilldela den beräknade intensiteten

I = zeros(size(r)); % Preallocate intensity array

for i = 1:length(r)
    if r(i) <= a
        % Inside the core
        I(i) = (besselj(0, U * r(i) / a))^2;
    else
        % Inside the cladding
        I(i) = (besselj(0, U) * exp(-gamma * (r(i) - a)))^2;
    end
end

% Normalize intensity for visualization
intensitet = I / max(I);


% Generera resultatfiguren nedanför

fprintf('Effective refractive index (neff): %.6f\n', neff);
plot(r, intensitet);
title('Intensity Distribution');
xlabel('Radial Distance (r)');
ylabel('Normalized Intensity');
