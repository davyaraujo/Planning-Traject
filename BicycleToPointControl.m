function [ u ] = BicycleToPointControl( xTrue,xGoal )
%Computes a control to reach a pose for bicycle
%   xTrue is the robot current pose : [ x y theta ]'
%   xGoal is the goal point
%   u is the control : [v phi]'
% TODO
  dx = xGoal(1) - xTrue(1);
  dy = xGoal(2) - xTrue(2);

  kp = 15;
  ka = 5;

  rho = sqrt(dx^2 + dy^2);

  alpha = atan2(dy, dx) - xTrue(3);
  alpha = atan2(sin(alpha), cos(alpha));

  u(1) = kp * rho;
  u(2) = ka * alpha;

  u(1) = min(u(1), 1.0);
  u(2) = max(min(u(2),1.2), -1.2);

end

