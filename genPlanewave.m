function genPlanewave()
    lambda  = 1e-6;                         % The wavelength          [m]
    theta   = 10;                           % The angle z axis        [rad]
    alfa    = 0;                            % The phase constant      [ ]
    y       = linspace(0, 1e-5, 500);       % y axis for sim          [m]
    z       = linspace(0, 1e-5, 500);       % z axis for sim          [m]
    s       = [sind(theta), cosd(theta)];   % The directional vector
    
    % Call the function that generates a plane wave
    U = planewave(y,z,s,lambda,alfa);
    
    % U_abs = abs(U([y, z]'));
    figure(1); clf;
    
    % Plot the wave
    % figure(1)
    subplot(1, 2, 1);
    imagesc(abs(U).^2)
    title('Intensity','fontsize',18)
    colormap(gray)
    axis equal
    axis xy
    axis off
    
    % figure(2)
    subplot(1, 2, 2);
    imagesc(angle(U))
    title('Phase','fontsize',18)
    colormap(gray)
    axis equal
    axis xy
    axis off
end