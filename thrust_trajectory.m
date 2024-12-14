function dydt = thrust_trajectory(t, Y)
    mu = 3.98614E5;           % Earth's gravitational parameter (km^3/s^2)
    g0 = 9.81;                % Standard gravity (m/s^2)
    Isp = 300;                % Specific impulse (s)
    c = Isp * g0 * 1E-3;      % Exhaust velocity (km/s)
    m0 = 1E4;

    beta = (3 * m0 * (g0 * 1E-3)) / c; % Mass flow rate (kg/s)


    r = sqrt(Y(1)^2 + Y(2)^2); % Distance from Earth's center (km)
    v = sqrt(Y(3)^2 + Y(4)^2);

    % Gravitational acceleration components
    ax_grav = -mu * Y(1) / r^3;
    ay_grav = -mu * Y(2) / r^3;

    % Thrust acceleration components
    ax_thrust = 0;           
    ay_thrust = ( (c * beta) ./ Y(5) );

    % Total accelerations
    ax_total = ax_thrust + ax_grav;
    ay_total = ay_thrust + ay_grav;

    dydt = [ Y(3);
             Y(4);
             ax_total;
             ay_total;
             -beta ];
end
