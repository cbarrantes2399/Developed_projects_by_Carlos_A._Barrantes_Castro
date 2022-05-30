% Copyright (C) 2022 Pablo Alvarado
% EL5857 Aprendizaje Automático
% Tarea 3
% (C) 2022 Carlos Barrantes y Salomón Ramírez
% Loss function used in logistic regression
function grad=logreg_gradloss(theta,X,y)
  ## residuals
  h=logreg_hyp(theta,X);
  grad=sum((h-y).*X);
endfunction
