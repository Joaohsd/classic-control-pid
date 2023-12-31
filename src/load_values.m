% loading control package
pkg load control;

% loading dataset from .mat file
load transfer_function/TransferFunction13.mat;

% defining transfer function using smith method
delta_output = saida(end) - saida(1);
delta_input = degrau(1);

% getting k
k = delta_output / delta_input;

% getting output values for t1 and t2
v_t1 = 0.283 * delta_output;
v_t2 = 0.632 * delta_output;

% getting t1 and t2 values using array values
t1 = t(16);
t2 = t(36);

% getting tal value
tal = 1.5 * (t2 - t1);

% getting theta value
theta = t2 - tal;

% system without delay
sys_without_delay = tf([k], [tal 1]);

% creating delay
[num, den] = padecoef(theta, 20);
h_pade = tf(num, den);

% inserting delay on system
sys_opened_loop = sys_without_delay * h_pade;

% using step function in order to get output estimated values
[output_opened_loop, t, x] = step(delta_input * sys_opened_loop, t);

% comparing two transfer functions
plot(t, output_opened_loop, t, saida);
hold on;
grid on;
title('Comparing estimated versus expected transfer functions');
xlabel('Time [s]');
ylabel('Y');
ylim([-2 21]);
legend('Estimated output', 'Expected output', 'location', 'southeast');
print -dpng 'figures/01-Comparing_transfer_functions.png'
hold off;

% comparing output of opened loop with input required
plot(t, output_opened_loop, t, degrau);
hold on;
grid on;
title('Comparing Opened Loop versus Step');
xlabel('Time [s]');
ylabel('Y');
ylim([-2 21]);
legend('Opened Loop', 'Step', 'location', 'southeast');
print -dpng 'figures/02-Output_opened_loop_vs_step.png'
hold off;

% error in opened loop case
error_opened_loop_real = delta_input - saida(end)
error_opened_loop_predict = delta_input - output_opened_loop(end)

% creating closed loop system
sys_closed_loop = feedback(sys_opened_loop, 1);

% getting output of closed loop applying a step of 13
[output_closed_loop, t, x] = step(delta_input * sys_closed_loop, t);
plot(t, output_closed_loop, t, degrau);
hold on;
grid on;
title('Comparing Closed Loop versus Step');
xlabel('Time [s]');
ylabel('Y');
ylim([-2 15]);
legend('Closed Loop', 'Step', 'location', 'southeast');
print -dpng 'figures/03-Output_closed_loop_vs_step.png'
hold off;

% error in closed loop case
error_closed_loop_predict = delta_input - output_closed_loop(end)

