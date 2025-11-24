function moderSpegelvagledare()
    % Parametrar
    d           = 2e-6;  % Bredden av vågledaren 
    lambda      = 532e-9;  % Vågländen på ljuset
    M           = floor((2 * d) / lambda);  % Max anttalet moder som ryms i spegelvågledaren
    
    % Beräkna de olika vinklarna
    theta = asin([1: M] .* (lambda / (2 * d)))
    
    % Definera kantverktorer till simulering
    z       = linspace(0, 10e-6, 1000); % z kant
    y       = linspace(0, 10e-6, 200);  % y kant
    
    % För definera en matris där alla komplexa amplituder kan sparas.
    Uall    = zeros(length(y), length(z), M);

    % Loopa igenom alla moder och beräkna den komplexa amplituden
    for m = 1: M
        % Beräkna riktnings vektorerna
        s1      = [sin(theta(m)), cos(theta(m))];   % Riktnings cosinen för vågen i +y
        s2      = [sin(-theta(m)), cos(theta(m))]; % Riktnings cosinen för vågen i -y
        
        % Beräkna fas skillnaden som ska läggas på på den andra vågen
        alfa    = (m - 1) * pi;                     % fas skillnaden
    
        % Generera vågorna
        U1  = planewave(y, z, s1, lambda, alfa);        % Den komplexa amplituden i +theta
        U2  = planewave(y, z, s2, lambda, alfa);        % Den komplexa amplituden i -theta
        
        % Addera ihop vågorna
        U   = U1 + U2;
        
        % Spara resultatet i den fördefinnerade variabeln
        Uall(:, :, m) = U;
    end
    
    
    %%% Generera resultat bilder
    I       = abs(Uall).^2;
    [rows_Uall, cols_Uall] = size(Uall);
    Isnitt  = reshape(I(:, 1, :), 200, 7) / 4 + (1: M) * 1.5;
    
    idx     = 1;
    Rows    = 4;
    figure(1); clf;
    for m = 1: M
        if m == 4
            subplot(Rows, 1, m);
                imagesc(I(:, :, m));
                colormap('gray');
                axis xy;
                axis tight;
                yticks([1, 100, 200]);
                yticklabels({'-1', '0', '1'});
                xticks([1 500 1000]);
                xticklabels({'0', '5', '10'});
                xlabel('z [\mum]', 'fontsize', 16);
                title("m = " + m);
    
            figure(2); clf;
                idx     = 1;
                Rows    = 3;
        else
            subplot(Rows, 1, idx);
                imagesc(I(:, :, m));
                colormap('gray');
                axis tight;
                yticks([1, 100, 200]);
                yticklabels({'-1', '0', '1'});
                xticks([]);
                xticklabels({});
                title("m = " + m);
    
            idx = idx + 1;
        end  
    end
    xticks([1, 500, 1000]);
    xticklabels({'0', '5', '10'});
    xlabel('z [\mum]', 'fontsize', 16);
    
    figure(3); clf;
        % set(gcf, 'Position',[ 10, 10, 700, 200]);
        plot(Isnitt, y * 1e6, 'linewidth', 2);
        lgh = legend('1', '2', '3', '4', '5', '6', '7', 'location', 'west');
        lgh.Title.String = "Mode";
        ylabel('y [\mum]', 'FontSize', 16);
        xticks([]);
        xlabel('Intensitet (W/m^2)');
end