function [U,b,g,kt,r] = singelmod(n1,n2,lambda0,a)
% [U,b,g,kt,r] = singelmod( n1,n2,lambda0,a)
% This function calculates the complex amplitude U, the propagation
% constants (b,g,kt) over the cross-section, r, for a single mode fiber
% with core refractive index n1 and cladding refractive index n2, core
% radius, a, and for a vacuum wavelength lambda0.

k0          = 2*pi/lambda0;
NA          = sqrt(n1^2-n2^2);
V           = k0*a*NA;
delta       = 1e-10;
x           = fzero(@(x) singelfiber_karak(x,V),[delta V-delta]);
[b g kt]    = singelfiber_propkonst(x,V,a,k0*n1);
neff        = b/k0;
skal        = besselj(0,kt*a)/besselk(0,g*a);
r           = linspace(-3*a,3*a);
rk          = abs(r);
rk(45:55)   = a/2;
w           = abs(r)<= a;
U           = besselj(0,kt*r).*w;
w           = abs(r)>a;
Uu          = skal*besselk(0,g*rk).*w;
U           = U+Uu;

end

