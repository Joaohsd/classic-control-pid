% PID Controller
kp = (1 / ((theta / tal) + 0.2)) / k;
ti = ((0.3 * (theta / tal) + 1.2) / ((theta / tal) + 0.08)) * theta;
td = (1 / (90 * (theta / tal))) * theta;

sys_pid = pidstd(kp, ti, td);

sys_integral_pid = feedback(sys_opened_loop*sys_pid, 1);

% plotting
[output_integral_pid, t, x] = step(delta_input * sys_integral_pid, t);
plot(t, output_integral_pid, t, degrau);
hold on;
grid on;
title('Integral of the absolute error - PID Controller');
xlabel('Time [s]');
ylabel('Y');
ylim([-2 15]);
h = legend('PID', 'Step', 'location', 'southeast');
set(h, "fontsize", 14);
print -dpng 'figures/IAE/01-PID_vs_step.png'
hold off;
