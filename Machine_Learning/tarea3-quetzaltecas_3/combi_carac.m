% Copyright (C) 2022 Pablo Alvarado
% EL5857 Aprendizaje Automático
% Tarea 3
% (C) 2022 Carlos Barrantes y Salomón Ramírez

% Hypothesis function used in logistic regression
function theta=combi_carac(x8,YtrainF,opt)
  
  theta0=rand(columns(x8),1)-0.5; ## Common starting point (column vector)
  [ts,errs]=opt.minimize(@logreg_loss,@logreg_gradloss,theta0,x8,YtrainF);
  theta=ts{end};
  
endfunction