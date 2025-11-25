lambda  = 10^-6;   % The wavelength          [m]
theta   = 10;   % The angle z axis        [rad]
alfa    = 0;   % The phase constant
y       = linspace(0, 10*10^-6, 500);   % y axis for sim          [m]
z       = linspace(0, 10*10^-6, 500);   % z axis for sim          [m]
s       = [sind(theta), cosd(theta)];   % The directional vector

% Call the function that generates a plane wave
 U = planewave(y,z,s,lambda,alfa);
 
 % Plot the wave
 figure(1)
 imagesc(abs(U).^2)
 title('Intensity','fontsize',18)
 colormap(gray)
 axis equal
 axis xy
 axis off
 
 figure(2)
 imagesc(angle(U))
 title('Phase','fontsize',18)
 colormap(gray)
 axis equal
 axis xy
 axis off