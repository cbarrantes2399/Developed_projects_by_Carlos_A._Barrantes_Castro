# Lección 25

Martes 10 de mayo, 2022 <br/>
Tecnológico de Costa Rica <br/>
EL5857 Aprendizaje Automático
 
En la práctica de hoy vamos a trabajar con algoritmos de aglomeración.

1. Revise el cuaderno plot_cluster_comparison.ipynb, en donde se
   comparan los resultados de 4 algoritmos vistos en clase (k-means,
   DBSCAN, mean-shift y mezcla de gaussianas).
   
   Debe anotarse aquí que la implementación del algoritmo de mean-shift
   se aparta de lo discutido en la literatura y los resultados por tanto
   no son los esperables, usándose una implementación acelerada que sacrifica
   las ventajas de la propuesta original por mayor velocidad.
   
2. Revise el cuaderno plot_dbscan.ipynb, e indentifique cómo se está
   haciendo para distinguir los distintos tipos de punto que identifica el
   algoritmo (ruido, núcleo, borde)
   
3. En el cuaderno kmeans.ipynb deben realizarse cuatro tareas con el set de 
   dígitos de 8x8 que tiene scikit-learn, y que ya se carga allí:
   1. Entrene kmeans para encontrar los clusters en los datos
   2. Muestre todos los centroides como imágenes
   3. Realice una matriz de confusión para ver qué clusters se asignan a qué clases.
   4. Repita con distinto número de clusters
