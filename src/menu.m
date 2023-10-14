kp = input("Kp value: ");
ti = input("Ti value: ");
td = input("Td value: ");
setpoint = input("Setpoint value: ");
y_max = setpoint * 1.5;

sys_pid = pidstd(kp, ti, td);

sys_series_pid = feedback(sys_opened_loop*sys_pid, 1);
[output, t, x] = step(setpoint * sys_series_pid, t)
setpoint = setpoint * ones(181,1);
plot(t, output, t, setpoint);
grid on;
title('Constants from user input - PID Controller');
xlabel('Time [s]');
ylabel('Y');
ylim([-2 y_max]);
h = legend('PID', 'Step', 'location', 'southeast');
set(h, "fontsize", 14);

