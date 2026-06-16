% This file generates the response of a single community to external
% perturbations

% This file can be used to generate Fig. 3c


x0 = 1;
T = 20;
dt = 1;
steps = T / dt;
time = 0:dt:T;
disturbance_time = 4;
disturbance_value = 0.5;



s = 0.4; 
r = s;
x1 = zeros(1, steps+1); 
x1(1) = x0;
for k = 1:steps
    if k == disturbance_time, x1(k) = disturbance_value; end
    x1(k+1) = x1(k) * exp(r - s*x1(k));
end
gr1 = exp(r - s * x1(1:end-1)) - 1;
stab1 = -log(abs(1 - s))

plot(time, x1, '-o',  'Color', [46 167 224]/255, 'LineWidth', 1, 'MarkerSize', 3); 
