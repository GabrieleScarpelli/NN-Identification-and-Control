% This scripts produces an animation of the simulation

close all

rho = 0.2;

dt = 0.02;

skip_frames = 10;

% Fetch task variables
x_m = out.x_m.Data(1,1,:);
y_m = out.y_m.Data(1,1,:);
x_true = out.true_ksi_1.Data(1,1,:);
y_true = out.true_ksi_2.Data(1,1,:);
q_1 = out.q_1.Data(1,1,:);
q_2 = out.q_2.Data(1,1,:);

f = figure;                     %   Crea una figura (vuota per ora)
f.WindowState = 'maximized';    %   Imposta la figura a schermo intero
grid on;                        %   Attiva la griglia

% Aggiungi titolo alla figura
title('Animazione inseguimento', 'FontSize', 16);

% Imposta limite assi
max_x = (l1+l2+1);
min_x = -(l1+l2+1);
max_y = (l1+l2+1);
min_y = -(l1+l2+1);
axis ([-(l1+l2+1), (l1+l2+1), -(l1+l2+1), (l1+l2+1)]);
axis equal
hold on;
grid on;

%   Inizializza h1 come "grafico" di y_m in funzione di x_m, per ora
%   aggiungendo solo la coppia di punti y(t=0), x(t=0) . Il resto dei
%   punti del grafico si aggiungono piano piano più tardi così da creare l'effetto di
%   animazione della figura
h_m = plot(x_m(1), y_m(1), 'Color', 'r', 'LineWidth', 1);
h_true = plot(x_true(1), y_true(1), 'Color', 'b', 'LineWidth', 1);

% Crea il tondino
tondino_m = rectangle('Position', [x_m(1) - rho/2, y_m(1) - rho/2, rho, rho], 'Curvature',[1, 1]);
tondino_true = rectangle('Position', [x_true(1) - rho/2, y_true(1) - rho/2, rho, rho], 'Curvature',[1, 1]);

% Disegna assi x e y
line([0, 0], [-2*max_y, 2*max_y], 'Color', 'black', 'LineStyle', '-');  % Linea verticale
line([-2*max_x, 2*max_x], [0, 0], 'Color', 'black', 'LineStyle', '-');  % Linea orizzontale

% Prepara i riquadri di testo
time_show_text = annotation('textbox', [0.5, 0.25, 0.25, 0.1], 'String', '', ...
    'EdgeColor', 'black', 'FontSize', 12, 'BackgroundColor', [1 1 0.8], ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'FitBoxToText', 'on');

% Legenda
h_legend = legend([h_m], {'\xi_{m}(t)'}, 'FontSize', 12, 'Location', 'southwest');

% Create a video writer object
v = VideoWriter('reference_animation', 'MPEG-4');
v.FrameRate = 1/dt;  % Set frame rate based on dt
open(v);  % Open the video file

for k = 2:floor(length(out.tout)/skip_frames)
    tic;  % Start timer
    
    i = k * skip_frames;

    % Update plot data
    set(h_m, 'XData', x_m(1:i), 'YData', y_m(1:i));

    % Delete old shapes
    delete(tondino_m);

    % Draw new shapes
    tondino_m = rectangle('Position', [x_m(i) - rho/2, y_m(i) - rho/2, rho, rho], 'Curvature',[1, 1]);
    
    % Update time show
    set(time_show_text, 'String', sprintf('t = %.1f / %d [s]', out.tout(i), T_max));

    % Force draw
    drawnow;

    % Capture the frame
    frame = getframe(gcf);
    writeVideo(v, frame);  % Write the frame to video

    % Measure computation time
    computation_time = toc;
    
    % Adjust pause to achieve stable framerate
    pause_time = max(0, dt - computation_time);
    pause(pause_time);
end

% Close the video file
close(v);
