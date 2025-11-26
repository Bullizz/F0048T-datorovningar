function I = resonator(I0, R_1, R_2, d, c, nu)
    alpha_s = 0; % Assumption
    r_abs   = sqrt(R_1 * R_2) * exp((-alpha_s) * d);
    I_max   = I0 / ((1 - r_abs)^2);
    nu_f    = c / (2 * d);
    F       = (pi * sqrt(r_abs)) / (1 - r_abs);
    
    I       = I_max ./ (1 + ((((2 * F) ./ pi).^2) * ((sin((pi * nu) ./ nu_f)).^2)));
end