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
    z
    % Define the complex amplitude
    A_0 = 1;
    U = (A_0 * exp(1i * ((k * [Y + Z]) + alfa)));
end