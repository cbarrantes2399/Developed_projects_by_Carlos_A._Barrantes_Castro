##Tarea 1 - Aprendizaje Automático##
## (C) 2022 Carlos Barrantes y Salomón Ramírez
## EL5857 Aprendizaje Automático
## Tecnológico de Costa Rica - I Semestre 2022

function punt3_4()
  b=[-0.5 1];
  rango=[-3,3,-3,3]; #rango arbitrario para que se puedan ver mínimos gráficamente

  X=[rango(1):0.5:rango(2)];
  Y=[rango(3):0.5:rango(4)];

  [XX, YY] = meshgrid (X,Y);
  eq=[XX(:) YY(:)]';

  %%%%%%%%3.1%%%%%%%
  A1=15*eye(2); #matriz identidad escalada
  Z1 = (1/2)*sum(eq.*(A1*eq))+b*eq;
  figure(1, "name", "Punto 3.1 - Matriz identidad escalada")
  surf(XX, YY, reshape(Z1,size(XX)));

  %%%%%%%%3.2%%%%%%%
  A2=diag([4,2]); #Matriz diagonal y los dos elementos de la diagonal distintos.
  Z2 = (1/2)*sum(eq.*(A2*eq))+b*eq;
  figure(2, "name", "Punto 3.2 - Matriz diagonal con elementos diferentes")
  surf(XX, YY, reshape(Z2,size(XX)));
  
  %%%%%%%%3.3%%%%%%%
  A3=[7 2;2 1]; #Matriz simétrica no diagonal y positiva definida
  Z3 = (1/2)*sum(eq.*(A3*eq))+b*eq;
  figure(3, "name", "Punto 3.3, 4 y Apartado 4")
  surf(XX, YY, reshape(Z3,size(XX)));
  
  %%%%%%%%punto 4%%%%%%%%%
  hold on
  spacing=0.1; #espaciado de la gradiente
  [dx,dy]=gradient(Z3,spacing); #se realizado la función de la gradiente para
  #obtener las derivadas
  quiver(XX,YY,reshape(dx,size(XX)),reshape(dy,size(YY))); #se presenta en
  #pantalla por medio de la función quiver
  
  %%%%%%%%Apartado 4 - Punto 1 y 2%%%%%%%%%
  xx=[ones(length(XX(:)),1), XX(:), YY(:)]; ##se crea la matriz x con una 
  #columna de unos, otra con los valores de x y otra con los de y
  theta=pinv(xx)*Z3(:); #se crea la matriz con los tres valores de theta
  #esto por medio de la función pseudoinversa y los datos Z3 de la anterior func
  Z4=xx*theta; #se crean los puntos Z4 para el plano
  surf(XX, YY, reshape(Z4,size(XX)));
  hold off
  
endfunction