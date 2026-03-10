function DoBicycleGraphicsPath(xTrue, XStore, Path)

  figure(1);
  clf;
  hold on;

  plot(Path(1,:), Path(2,:), 'b--o', 'LineWidth', 1.5, 'MarkerSize', 6);

  valid = ~isnan(XStore(1,:));
  plot(XStore(1,valid), XStore(2,valid), 'g-', 'LineWidth', 1.2);

  L = 0.15; 
  W = 0.08;
  theta = xTrue(3);
  cx = xTrue(1);
  cy = xTrue(2);
  pts_local = [L,  0;
              -L,  W;
              -L, -W]';

  R = [cos(theta), -sin(theta);
       sin(theta),  cos(theta)];

  pts_world = R * pts_local;
  pts_world(1,:) = pts_world(1,:) + cx;
  pts_world(2,:) = pts_world(2,:) + cy;

  fill(pts_world(1,:), pts_world(2,:), 'r');
  for i = 1:size(Path,2)
    text(Path(1,i)+0.05, Path(2,i)+0.05, num2str(i), 'FontSize', 8, 'Color', 'blue');
  end

  axis equal;
  grid on;
  xlabel('x (m)');
  ylabel('y (m)');
  title('Bicycle Path Following');
  legend('Path', 'Trajectory', 'Robot', 'Location', 'best');
  hold off;

end