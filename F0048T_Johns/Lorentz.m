function [s,v] = Lorentz(s0,l0,dv)
% [s,v] = Lorentz(s0,l0,dv)
% This function returns the Lorentian function.
% Input:
%   s0 - The maximum transision area
%   l0 - The transision wavelength
%   dv - The bandwidth
% Output:
%   s - The lorentian shape vector
%   v - The corresponding frequencies to the lorentsian shape

% Define parameters
c   = 3e8;
v0  = c/l0;
S   = s0*pi*dv/2;
v   = linspace(v0-3*dv,v0+3*dv,100000);     % The frequencies

% Define the lorentsian shape
g   = dv/(2*pi)./((v0-v).^2+(dv/2).^2);
s   = S*g;                                  % The lorentsian shape
end