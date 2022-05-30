## Lección 08: Aprendizaje Automático

En esta clase se tratará el tema de aprendizaje generativo, tema de la
lección 8, mientras que en la tarea 3 y en el proyecto 1, disponibles
a finales de la semana, se tratará el aprendizaje discriminativo.  Aun
así, algunos principios que usaremos aquí se aplican en la tarea y en
el proyecto.

Usaremos el conjunto de datos de Allison Horst de pingüinos en la
Antártica.

1. En en el archivo gda.m deberá implementar el algoritmo de análisis
   gaussiano discriminador, revisado en la lección 8, para clasificar
   si un determinado dato corresponde a un pingüino hembra o macho.

   Para el entrenamiento
   1. Extraiga todos los datos correspondientes a 'FEMALE' (i.e. y=1)
   2. Extraiga todos los datos correspondientes a 'MALE' (i.e. y=0)
   3. Calcule los parámetros correspondientes a las distribuciones
      gaussianas de cada clase (Ver lección 8, folio 9).
      Las funciones mean y cov le serán de utilidad.

   Para los datos de prueba
   1. Calcule la predicción de que el dato sea de la clase 'FEMALE',
      dado cada dato; es decir, indique con y=1 si el dato es de esa
      clase o 0 de otro modo.
      La función mvnpdf del paquete statistics le puede ser útil
      (multivariate normal probability density function).
   2. Calcule el error empírico con los datos de entrenamiento y con
      los datos de prueba.


2. En el archivo gaussnb.m deberá implementar el algoritmo de naïve Bayes
   gaussiano, para hacer la misma clasificación que en el caso anterior.
   
   No hemos visto en la teoría el algoritmo de naïve Bayes gaussiano, pero
   la diferencia es sencilla de comprender: en vez de usar como probabilidad
   p(x|y) la razón de cuántas veces ocurre x cuando el dato es de la clase y, 
   usamos una estimación de esa probabilidad asumiendo que p(x|y) sigue una
   distribución gaussiana, por lo que símplemente tenemos que calcular la
   varianza y la media de esas distribuciones.
   
   Para el entrenamiento
   1. Extraiga todos los datos correspondientes a 'FEMALE' (i.e. y=1)
   2. Extraiga todos los datos correspondientes a 'MALE' (i.e. y=0)
   3. Calcule los parámetros correspondientes a las distribuciones
      gaussianas de cada característica por separado.
      Las funciones mean y std le pueden ser útiles. 
      
   Para los datos de prueba
   1. Calcule la predicción de que el dato sea de la clase 'FEMALE',
      dado cada dato; es decir, indique con y=1 si el dato es de esa
      clase o 0 de otro modo. (Folio 22)
   2. Calcule el error empírico con los datos de entrenamiento y con
      los datos de prueba.


