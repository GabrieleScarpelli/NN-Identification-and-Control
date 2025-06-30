

% PRELEVA I PESI RISULTATO DEL TRAINING
c = out.c.Data;
c_trained = c(end, :);


% DEFINIZIONE INGRESSO TESTING 
u_test_part1 = zeros(1,100);
u_test_part2 = zeros(1,100);

for i=1:100
    u_test_part1(i) = u_amplitude*(1 - exp(-i/100));
    u_test_part2(i) = u_amplitude*cos((i/42)*2*pi)*sin((i/68)*2*pi);
end

u_test = [u_test_part1, u_test_part2]';

% VETTORE DEI TEMPI
time_test = (1:ST:length(u_test))';