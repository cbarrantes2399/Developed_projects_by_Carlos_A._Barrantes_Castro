## Copyright (C) 2021-2022 Pablo Alvarado
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5857 Aprendizaje Automático
## Escuela de Ingeniería Electrónica
## Tecnológico de Costa Rica

## "Capa" para calcular la pérdida con "Entropía cruzada"
##
## Suponemos que cada fila de Y tiene un dato, para el que
## se tiene como 'ground-truth' las etiquetas Ygt.
##
## Esta capa calcula entonces la pérdida como la mitad de la suma de los
## cuadrados de las diferencias
classdef ecloss < handle
  properties
    ## Entrada en la propagación hacia adelante
    sumini=[];
    ## Resultados después de la propagación hacia adelante
    outputs=[];
    ## Resultados después de la propagación hacia atrás
    gradient=[];
    graddif=[];
    Ygtpass=[];
    Ypass=[];
  endproperties

  methods
    ## Constructor solo incializa los datos
    function s=ecloss()
      s.sumini=[];
      s.outputs=[];
      s.gradient=[];
      s.graddif=[];
      s.Ygtpass=[];
      s.Ypass=[];
    endfunction

    ## En funciones de perdida el init no hace mayor cosa más que
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
    
    ## Propagación hacia adelante.
    ## 
    ## En las capas de error, se requieren dos argumentos.
    ## 
    ## Primero la salida de la última capa de la red y luego las etiquetas
    ## contra las que se comparará y se calculará la pérdida.
    ##
    ## Note que todas las otras capas solo requieren la salida de la capa anterior.
    function J=forward(s,Y,Ygt)
      if (isscalar(Ygt) && isboolean(Ygt))
        error("Capas de pérdida deben ser las últimas del grafo");
      elseif (isreal(Y) && ismatrix(Y) && (size(Y)==size(Ygt)))
        s.sumini  =-sum(Ygt.*log(Y),2);
        s.outputs = sum(s.sumini)/length(s.sumini);
        #s.outputs = -Ygt.*log(Y);
        J=s.outputs;
        s.Ygtpass=Ygt;
        s.Ypass=Y;
        s.gradient = [];
      else
        error("Entropía cruzada espera dos matrices reales del mismo tamaño");
      endif
    endfunction

    ## Propagación hacia atrás recibe dL/ds de siguientes nodos
    function g=backward(s,dLds)
      if (size(dLds)!=size(s.outputs))
        error("backward de Entropía cruzada no compatible con forward previo");
      endif
      ## Asumiendo que dLds es escalar (la salida debería serlo)
      pass=-(s.Ygtpass/length(s.sumini))./s.Ypass;
      s.gradient = pass*dLds;
      g=s.gradient;
    endfunction
  endmethods
endclassdef
