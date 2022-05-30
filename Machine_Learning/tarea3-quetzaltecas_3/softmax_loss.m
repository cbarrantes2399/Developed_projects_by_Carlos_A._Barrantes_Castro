% Copyright (C) 2022 Pablo Alvarado
% EL5857 Aprendizaje Automático
% Tarea 3
% (C) 2022 Carlos Barrantes y Salomón Ramírez

% Loss function used in softmax
function err=softmax_loss(theta,X,y)
  ## residuals
  h = softmax_hyp(theta,X);
  r=y-h;
  err = 0.5*sum(r(:).^2);
endfunction
