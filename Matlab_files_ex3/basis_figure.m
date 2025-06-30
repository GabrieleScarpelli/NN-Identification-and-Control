
% THIS IS ONLY FOR PRODUCING AN EXAMPLE IMAGE!!
% THIS DOES NOT CORRESPOND TO THE REAL NETWORK USED FOR IDENTIFICATION

% Network dimensions
n_q1 = 3;
n_q2 = 3;

shift1 = ceil(n_q1/2);
shift2 = ceil(n_q2/2);

delta_q1 = 2*1.1*q_limit/(n_q1-1);
delta_q2 = 2*1.1*q_limit/(n_q2-1);

var_q1 = delta_q1^2/2/log(2);
var_q2 = delta_q2^2/2/log(2);
VAR = diag([var_q1, var_q2]);
VAR_inv = inv(VAR);

% Mean vectors

means = zeros(2, n_q1*n_q2);

for i = 1:length(means)

    k = ceil(i/n_q1);
    p = mod(i+n_q1-1, n_q1)+1;
    sprintf("k = %d, p = %d",k , p)
    centro_kp = [(k - shift1)*delta_q1; (p - shift2)*delta_q2];
    means(:,i) = centro_kp;

end

% Grid for q_1 and q_2
[q1, q2] = meshgrid(-3*pi:0.01:3*pi, -3*pi:0.01:3*pi);
[n, p] = size(q1);

% Number of basis functions
num_basis = size(means, 2);

% Initialize xi(q)
xi = zeros(n, p, num_basis);

% Compute each xi_i(q)
for i = 1:num_basis
    q_diff = [q1(:)'; q2(:)'] - means(:, i);
    xi(:, :, i) = reshape(exp(-0.5 * sum((VAR \ q_diff) .* q_diff, 1)), [n, p]);
end

% Plot all xi_i(q) on a single panel
figure;
hold on; % Enable overlay of plots
for i = 1:num_basis
    surf(q1, q2, xi(:, :, i), 'EdgeColor', 'none', 'FaceAlpha', 0.7); % Transparent surfaces
end
hold off;

% Add labels and title
title('Gaussian Basis Functions', 'FontSize', 16);
xlabel('q_1', 'FontSize', 12);
ylabel('q_2', 'FontSize', 12);
zlabel('\xi_i(q)', 'FontSize', 12);

% Formatting for clarity
colormap jet;
shading interp;
grid on;
colorbar;

view(45, 30); % Set the view angle: azimuth = 45°, elevation = 30°