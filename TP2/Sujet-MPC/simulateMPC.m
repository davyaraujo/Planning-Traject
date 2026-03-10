function simulateMPC(xinit,K,mu)
    
  dt = .01;
  x = xinit;
  xstore = NaN*zeros(2,10000);
  k = 1;
  u = 0; 
  n = 4; 
  
  while (norm(x) > 0.001) && (k < 2000)
    xstore(:,k) = x;

    A = eye(2) + dt * [ u*(1-mu),        1       ;
                        1       , -4*u*(1-mu) ];
                       
    B = dt * [ mu + (1-mu)*x(1)  ;
               mu - 4*(1-mu)*x(2) ];
    
    nx = 2;
    
    Aqp = zeros(n*nx, nx);
    Apow = eye(nx);
    for i = 1:n
      Apow = Apow * A;
      Aqp((i-1)*nx+1 : i*nx, :) = Apow;
    end
    
    Bqp = zeros(n*nx, n);
    for i = 1:n
      for j = 1:i
        Apow = eye(nx);
        for p = 1:(i-j)
          Apow = Apow * A;
        end
        Bqp((i-1)*nx+1 : i*nx, j) = Apow * B;
      end
    end
    
    U = -pinv(Bqp) * Aqp * x;
    
    if isempty(K)
      u = U(1);        
    else
      u = K * x;       
    end
    
    u = max(-2, min(2, u));
    
    x1 = x(1);
    x2 = x(2);
    x(1) = x1 + dt*(x2 + u*(mu + (1-mu)*x1));
    x(2) = x2 + dt*(x1 + u*(mu - 4*(1-mu)*x2));
    
    k++;
  end
  
  if norm(x) < 0.01
    plot(xstore(1,:), xstore(2,:), '+');
  else
    disp("fail!")
  end
endfunction
