%%%Tarea 1 - Aprendizaje Automático%%%

%Autores: Carlos Barrantes y Salomón Ramírez

%Tecnológico de Costa Rica - I Semestre 2022

function punt3()
  b=[-0.5 1]
  rango=[-3,3,-3,3]

  X=[rango(1):0.5:rango(2)]
  Y=[rango(3):0.25:rango(4)]

  [XX, YY] = meshgrid (X,Y);
  eq=[XX(:) YY(:)]';

  %%%%%%%%3.1%%%%%%%
  A=15*eye(2);
  Z1 = sum(eq.*(A*eq))+b*eq;
  figure(1)
  surf(XX, YY, reshape(Z1,size(XX)));

  %%%%%%%%3.2%%%%%%%
  A=diag([4,2]);
  Z2 = sum(eq.*(A*eq))+b*eq;
  figure(2)
  surf(XX, YY, reshape(Z2,size(XX)));
  
  %%%%%%%%3.3%%%%%%%
  A=[7 2;2 1];
  Z3 = sum(eq.*(A*eq))+b*eq;
  figure(3)
  surf(XX, YY, reshape(Z3,size(XX)));

endfunction