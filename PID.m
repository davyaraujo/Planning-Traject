function [u, state] = pid_controller(error, dt, params, state)
    P = params.Kp * error;

    state.integral = state.integral + error * dt;
    I = params.Ki * state.integral;

    D = params.Kd * (error - state.last_error) / dt;

    u = P + I + D;

    if abs(u) > params.u_max
        u = sign(u) * params.u_max;
        state.integral = state.integral - error * dt;
    end

    state.last_error = error;
end

