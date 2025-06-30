close all

% FIGURA 1: ANDAMENTO NEL TEMPO DELL'INGRESSO DI TRAINING
figure(1)
plot(u_test, 'LineWidth', 1)
hold on
grid on
title('Ingresso per fare testing', 'FontSize', 16)
xlabel('time step', 'FontSize', 14)
ylabel('u_{test}', 'FontSize', 14)


% FIGURA 2: CONFRONTO TRA USCITA VERA E USCITA PREDETTA IN FASE DI TESTING
y_test = out.test_y.Data;
y_hat_test = out.test_y_hat.Data;
figure(2)
plot(y_test, 'LineWidth', 1)
hold on
grid on
plot(y_hat_test, 'LineWidth', 1)
title('Confronto tra uscita predetta e vera in fase di testing', 'FontSize', 16)
xlabel('time step', 'FontSize', 14)
legend({'y_{TRUE}', 'y_{hat}'}, 'FontSize', 12, 'Location', 'best')
xlim([0, length(y_hat_test)])