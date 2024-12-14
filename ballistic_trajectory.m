function dydt = ballistic_trajectory(t_ballistic, Y_ballistic)
    mu = 3.98614E5;           % Earth's gravitational parameter (km^3/s^2)
    g0 = 9.81;                % Standard gravity (m/s^2)
    Isp = 300;                % Specific impulse (s)
    c = Isp * g0 * 1E-3;      % Exhaust velocity (km/s)
    m0 = 1E4;


    r = sqrt(Y_ballistic(1)^2 + Y_ballistic(2)^2); % Distance from Earth's center (km)

    ax_grav = -mu * Y_ballistic(1) / r^3;
    ay_grav = -mu * Y_ballistic(2) / r^3;


    % Total accelerations
    ax_total = ax_grav;
    ay_total = ay_grav;

    dydt = [ Y_ballistic(3);
             Y_ballistic(4);
             ax_total;
             ay_total;
             0 ];
end
