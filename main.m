%%
%
% Simple Rocket Trajectory in 2 Dimensions
%
%%

% Constants
m0 = 1E4;                   % Initial mass (kg)
m1 = 500;                   % Mass of Payload (kg)
mu = 3.98614E5;             % Earth's gravitational parameter (km^3/s^2)
g0 = 9.81;                  % Gravity (m/s^2)

Isp = 300;                  % Specific impulse (s)
c = Isp * (g0 * 1E-3);      % Exhaust velocity (km/s)

beta = (3 * m0 * (g0 * 1E-3)) / c;         % Mass flow rate (kg/s)

% Initial Conditions 

x0 = 0;                     % Initial x-position (km)
y0 = 6371;                  % Initial y-position (km)
vx0 = 0.1;%0.5 * cos(deg2rad(50));                  % Initial x-velocity (km/s)
vy0 = 0.1;%0.5 * sin(deg2rad(50));                  % Initial y-velocity (km/s)
m_initial = m0;             % Initial mass (kg)


t1 = ( m0 - m1 ) / beta;
disp(t1);

Y0 = [x0; y0; vx0; vy0; m_initial];
t_span = [0, t1];

[t, Y] = ode113(@trust_trajectory, t_span, Y0);

x = Y(:, 1);
y = Y(:,2);
vx = Y(:,3);
m01 = Y(:,5);


t_span_ballistic = [t1, t1 + 5000];

x0_ballistic = Y(end, 1);
y0_ballistic = Y(end, 2);
vx0_ballistic = Y(end, 3);
vy0_ballistic = Y(end, 4);
m_ballistic = Y(end, 5);

Y0_ballistic = [x0_ballistic; y0_ballistic; vx0_ballistic; vy0_ballistic; m_ballistic];

[t_ballistic, Y_ballistic] = ode113(@ballistic_trajectory, t_span_ballistic, Y0_ballistic);

Y_total = [Y; Y_ballistic];

x_total = Y_total(:, 1);
y_total = Y_total(:, 2);

% Plot Trajectory
figure;
plot(x_total, y_total, 'b-', 'LineWidth', 2);
ylim([5000, 16000]);
xlim([0,750]);
xlabel('x-position (km)');
ylabel('y-position (km)');
title('Rocket Trajectory');
grid on;
