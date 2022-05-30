## (C) 2022 Pablo Alvarado
## (C) 2022 Salom√≥n Ram√≠rez y Carlos Barrantes
## EL5857 Aprendizaje autom√°tico
## Tarea 2
## LOcally WEighted regreSSion (LOWESS)
##
## Given a set of training points in X with known 'z'-values stored in
## in the vector y, estimate the 'z'-values on the data points p,
## which usually lie somewhere inbetween the points in X.
##
## p: matrix of size m x 2, with m 2D positions on which
##    the z value needs to be regressed
## X: support data (or training data) with all known 2D positions
## y: support data with the corresponding z values for each position
## tau: bandwidth of the locally weighted regression
##
## The number of rows of X must be equal to the length of y
##
## The function must generate the z position for all data points in p
function rz=lowess(p,X,z,tau)
  ## This code is for simple linear regression with no-intercept

  rz=[]; ##crea una matriz donde se almacenar·n los datos aproximados por la regresiÛn ponderada localmente
  
  for k=1:rows(p)
    w=[];                                  #reinicia la matriz de los pesos de cada coordenada sobre el nuevo elemento 2D a evaluar
    pp=ones(rows(X),1)*p(k,:);             #obtiene cada elemento de 2D sobre el cu·l se van a calcular los pesos de las coordenadas
    w=exp(-sum((pp-X).^2,2)/(2*tau.^2))';  #peso para cada coordenada
    theta=inv(X'.*w*X)*(X'.*w)*z(:);       ##expresiÛn optimizada de theta
    y=p(k,:)*theta;                        ## valor aproximado para cada elemento evaluado en la regresion ponderada local
    rz=[rz;y];                             ## se guardan todas las aproximaciones en u vector columna
  endfor
  
endfunction
