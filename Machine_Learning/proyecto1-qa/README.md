# Proyecto 1

Estos archivos fueron generados por Jose Angulo Durán, Carlos Barrantes Castro, Alejandro Hernández
Lobo, Salomón Ramírez Quirós como estudiantes y Pablo Alvarado Moya como profesor del curso:

S1 2022<br/>
EL5857 Aprendizaje Automático<br/>
Tecnológico de Costa Rica <br/>

Código base para el proyecto 1 del curso de aprendizaje automático.

- create_data.m 
  Módulo usado para crear conjuntos de datos bidimensionales siguiendo
  varias distribuciones y varios números de clases.
- plot_data.m
  Módulo para mostrar los datos creados con create_data.m
- sequential.m
  Modelo secuencial, encargado de encadenar capas y pasar la
  información hacia adelante y hacia atrás, así como aplicar las
  técnicas de optimización de parámetros (aprendizaje).
- input_layer.m
  Capa de entrada (100% funcional)
- dense_unbiased.m
  Capa densa sin sesgo (100% funcional)
- logistic.m
  Función sigmoide.  Esto es la función matemática como tal.
- sigmoide.m
  Capa de activación que usa la función sigmoide (implementada en
  logistic.m) para cada entrada, e implementa los métodos hacia adelante y 
  hacia atrás (100% funcional)
- olsloss.m
  Capa de cálculo de pérdida con OLS (100% funcional)
- layer_template.m
  Plantilla para cualquier tipo de capa.  Este archivo enumera y explica
  los métodos esperados por el módulo sequential.m para poder conectar las
  capas y pasar la información hacia adelante y hacia atrás.
- batchnorm.m 
  Plantilla (no funcional) como base para la implementación de la
  normalizacíón por lotes.
- train.m
  Archivo general usado como ejemplo base para crear y mostrar datos, armar
  una red neuronal y entrenarla.  Se presentan dos formas de armar la
  red agregando todas las capas de una sola vez usando un arreglo de celdas,
  o agregando las capas una a una (comentado).
- ecloss.m
  Calcula el error por medio de la entropía cruzada, debe usarse cuando antes
  esté Softmax.
- mseloss.m
  Calcula el error por medio de MSE (Mean squared error)
- LELELU
  Capa de activación que usa la función LELELU para cada entrada, e implementa
  los métodos hacia adelante y hacia atrás.
- PReLU
  Capa de activación que usa la función PReLU para cada entrada, e implementa
  los métodos hacia adelante y hacia atrás.
- RELU
  Capa de activación que usa la función RELU para cada entrada, e implementa
  los métodos hacia adelante y hacia atrás.
- SoftMax
  Capa de activación que usa la función Softmax para cada entrada, e implementa
  los métodos hacia adelante y hacia atrás.
- batchnorm
  Capa de normalización de datos por lotes, según su media y varianza.
- conf_matrix.m
  Capa para evaluar el rendimiento del clasificador, en este caso por medio
  de precisión y exhaustividad.
- dense_biased
  Capa densa con sesgo (100% funcional)
- train_pingu.m
  Archivo para entrenar la red neuronal con los datos recopilados de pingüinos.
  
# Utilización de la red neuronal

Para poder utilizar esta red neuronal solo se deben ejecutar los archivos train.m y train_pingu.m,
este segundo se ejecuta siempre y cuando usted quiera entrenar la red neuronal con los datos recopilados
de pingüinos. Si gusta editar los parámetros respectivos de la red, debe editarlos en los archivos train antes
mencionados.
