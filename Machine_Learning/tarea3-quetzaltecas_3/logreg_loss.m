% Copyright (C) 2022 Pablo Alvarado
% EL5857 Aprendizaje Automático
% Tarea 3
% (C) 2022 Carlos Barrantes y Salomón Ramírez

% Loss function used in logistic regression
function err=logreg_loss(theta,X,y)
  ## residuals
  r=y-logreg_hyp(theta,X);
  err=0.5*(r'*r); # OLS
endfunction
