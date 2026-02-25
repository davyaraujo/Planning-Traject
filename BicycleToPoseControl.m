function [ u ] = BicycleToPoseControl( xTrue, xGoal )
  % xTrue: [x; y; theta] (pose atual)
  % xGoal: [xG; yG; thetaG] (pose desejada)

  % Extração de variáveis para clareza
  x = xTrue(1); y = xTrue(2); theta = xTrue(3);
  xG = xGoal(1); yG = xGoal(2); thetaG = xGoal(3);

  % 1. Cálculos Geométricos
  dx = xG - x;
  dy = yG - y;

  rho = sqrt(dx^2 + dy^2);

  % Ângulo do vetor posição (referencial global)
  lambda = atan2(dy, dx);

  % Erros angulares normalizados
  alpha = lambda - theta;
  alpha = atan2(sin(alpha), cos(alpha));

  beta = thetaG - lambda;
  beta = atan2(sin(beta), cos(beta));

  % 2. Ganhos do Controlador (Ajuste estes valores para o Benchmark)
  % Nota: O enunciado exige K_beta < 0
  Kp = 15;
  Ka = 5;
  Kb = -3;

  % 3. Leis de Controle
  u(1) = Kp * rho;
  u(2) = Ka * alpha + Kb * beta;

  % 4. Saturação (conforme limites da introdução)
  u(1) = min(u(1), 1.0);
  u(2) = max(min(u(2), 1.2), -1.2);

end
