% Copyright (C) 2022 Pablo Alvarado
% EL5857 Aprendizaje Automático
% Tarea 3
% (C) 2022 Carlos Barrantes y Salomón Ramírez

% Hypothesis function used in logistic regression
function h=logreg_hyp(theta,X)
  
  b=X*theta(:);
  h=1./(1+exp(-b));

endfunction
