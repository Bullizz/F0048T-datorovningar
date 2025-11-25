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
 
    % Create the grid
    [Z, Y] = meshgrid(z, y);
    
    % Calculate the wavenumber
    k = 2 * pi / lambda;
    
    % Compute the phase term
    phi = k * (s(1) * Y + s(2) * Z) + alfa;
    
    % Compute the complex amplitude
    U = exp(1i * phi);
end
