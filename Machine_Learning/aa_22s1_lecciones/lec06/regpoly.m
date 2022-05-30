## (C) 2022 Pablo Alvarado
## 5857 Aprendizaje Automático
## Tecnológico de Costa Rica


function z = regpoly(p,X,y,N)
  
  assert(columns(y)==1);
  assert(rows(X)==rows(y));
  assert(N>0);
  assert(columns(p)==columns(X),"Dimensiones en p y en X deben ser iguales");
  
  ## Utilice los datos X con valor y, para hacer la regresión de un
  ## polinomio de grado N, donde los puntos a evaluar con la regresión
  ## están dados por p

  ## Este ejemplo hace una regresión lineal sencilla, y usted debe
  ## corregirlo

  ## Tenemos que agregar 1 para poder tener sesgo:
  xx=expandFeatures(X);

  ## Ecuaciones normales, ya usando la implementación con la
  ## pseudo-inversa de Moore-Penrose
  theta=pinv(xx)*y;

  ## Ahora evaluemos los puntos p
  pp=expandFeatures(p);
  z=pp*theta;  
endfunction

function xx=expandFeatures(x)
  xx=[ones(length(x),1), x(:)];
endfunction
