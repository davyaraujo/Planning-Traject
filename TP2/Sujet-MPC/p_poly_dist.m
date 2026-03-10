function dist = p_poly_dist(x, y, px, py)
  min_dist = Inf;

  for i = 1:length(px)-1
    ax = px(i);   ay = py(i);
    bx = px(i+1); by = py(i+1);

    abx = bx - ax; aby = by - ay;
    apx = x - ax;  apy = y - ay;

    ab2 = abx^2 + aby^2;
    if ab2 == 0
      d = norm([x - ax, y - ay]);
    else
      t = (apx*abx + apy*aby) / ab2;
      t = max(0, min(1, t));
      cx = ax + t*abx;
      cy = ay + t*aby;
      d = norm([x - cx, y - cy]);
    end

    if d < min_dist
      min_dist = d;
    end
  end

  dist = min_dist;
end