##Tarea 1 - Aprendizaje Automático##
## (C) 2022 Carlos Barrantes y Salomón Ramírez
## EL5857 Aprendizaje Automático
## Tecnológico de Costa Rica - I Semestre 2022

function punt2(b,A,rango)
  #el rango debe ser dado por el usuario y debe ser de la siguiente manera:...
  #...[xmin,xmax,ymin,ymax]
  #además debe brindarse la matriz A 2x2 y un vector b de dos dimensiones
  
  X=[rango(1):0.5:rango(2)];
  Y=[rango(3):0.25:rango(4)];

  [XX, YY] = meshgrid (X,Y);
  eq=[XX(:) YY(:)]';

  Z = (1/2)*sum(eq.*(A*eq))+b*eq;
  figure(1,"name","Punto 2")
  surf(XX, YY, reshape(Z,size(XX)));

endfunction