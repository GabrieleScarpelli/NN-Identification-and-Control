
close all

c = out.c.Data;
y_hat = out.y_hat.Data;

Tmax = out.tout(end);

skip_frames = 1;

FPS = 30;

shift = ceil(n_nodes/2);

f = figure;                     %   Crea una figura (vuota per ora)
f.WindowState = 'maximized';    %   Imposta la figura a schermo intero
grid on;                        %   Attiva la griglia


% Aggiungi titolo alla figura
title('Identificazione del modello - fase di training', 'FontSize', 16);


% Asse ascisse
min_u = min(u);
max_u = max(u);

if min_u<0
    min_u_axis = 1.1*min_u;
else
    min_u_axis = 0.9*min_u;
end

if max_u<0
    max_u_axis = 0.9*max_u;
else
    max_u_axis = 1.1*max_u;
end
u_plot = min_u_axis:0.01:max_u_axis;
xlabel('u', 'FontSize', 14);

% Asse ordinate
max_y_hat = max(y_hat);
min_y_hat = min(y_hat);
if min_y_hat<0
    min_y_hat_axis = 1.1*min_y_hat;
else
    min_y_hat_axis = 0.9*min_y_hat;
end

if max_y_hat<0
    max_y_hat_axis = 0.5*max_y_hat;
else
    max_y_hat_axis = 1.5*max_y_hat;
end

axis ([min_u_axis, max_u_axis, min_y_hat_axis, max_y_hat_axis]);
hold on;
grid on;

% Forza la figura ad avere dimensioni multipli di 2
pos = get(f, 'Position'); % Ottieni la posizione corrente
pos(3:4) = 2 * ceil(pos(3:4) / 2); % Arrotonda larghezza e altezza al multiplo di 2
set(f, 'Position', pos); % Applica la nuova posizione


% Linee che delimitano ingressi forniti per identificazione
line([min_u, min_u], [min_y_hat_axis-0.5, max_y_hat_axis+0.5], 'Color', 'black', 'LineStyle', '--');
line([max_u, max_u], [min_y_hat_axis-0.5, max_y_hat_axis+0.5], 'Color', 'black', 'LineStyle', '--');

% Aggiungi etichette per u_min e u_max
text(min_u, min_y_hat_axis - 0.1 * abs(min_y_hat_axis), 'u_{min}', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'FontSize', 12);
text(max_u, min_y_hat_axis - 0.1 * abs(min_y_hat_axis), 'u_{max}', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'top', 'FontSize', 12);

% Disegna funzione vera
f_true_plot = u_plot;
for i = 1:length(f_true_plot)
    f_true_plot(i) = true_system(u_plot(i));
end
h_true = plot(u_plot, f_true_plot, 'Color', 'b', 'LineWidth', 1);
hold on
grid on

% Inizializza disegno funzione approssimata
f_hat_plot = u_plot;
for i = 1:length(f_hat_plot)
    f_hat_plot(i) = 0;
    for j = 1:n_nodes
        k = j - shift;
        f_hat_plot(i) = f_hat_plot(i) + c(1,j)*grf(u_plot(i), k, delta);
    end
end
h_hat = plot(u_plot, f_hat_plot, 'Color', 'r', 'LineWidth', 1);
h_legend = legend([h_true, h_hat], {'f_{TRUE}(u)', 'f_{hat}(u)'}, 'FontSize', 12, 'Location', 'best');

% Prepara i riquadri di testo per il contatore
current_cycle_text = annotation('textbox', [0.15, 0.85, 0.25, 0.07], 'String', '', ...
    'EdgeColor', 'black', 'FontSize', 12, 'BackgroundColor', [1 1 0.8], ...
    'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', 'FitBoxToText', 'on');
current_step_text = annotation('textbox', [0.15, 0.78, 0.25, 0.07], 'String', '', ...
    'EdgeColor', 'black', 'FontSize', 12, 'BackgroundColor', [1 1 0.8], ...
    'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', 'FitBoxToText', 'on');
learning_rate_text = annotation('textbox', [0.15, 0.71, 0.25, 0.07], 'String', '', ...
    'EdgeColor', 'black', 'FontSize', 12, 'BackgroundColor', [1 1 0.8], ...
    'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', 'FitBoxToText', 'on');

% Animazione
v = VideoWriter('scalar_training_animation', 'MPEG-4');
v.FrameRate = FPS;  % Set frame rate based on dt
open(v);  % Open the video file

for l = 2:floor(length(out.tout)/skip_frames)
    
    tic;

    m = l*skip_frames;
    
    for i = 1:length(f_hat_plot)
        f_hat_plot(i) = 0;
        for j = 1:n_nodes
            k = j - shift;
            f_hat_plot(i) = f_hat_plot(i) + c(m,j)*grf(u_plot(i), k, delta);
        end
    end
    set(h_hat, 'YData', f_hat_plot);

    % Aggiorna il contatore di cicli e step
    cycle_number = floor(m / length(u_base)) + 1;
    step_within_cycle = mod(m, length(u_base));
    set(current_cycle_text, 'String', sprintf('Ciclo corrente: %d / %d', cycle_number, n_cicli));
    set(current_step_text, 'String', sprintf('Step all''interno del ciclo: %d / %d', step_within_cycle, length(u_base)));
    set(learning_rate_text, 'String', sprintf('Learning rate k_a = %.01f', k_a));

    % Capture the frame
    frame = getframe(gcf);
    writeVideo(v, frame);  % Write the frame to video

    % Measure computation time
    computation_time = toc;
    
    % Adjust pause to achieve stable framerate
    pause_time = max(0, 1/FPS - computation_time);
    pause(pause_time);

end

close(v); % Chiude il file video
