function D = singelfiber_karak(X,V)
% D = singelfiber_karak(X,V)
% This function calculates the difference between the left and right 
% hand sides of the characteristic functions of a single mode fiber based 
% on the X and V parameters. It should be used together with a
% zero-crossing algorithm.

D = singelfiber_karak_vl(X)-singelfiber_karak_hl(X,V);
end