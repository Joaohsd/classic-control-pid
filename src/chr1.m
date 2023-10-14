% using chr without overshooting

% P controller
kp = (0.3 * tal) / (k * theta);

sys_p = pidstd(kp);

sys_chr_p = feedback(sys_opened_loop*sys_p, 1);

% plottig
[output_chr_p, t, x] = step(delta_input * sys_chr_p, t);
plot(t, output_chr_p, t, degrau);
hold on;
grid on;
title('CHR Without Overshooting - P Controller');
xlabel('Time [s]');
ylabel('Y');
ylim([-2 15]);
h = legend('P', 'Step', 'location', 'southeast');
set(h, "fontsize", 14);
print -dpng 'figures/CHR/01-P_vs_step.png'
hold off

% PI controller
kp = (0.35 * tal) / (k * theta);
ti = 1.16 * tal;

sys_pi = pidstd(kp, ti);

sys_chr_pi = feedback(sys_opened_loop*sys_pi, 1);

% plottig
[output_chr_pi, t, x] = step(delta_input * sys_chr_pi, t);
plot(t, output_chr_pi, t, degrau);
hold on;
grid on;
title('CHR Without Overshooting - PI Controller');
xlabel('Time [s]');
ylabel('Y');
ylim([-2 15]);
h = legend('PI', 'Step', 'location', 'southeast');
set(h, "fontsize", 14);
print -dpng 'figures/CHR/02-PI_vs_step.png'
hold off;

% PID controller

kp = (0.6 * tal) / (k * theta);
ti = 1 * tal;
td = 0.5 * theta;

sys_pid = pidstd(kp, ti, td);

sys_chr_pid = feedback(sys_opened_loop*sys_pid, 1);

% plottig
[output_chr_pid, t, x] = step(delta_input * sys_chr_pid, t);
plot(t, output_chr_pid, t, degrau);
hold on;
grid on;
title('CHR Without Overshooting - PID Controller');
xlabel('Time [s]');
ylabel('Y');
ylim([-2 15]);
h = legend('PID', 'Step', 'location', 'southeast');
set(h, "fontsize", 14);
print -dpng 'figures/CHR/03-PID_vs_step.png'
hold off;

% Controllers comparison
plot(t, output_chr_p, 'r---');
hold on;
plot(t, output_chr_pi, 'g---');
hold on;
plot(t, output_chr_pid, 'b---');
hold on;
plot(t, degrau, 'k---');
hold on;
grid on;
title('CHR Without Overshooting - Controllers');
xlabel('Time [s]');
ylabel('Y');
ylim([-2 15]);
h = legend('P', 'PI', 'PID' , 'Setpoint', 'location', 'southeast');
set(h, "fontsize", 14);
print -dpng 'figures/CHR/04-Comparing_controllers.png'
hold off;
