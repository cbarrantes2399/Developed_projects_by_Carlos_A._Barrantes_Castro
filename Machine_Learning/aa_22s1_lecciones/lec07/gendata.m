## (C) 2022 Pablo Alvarado
## 5857 Aprendizaje Automático
## Tecnológico de Costa Rica


function [X,y] = gendata(N)
  ## Esta funcion genera N datos de alguna distribución "alambrada".

  [xx,yy,zz]=peaks(N);

  minx=min(xx(:));
  maxx=max(xx(:));

  m=(N-1)/(maxx-minx);
  b=N-m*maxx;
  idxm1=round((-1)*m+b);

  X=yy(:,idxm1);
  y=zz(:,idxm1);

  ## Add some noise
  Dx=((maxx-minx)/N)*rand(size(X))-0.5;
  X=X+Dx;
  y=y+0.1*rand(size(y));
  
endfunction

