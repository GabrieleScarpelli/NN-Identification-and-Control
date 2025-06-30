clear all
close all


% PARAMETRI DI SIMULAZIONE
ST = 1;


% INGRESSO PER TRAINING
u_amplitude = 1.5;

u_part1 = zeros(1,100);
u_part2 = zeros(1,100);
u_part3 = zeros(1,100);
u_part4 = zeros(1,100);

for i=1:100
    u_part1(i) = u_amplitude*sin((i/100)*2*pi);
    u_part2(i) = u_amplitude*cos((i/37)*2*pi);
    u_part3(i) = u_amplitude*(i-50)/50;
    u_part4(i) = -u_amplitude*(i-50)/50;
end

u_base = [u_part1, u_part2, u_part3, u_part4]';

n_cicli = 2;

u = [];

for i = 1:n_cicli
    u = [u; u_base];
end


% VETTORE DEI TEMPI
time = (1:ST:length(u))';


% PARAMETRI E PESI INIZIALI DELLA RETE
n_nodes = 50;
delta = 1.2*u_amplitude/(n_nodes/2);
k_a = 0.1;
c_init = (1/n_nodes)*ones(1, n_nodes);
