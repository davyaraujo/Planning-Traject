function [ u ] = BicycleToPathControl(xTrue, Path )
%Computes a control to follow a path for bicycle
%   xTrue is the robot current pose : [ x y theta ]'
%   Path is set of points defining the path : [ x1 x2 ... ;
%                                               y1 y2 ...]
%   u is the control : [v phi]'

% TODO
  persistent idx;
    
  if isempty(idx)
      idx = 1;
  end
  pho = 0.5;
  kp = 6;
  ka = 7;
  dist = norm(Path(1:2,idx) - xTrue(1:2));
  while (dist < pho && idx < size(Path, 2))
    idx = idx + 1;
    dist = norm(Path(1:2, idx) - xTrue(1:2));
  end
  target = Path(1:2,idx);
  alpha = atan2(target(2) - xTrue(2), target(1) - xTrue(1));
  alpha = atan2(sin(alpha - xTrue(3)), cos(alpha - xTrue(3)));
  u(1) = kp*dist;
  u(2) = ka * alpha;

end
 
