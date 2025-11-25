function tvarsnittFiber()
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
    [ U, beta, gamma, kt, r] = singelmod(n_1,n_2,lambda0,a);
    
    % Tilldela det beräknade effektiva brytningsindex
    n_eff = beta / k;

    % Tilldela den beräknade intensiteten
    intensitet = abs(U).^2;
    
    % Generera resultatfiguren nedanför
    figure(1);
        plot(r, intensitet);
        xlabel("Radius, [m]");
        ylabel("Intensity [W/m^2]");
end