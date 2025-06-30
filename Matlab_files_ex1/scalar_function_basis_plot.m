close all

u_grf_plot = -1.5*u_amplitude:.01:+1.5*u_amplitude;
shift = ceil(n_nodes/2);

f = figure(1);

gaus_rad_sum = zeros(length(u_grf_plot));
for i=1:n_nodes
    
    k = i - shift;
    gaus_rad_k = u_grf_plot;
    
    for j=1:length(u_grf_plot)
        gaus_rad_k(j) = exp(-pi^2 * (u_grf_plot(j) - k*delta)^2);
        gaus_rad_sum(j) = gaus_rad_sum(j) + gaus_rad_k(j);
    end
    
    plot(u_grf_plot, gaus_rad_k) 
    hold on
    grid on

end

title("Base di funzioni gaussiane - 50 nodi", 'FontSize', 16)
xlabel("u", 'FontSize', 14)