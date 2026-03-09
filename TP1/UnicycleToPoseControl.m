function [ u ] = UnicycleToPoseControl(xTrue,xGoal)


%Computes a control to reach a pose for unicycle
%   xTrue is the robot current pose : [ x y theta ]'
%   xGoal is the goal point
%   u is the control : [v omega]'

% TODO
  dx = xGoal(1) - xTrue(1);
  dy = xGoal(2) - xTrue(2);
  Kp = 21;
  Ka = 5;
  Kb = 26;
  
  alpha = atan2(dy,dx) - xTrue(3);

  pho = sqrt(dx^2 + dy^2);

  alpha = AngleWrap(alpha);

  if pho > 0.05
    if alpha > pi/4
      u(1) = 0;
    else
      u(1) = Kp * pho;
    end
    u(2) = Ka * alpha;
  else
    u(1) = 0;
    beta = xGoal(3) - xTrue(3);
    beta = AngleWrap(beta);
    u(2) = Kb * beta;
  end
  u(1) = max(min(u(1), 1), -1);
  u(2) = max(min(u(2), pi), -pi);
end

