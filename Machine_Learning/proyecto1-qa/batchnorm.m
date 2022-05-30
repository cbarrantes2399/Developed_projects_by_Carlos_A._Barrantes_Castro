## Copyright (C) 2021-2022 Pablo Alvarado
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5857 Aprendizaje Automático
## Escuela de Ingeniería Electrónica
## Tecnológico de Costa Rica

## Normalización por lotes
classdef batchnorm < handle
  properties
    ## TODO: Agregue las propiedades que requiera.  No olvide inicializarlas
    ##       en el constructor o el método init si hace falta.
    
    ## Parámetro usado por el filtro que estima la varianza y media completas
    beta=0.9;
    
    ## Valor usado para evitar divisiones por cero
    epsilon=1e-10;
    mu1=[];                 ### Media "mu"
    desv=[];                 ##desiaci�n estandar
    
    ###### desviaci�n y media completas aprendidas durante el entrenamiento######
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
    ## La función devuelve la dimensión de la salida de la capa y recibe
    ## la dimensión de los datos a la entrada de la capa
    function outSize=init(s,inputSize)
      outSize=inputSize;
      
      ## TODO: 
      
    endfunction
   
    ## La capa de normalización no tiene estado que se aprenda con 
    ## la optimización.
    function st=hasState(s)
      st=false;
    endfunction
   
    ## Propagación hacia adelante normaliza por media del minilote 
    ## en el entrenamiento, pero por la media total en la predicción.
    ##
    ## El parámetro 'prediction' permite determinar si este método
    ## está siendo llamado en el proceso de entrenamiento (false) o en el
    ## proceso de predicción (true)      
    function y=forward(s,X,prediction=false)
      m=rows(X);
      if (prediction)
        
        ## TODO: Qué hacer en la predicción?
        #y=X; ## BORRAR esta línea cuando tenga la verdadera solución
        y=(X-ones(m,1)*s.mu1_total)./(sqrt(s.desv));
        
      else
        if (columns(X)==1)
          ## Imposible normalizar un solo dato.  Devuélvalo tal y como es
          y=X;          
        else
          ## TODO: Qué hacer en el entrenamiento?
          s.mu1=mean(X);
          s.desv=std(X);
          #s.mu1=(1/m)*ones(1,m)*X;     ###obtiene el promedio de los valores de cada dimensi�n de X y adem�s evitando ciclos
          #s.desv=(1/m)*sum(X.*X)-s.mu1'.*s.mu1'+s.epsilon*ones(1,m);
          y=(X-ones(m,1)*s.mu1)./sqrt(s.desv);   ### ./ o diag^-1 como dice en las diap?
          ### y=X; ## BORRAR esta línea cuando tenga la verdadera solución
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

    ## Propagación hacia atrás recibe dL/ds de siguientes nodos del grafo,
    ## y retorna el gradiente necesario para la retropropagación. que será
    ## pasado a nodos anteriores en el grafo.
    function g=backward(s,dLds)      
      g=dLds./sqrt(s.desv); ## TODO: CORREGIR, pues esto no es el verdadero gradiente
    endfunction
  endmethods
endclassdef
