% Copyright (C) 2022 Pablo Alvarado
% EL5857 Aprendizaje Automático
% Tarea 3
% (C) 2022 Carlos Barrantes y Salomón Ramírez

% Hypothesis function used in softmax
% Theta: matrix, its columns are each related to one
%        particular class.
% returns the hypothesis, which has only k-1 values for each sample
%         as the last one is computed as 1 minus the sum of all the rest.
function h=softmax_hyp(Theta,X)
  val=exp(X*Theta);
  nor=sum(val,2) + ones(rows(val),1); ## the ones 'cause exp(0) for k
  h = val ./ nor;
endfunction
