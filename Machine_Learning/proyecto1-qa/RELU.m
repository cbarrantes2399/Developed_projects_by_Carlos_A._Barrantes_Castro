## Copyright (C) 2021-2022 Pablo Alvarado
## Copyright (C) Jose Angulo, Carlos Barrantes
## Copyright (C) Alejandro Hernández y Salomón Ramírez
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5857 Aprendizaje Automático
## Escuela de Ingeniería Electrónica
## Tecnológico de Costa Rica

## "Capa" RELU, que aplica la función logística
classdef RELU < handle
  properties    
    ## Resultados después de la propagación hacia adelante
    outputs=[];
    ## Resultados después de la propagación hacia atrás
    gradient=[];
    unitstep = [];
  endproperties

  methods
    ## Constructor ejecuta un forward si se le pasan datos
    function s=RELU()
      s.outputs=[];
      s.gradient=[];
      s.unitstep = [];
    endfunction

    ## En funciones de activación el init no hace mayor cosa más que
    ## indicar que la dimensión de la salida es la misma que la entrada.
    ##
    ## La función devuelve la dimensión de la salida de la capa
    function outSize=init(s,inputSize)
      outSize=inputSize;
    endfunction    
    
    ## Retorna false si la capa no tiene un estado que adaptar
    function st=hasState(s)
      st=false;
    endfunction
        
    ## Propagación hacia adelante
    function y=forward(s,a,prediction=false)
      s.unitstep = (a >= 0);
      s.outputs = a.*s.unitstep;
      y=s.outputs;
      s.gradient = [];
    endfunction

    ## Propagación hacia atrás recibe dL/ds de siguientes nodos
    function g=backward(s,dLds)
      if (size(dLds)!=size(s.outputs))
        error("backward de RELU no compatible con forward previo");
      endif
      s.gradient = s.unitstep.*dLds;
      g=s.gradient;
    endfunction
  endmethods
endclassdef
