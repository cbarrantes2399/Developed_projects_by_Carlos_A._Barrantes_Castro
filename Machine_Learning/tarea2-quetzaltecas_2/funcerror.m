## (C) 2022 Pablo Alvarado
## (C) 2022 Salomón Ramírez y Carlos Barrantes
## EL5857 Aprendizaje automático
## Tarea 2

function err = funcerror(NX,X,z,prof,opc)
  
  t=linspace(1,30,20); #se generan los valores por los cuales se van a iterar
  valerror=[];
  warning("off"); #se cancelan los warnings
  
  if opc==1 #esto es para no generar otra función por aparte
    for e=t
      rz5=polyreg(NX,X,z,e); #se traen los valores de regr polinomial
      calcerror=sum(abs(prof - rz5))/length(rz5); #se obtiene el valor de error
      valerror=[valerror calcerror];#se crea la lista con todos los errores
    endfor
    figure(7,"name","Error en función del orden de polinomio");
    plot(t,valerror,"-"); #gráfica simple en 2D
    xlabel("Grado del polinomio")
    ylabel("Valor del error")
    title("Error en función del orden de polinomio")
  elseif opc==2
    for e=t
      rz5=lowess(NX,X,z,e);
      calcerror=sum(abs(prof - rz5))/length(rz5);
      valerror=[valerror calcerror];
    endfor
    figure(9,"name","Error en función del valor de tau");
    plot(t,valerror,"-");
    xlabel("valor del tau")
    ylabel("Valor del error")
    title("Error en función del valor de tau")
  endif
  
  err=t(find(valerror==min(valerror)));
  
endfunction