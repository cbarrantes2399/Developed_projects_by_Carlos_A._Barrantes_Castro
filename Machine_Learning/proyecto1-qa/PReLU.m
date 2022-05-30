## Copyright (C) 2021-2022 Pablo Alvarado
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5857 Aprendizaje Automático
## Escuela de Ingeniería Electrónica
## Tecnológico de Costa Rica

## "Capa" PReLU, que aplica la función logística
classdef PReLU < handle
  properties    
    ## Resultados después de la propagación hacia adelante
    input=[];
    outputs=[];
    ## Resultados después de la propagación hacia atrás
    gradient=[];
    alpha = 0;
    gradientAlpha = 0;
  endproperties

  methods
    ## Constructor ejecuta un forward si se le pasan datos
    function s=PReLU()
      s.input=[];
      s.outputs=[];
      s.gradient=[];
    endfunction

    ## En funciones de activación el init no hace mayor cosa más que
    ## indicar que la dimensión de la salida es la misma que la entrada.
    ##
    ## La función devuelve la dimensión de la salida de la capa
    function outSize=init(s,inputSize)
      outSize=inputSize;
      s.alpha = 0.4;
    endfunction    
    
    ## Retorna false si la capa no tiene un estado que adaptar
    function st=hasState(s)
      st=true;
    endfunction
    
    ##Retorna el estado de la capa, es decir alpha
    function state=state(s)
      state=s.alpha;
    endfunction
    
    ##Escribe el estado de la capa, es decir alpha
    function setState(s,state)
      s.alpha=state;
    endfunction
    
    function g=stateGradient(s)
      g = s.gradientAlpha;
    endfunction
        
    ## Propagación hacia adelante
    function y=forward(s,a,prediction=false)
      s.input=a;
      s.outputs = max(s.alpha*a,a);
      y=s.outputs;
      s.gradient = [];
    endfunction

    ## Propagación hacia atrás recibe dL/ds de siguientes nodos
    function g=backward(s,dLds)
      if (size(dLds)!=size(s.outputs))
        error("backward de PReLU no compatible con forward previo");
      endif
      localGrad = s.alpha + (1-s.alpha).*(s.input>0);
      s.gradient = localGrad.*dLds;
      g=s.gradient;
      s.gradientAlpha = sum(sum(s.input.*(s.input<0).*dLds));
    endfunction
   
  endmethods
endclassdef
