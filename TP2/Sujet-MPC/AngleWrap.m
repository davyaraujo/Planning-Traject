function angle = AngleWrap(angle)
% Wraps an angle to the range [-pi, pi]
  angle = mod(angle + pi, 2*pi) - pi;
end