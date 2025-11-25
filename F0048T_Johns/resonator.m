function I = resonator(I0,R_1,R_2,d,c,nu)
   % Transmission coefficient (assumes lossless mirrors)
    
    F=pi*sqrt(R_1)/(1-R_1);
    % Phase term    
    phi = 2 * pi * nu * d / c;
    Imax=I0/((1-R_1)*(1-R_2));
    % Denominator term (1 - sqrt(R_1 * R_2) * cos(phi))^2
    %denominator = (1 - sqrt(R_1 * R_2) .* cos(phi)).^2;

    % Calculate the intensity inside the resonator
    I = Imax ./ (1+(2.*F/pi).^2*sin(phi).^2);
    
end