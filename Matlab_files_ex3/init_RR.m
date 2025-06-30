clear all
close all

% PARAMETRI DI SIMULAZIONE
ST = 0.01;          % [s] - Tempo di campionamento
T_max = 300;        % [s] - Tempo di simulazione


% PARAMETRI FISICI
l1 = 4;         % [m] - Lunghezza del primo braccio
l2 = 3;         % [m] - Lunghezza del secondo braccio


% PARAMETRI GENERAZIONE RIFERIMENTO
T_ref = 120;
omega_r_1 = 5*2*pi/T_ref;
omega_r_2 = 7*2*pi/T_ref;
A_m = eye(2);
B_m = eye(2);
k_r = 10;
ksi_m_init = [(l1+l2)/sqrt(2); 0];


% PARAMETRI MODELLO DI IDENTIFICAZIONE
alfa = 1;


% PARAMETRI RETE NEURALE
q_limit = pi; % Le funzioni J_ij (q) verranno approssimate 
              % in un intervallo [-q_limit, +q_limit]

n_q1 = 21; % Numero centri per asse q1
n_q2 = 21; % Numero centri per asse q2

shift1 = ceil(n_q1/2);
shift2 = ceil(n_q2/2);

delta_q1 = 2*1.1*q_limit/(n_q1-1);
delta_q2 = 2*1.1*q_limit/(n_q2-1);

var_q1 = delta_q1^2/2/log(2);
var_q2 = delta_q2^2/2/log(2);
VAR = diag([var_q1, var_q2]);
VAR_inv = inv(VAR);

gamma = 100; %learning rate comune a tutte e 4 le reti

M = 1000; % raggio della palla che limita i pesi della rete

% PARAMETRI CONTROLLORE IDEALE
k_m = 1;
mu = 1;
u_sat = 5;

% PARAMETRI CONTROLLORE NEURALE
k_neural = 0.1;
T_kick_in = T_max+1;

% CONDIZIONI INIZIALI
q_init = [-pi/4; +pi/4];        % Condizione iniziale sullo stato vero
q_hat_init = [-pi/4; +pi/4];    % Condizione iniziale sulla stima dello stato

c_11_init = ones(n_q1*n_q2,1)/(n_q1*n_q2);
c_12_init = ones(n_q1*n_q2,1)/(n_q1*n_q2);
c_21_init = ones(n_q1*n_q2,1)/(n_q1*n_q2);
c_22_init = ones(n_q1*n_q2,1)/(n_q1*n_q2);