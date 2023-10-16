% Entry values
kp = input("Kp value: ");
ti = input("Ti value: ");
td = input("Td value: ");
setpoint = input("Setpoint value: ");

sys_pid = pidstd(kp, ti, td);
sys_series_pid = feedback(sys_opened_loop*sys_pid, 1);

% plotting
[output, t, x] = step(setpoint * sys_series_pid, t);
setpoint = setpoint * ones(181,1);
plot(t, output, 'r---', t, setpoint, 'g---', t, output_chr_pid, 'b---', t, output_integral_pid, 'k---');
grid on;
title('Comparing PID Controller');
xlabel('Time [s]');
ylabel('Y');
ylim([-2 max(output + 1)]);
h = legend('User PID', 'Setpoint', 'CHR PID', 'IAE PID', 'location', 'southeast');
set(h, "fontsize", 14);

axes('Position', [0.4 0.5 0.2 0.3]);
plot(t, output, 'r---', 'linewidth', 1.5);

xlim([4.5 5.25]);
ylim([12.9 13.1]);
grid on;
%{
% plotting
[output, t, x] = step(setpoint * sys_series_pid, t);
setpoint = setpoint * ones(181,1);
plot(t, output, t, setpoint);
grid on;
title('Constants from user input - PID Controller');
xlabel('Time [s]');
ylabel('Y');
ylim([-2 max(output + 1)]);
h = legend('PID', 'Step', 'location', 'southeast');
set(h, "fontsize", 14);

axes('Position', [0.4 0.5 0.2 0.3]);
plot(t, output, 'b---', 'linewidth', 1.5);

xlim([4.5 5.25]);
ylim([19.9 20.1]);
grid on;
}%


