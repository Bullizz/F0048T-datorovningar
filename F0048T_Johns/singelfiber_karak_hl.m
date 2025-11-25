function HL = singelfiber_karak_hl(X,V)
% HL = singelfiber_karak_hl(X,V)
% This function defines the right hand side of the characteristic function
% for a single mode fiber based on the X and V parameters

Y   = sqrt(V^2-X.^2);
HL  = Y.*besselk(1,Y)./besselk(0,Y);
end