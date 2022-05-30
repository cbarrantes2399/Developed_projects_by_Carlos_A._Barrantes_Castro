## (C) 2022 Pablo Alvarado
## (C) 2022 Salomón Ramírez y Carlos Barrantes
## EL5857 Aprendizaje automático
## Tarea 2

## Polynomial regression (with intercept)
##
## Given a set of training points in X with known 'z'-values stored in
## in the vector y, estimate the 'z'-values on the data points p,
## which usually lie somewhere inbetween the points in X.
##
## p: matrix of size m x 2, with m 2D positions on which
##    the z value needs to be regressed
## X: support data (or training data) with all known 2D positions
## y: support data with the corresponding z values for each position
## O: integer specifying the order of the surface (O=1 is linear
##    regression, O=2 parabolic regression, etc.)
##
## The number of rows of X must be equal to the length of y
##
## The function must generate the z position for all data points in p.
function rz4=polyreg(p,X,z,O)
  ## This code is for polynomial regression
  
  x1=expandFeatures(X,O); #se llama la función para añadir expresiones debido
                          #al grado del polinomio
  Xfin=[ones(length(x1),1), x1]; #se agrega la columna de unos
  
  ## Ecuaciones normales, ya usando la implementación con la
  ## pseudo-inversa de Moore-Penrose
  theta=pinv(Xfin)*z(:);
  
  ## Ahora evaluemos los puntos p
  pp=expandFeatures(p,O);
  Pfin=[ones(length(pp),1), pp];
  
  rz4=Pfin*theta; #se generan los zetas y el resultado de la regresión
endfunction

function xx=expandFeatures(x,O)
  eq=x(:,1); #se obtienen las x
  ye=x(:,2); #se obtienen las y
  xx=[];
  k=0;
  for h=1:O
    xx=[xx eq.^h ye.^h]; #se agregan todo las potencias individuales (que no se
                         #multiplican x*y)
    #xx(:,k+1)=eq.^h;
    #xx(:,k+2)=ye.^h;
    #k=k+1;
  endfor
  for j=1:O-1
    for i=1:O-1
      if i+j <= O
        xx=[xx eq.^i.*ye.^j]; #se agregan todas las potencias multiplicadas
        #xx(:,k+1)=eq.^(j).*ye.^i; #otra lógica que hicimos que igual funciona
        #k=k+1;
      endif
    endfor
  endfor
endfunction

