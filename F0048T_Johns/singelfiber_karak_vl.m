function VL = singelfiber_karak_vl(X)
% VL = singelfiber_karak_vl(X)
% This function defines the left hand side of the characteristic function
% for a single mode fiber based on the X parameter

VL = X.*besselj(1,X)./besselj(0,X);
end

