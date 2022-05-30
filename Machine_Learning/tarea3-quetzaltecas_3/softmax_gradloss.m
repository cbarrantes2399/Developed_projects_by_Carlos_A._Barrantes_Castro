% Copyright (C) 2022 Pablo Alvarado
% EL5857 Aprendizaje Automático
% Tarea 3
% (C) 2022 Carlos Barrantes y Salomón Ramírez

% Gradient of the loss function used in softmax
%
% The size of the returned gradient must be equal to the size of Theta

function grad=softmax_gradloss(Theta,X,Ytr)

  h = softmax_hyp(Theta,X);
  grad = [ X'*(h-Ytr) ]; ## Gradient estimation

endfunction


