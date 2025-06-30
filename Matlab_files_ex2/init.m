clear all
close all


% % PARAMETRI INGRESSO DI CALIBRAZIONE
% T_base = 20;
% A_calib = T_base/5;
% T_calib = 10*T_base;


% PARAMETRI DI SIMULAZIONE
ST = 0.01;          % [s] - Tempo di campionamento
T_max = 120;       % [s] - Tempo di simulazione


% INTERVALLO VARIABILE DI GIUNTO
% Le funzioni f(q), H(q), J(q), verranno approssimate in un intervallo 
% q appartenente a [-q_limit, +q_limit]
q_limit = pi;


% PARAMETRI GENERAZIONE RIFERIMENTO
omega_r = 5*2*pi/T_max;
a_r = 1.1;
a_m = 1;
b_m = 1;
k_r = 10;
alfa = 1;


% PARAMETRI CONTROLLORE
k_m = 10;

% PARAMETRI RETE N_H
numero_nodi_H = 41;                         % numero di gaussiane che approssima H(q)
shift_H = ceil(numero_nodi_H/2);            % shift tra gli indici i e k 
lr_H = 1;                                   % learning rate della rete H
delta_q_H = 1.5*q_limit/shift_H;                % distanza tra i centri delle gaussiane
var_H = delta_q_H^2/2/log(2);               % varianza delle gaussiane
centri_H = zeros(1,numero_nodi_H);          % vettore che raccoglie i centri delle gaussiane
M_H = 0.5;                                  % raggio della palla che limita i pesi della rete
for i = 1:length(centri_H)
    k = i - shift_H;
    centri_H(i) = k*delta_q_H;
end


% PARAMETRI RETE N_f
numero_nodi_f = 41;                         % numero di gaussiane che approssima f(q)
shift_f = ceil(numero_nodi_f/2);            % shift tra gli indici i e k 
lr_f = 0.2;                                   % learning rate della rete f
delta_q_f = 1.5*q_limit/shift_f;                % distanza tra i centri delle gaussiane
var_f = delta_q_f^2/2/log(2);               % varianza delle gaussiane
centri_f = zeros(1,numero_nodi_f);          % vettore che raccoglie i centri delle gaussiane
M_f = 100;                                  % raggio della palla che limita i pesi della rete
for i = 1:length(centri_f)
    k = i - shift_f;
    centri_f(i) = k*delta_q_f;
end


% CONDIZIONI INIZIALI
q_init = 0;                                 % Condizione iniziale sullo stato vero
q_hat_init = 0;                             % Condizione iniziale sulla stima dello stato
c_H_init = zeros(1, numero_nodi_H);         % Condizione iniziale sui pesi della rete N_H
c_f_init = (1/numero_nodi_f)*ones(1, numero_nodi_f);    % Condizione iniziale sui pesi della rete N_f
