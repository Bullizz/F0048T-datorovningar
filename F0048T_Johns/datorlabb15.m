% Indata
A       = imread('cameraman','tiff'); % Referens figur 'Cameraman.tiff'
I       = double(A); % Formatändring int -> double
mask    = I/max(max(I)); % Omskalning [0, 255] -> [0, 1]
T       = (2:4) * 1e3; % Temperatur - 2000K, 3000K, 4000K
r       = 1e-3; % Radie på 
R       = 1e-1; % Fokallängd = avstånd från källa
vmin    = 3e8 / 1e-6; % Undre frekvens
vmax    = 3e8 / 0.4e-6; % Övre frekvens
v       = linspace(vmin,vmax); % Frekvens array
dv      = v(2) - v(1); % Frekvens differens
NA      = 0.3; % Numerisk Apertur
dA      = (2e-6)^2; % Detektor area
dt      = 1e-3; % Exponeringstid


bild = zeros(size(mask,1), size(mask,2), length(T));
for i = 1 : length(T)
    % Ljusets frekvensfördelning, Blackbody() - se förra uppgiften.
    F = Blackbody(v, T(i), r, R, NA);
    % Detekterade antalet fotoner
    E = F.*dA.*dt.*dv; 
    
    for p = 1 : length(F) %
        % Antalet detekterade fotoner, i varje frekvens-steg, modulerat med "mask".
        n = E .* mask;
        
        % Variabel för att kunna använda random(), angiven i problem beskrivning
        par = 1/(n+1);
        
        % Detektering
        bild(:,:,i) = bild(:,:,i) + random('geo',par);
    end
    figure;
    titel = sprintf('Temperature=%d K',T(i));
    imagesc(bild(:,:,i))
    colormap(gray(256))
    colorbar
    axis('image')
    title(titel)
end
