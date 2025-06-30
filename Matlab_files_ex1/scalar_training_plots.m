

% FIGURA 1: ANDAMENTO NEL TEMPO DELL'INGRESSO DI TRAINING
figure(1)
plot(u_base, 'LineWidth', 1)
hold on
grid on
title('Ingresso esploratore con cui si fa il training', 'FontSize', 16)
xlabel('time step', 'FontSize', 14)
ylabel('u', 'FontSize', 14)


% FIGURA 2: ANDAMENTO NEL TEMPO DEL QUADRATO DELL'ERRORE DI PREDIZIONE
squared_error_training = out.squared_error_training.Data;
figure(2)
plot(squared_error_training, 'LineWidth', 1)
hold on
grid on
xlim([0, length(squared_error_training)])
ylim(max(squared_error_training)*[-0.1, 1.1])
title('Errore quadratico durante la fase di training', 'FontSize', 16)
xlabel('time step', 'FontSize', 14)
ylabel('(y_{hat} - y)^2', 'FontSize', 14)


