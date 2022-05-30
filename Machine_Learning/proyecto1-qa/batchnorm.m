## Copyright (C) 2021-2022 Pablo Alvarado
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5857 Aprendizaje Autom谩tico
## Escuela de Ingenier铆a Electr贸nica
## Tecnol贸gico de Costa Rica

## Normalizaci贸n por lotes
classdef batchnorm < handle
  properties
    ## TODO: Agregue las propiedades que requiera.  No olvide inicializarlas
    ##       en el constructor o el m茅todo init si hace falta.
    
    ## Par谩metro usado por el filtro que estima la varianza y media completas
    beta=0.9;
    
    ## Valor usado para evitar divisiones por cero
    epsilon=1e-10;
    mu1=[];                 ### Media "mu"
    desv=[];                 ##desiaci髇 estandar
    
    ###### desviaci髇 y media completas aprendidas durante el entrenamiento######
    mu1_total=[];             
    desv_total=[];           
 
  endproperties
  
  methods
    ## Constructor
    ##
    ## beta es factor del filtro utilizado para aprender 
    ## epsilon es el valor usado para evitar divisiones por cero
    function s=batchnorm(beta=0.9,epsilon=1e-10)
      s.beta=beta;
      s.epsilon=epsilon;
      s.mu1=[];
      s.desv=[];
      
      ## TODO: 
      
    endfunction

    ## Inicializa el estado de la capa (p.ej. los pesos si los hay)
    ##
    ## La funci贸n devuelve la dimensi贸n de la salida de la capa y recibe
    ## la dimensi贸n de los datos a la entrada de la capa
    function outSize=init(s,inputSize)
      outSize=inputSize;
      
      ## TODO: 
      
    endfunction
   
    ## La capa de normalizaci贸n no tiene estado que se aprenda con 
    ## la optimizaci贸n.
    function st=hasState(s)
      st=false;
    endfunction
   
    ## Propagaci贸n hacia adelante normaliza por media del minilote 
    ## en el entrenamiento, pero por la media total en la predicci贸n.
    ##
    ## El par谩metro 'prediction' permite determinar si este m茅todo
    ## est谩 siendo llamado en el proceso de entrenamiento (false) o en el
    ## proceso de predicci贸n (true)      
    function y=forward(s,X,prediction=false)
      m=rows(X);
      if (prediction)
        
        ## TODO: Qu茅 hacer en la predicci贸n?
        #y=X; ## BORRAR esta l铆nea cuando tenga la verdadera soluci贸n
        y=(X-ones(m,1)*s.mu1_total)./(sqrt(s.desv));
        
      else
        if (columns(X)==1)
          ## Imposible normalizar un solo dato.  Devu茅lvalo tal y como es
          y=X;          
        else
          ## TODO: Qu茅 hacer en el entrenamiento?
          s.mu1=mean(X);
          s.desv=std(X);
          #s.mu1=(1/m)*ones(1,m)*X;     ###obtiene el promedio de los valores de cada dimensi髇 de X y adem醩 evitando ciclos
          #s.desv=(1/m)*sum(X.*X)-s.mu1'.*s.mu1'+s.epsilon*ones(1,m);
          y=(X-ones(m,1)*s.mu1)./sqrt(s.desv);   ### ./ o diag^-1 como dice en las diap?
          ### y=X; ## BORRAR esta l铆nea cuando tenga la verdadera soluci贸n
          if isempty(s.mu1_total)
            s.mu1_total=(1-s.beta)*s.mu1;
            s.desv_total=(1-s.beta)*s.desv;
          else
            s.mu1_total=s.beta*s.mu1_total+(1-s.beta)*s.mu1;
            s.desv_total=s.beta*s.desv_total+(1-s.beta)*s.desv;
          endif
          
        endif
      endif
    endfunction

    ## Propagaci贸n hacia atr谩s recibe dL/ds de siguientes nodos del grafo,
    ## y retorna el gradiente necesario para la retropropagaci贸n. que ser谩
    ## pasado a nodos anteriores en el grafo.
    function g=backward(s,dLds)      
      g=dLds./sqrt(s.desv); ## TODO: CORREGIR, pues esto no es el verdadero gradiente
    endfunction
  endmethods
endclassdef
