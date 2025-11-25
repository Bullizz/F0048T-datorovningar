function [b,g,kt] = singelfiber_propkonst(X,V,a,k1)
% [b,g,kt] = singelfiber_propkonst(X,V,a,k1)
% This functions calculates the propagation constants for a single mode
% fiber.
% Input:
%   X   - The x parameter 
%   V   - The V parameter for the fiber
%   a   - The core radius
%   k1  - The core wavenumber
% Output:
%   b   - The discrete propagation constant
%   g   - The rate of change in the cladding
%   kt  - The rate of change in the core

b   = sqrt(k1^2-(X/a)^2);   % The propagation constante
kt  = X/a;                  % Rate of change in the core
Y   = sqrt(V^2-X^2);        %
g   = Y/a;                  % Rate of change in the cladding
end