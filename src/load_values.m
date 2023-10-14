% loading control package
pkg load control;

% loading dataset from .mat file
load transfer_function/TransferFunction13.mat;

% plotting output x time
%plot(t, saida);

% defining transfer function using smith method
delta_output = saida(181) - saida(1);
delta_input = degrau(1);

% getting k
k = delta_output / delta_input;

% getting output values for t1 and t2
v_t1 = 0.283 * delta_output;
v_t2 = 0.632 * delta_output;

% getting t1 and t2 values using array values
t1 = t(16);
t2 = t(36);

% getting t value
tal = 1.5 * (t2 - t1);

% getting theta value
theta = t2 - tal;

% system with delay
sys_without_delay = tf([k], [tal 1]);

% creating delay
[num, den] = padecoef(theta, 20);
h_pade = tf(num, den);

% inserting delay on system
sys_opened_loop = sys_without_delay * h_pade;

% using step function in order to get output estimated values
[output_open_loop, t, x] = step(delta_input * sys_opened_loop, t);

% comparing two transfer functions
%hf = figure();
%plot(t, output_open_loop, t, saida);
%grid on;
%title('Comparing output estimated versus expected');
%xlabel('Time [s]');
%ylabel('Y');
%ylim([-2 21]);
%legend('Output Estimated', 'Output Expected', 'location', 'southeast');
%print(hf, "transfer_functions.pdf", "-dpdflatexstandalone");

%hf = figure();
%plot(t, output_open_loop, t, degrau);
%grid on;
%title('Comparing Opened Loop versus Step');
%xlabel('Time [s]');
%ylabel('Y');
%ylim([-2 21]);
%legend('Opened Loop', 'Step', 'location', 'southeast');
%print(hf, "output_opened_loop_vs_degrau.pdf", "-dpdflatexstandalone");

% error in open loop case
error_open_loop = delta_input - delta_output;

% creating closed loop system
sys_closed_loop = feedback(sys_opened_loop, 1)

% getting output of closed loop applying a step of 13
%hf = figure();
%[output_closed_loop, t, x] = step(delta_input * sys_closed_loop, t)
%plot(t, output_closed_loop, t, degrau);
%grid on;
%title('Comparing Closed Loop versus Step');
%xlabel('Time [s]');
%ylabel('Y');
%ylim([-2 15]);
%legend('Closed Loop', 'Step', 'location', 'southeast');
%saveas(hf, "output_closed_loop_vs_degrau.png", "png");

error_closed_loop = delta_input - output_closed_loop(181)









