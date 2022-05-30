# Tarea 2
## (C) 2022 Salomón Ramírez y Carlos Barrantes
EL5857 Aprendizaje automático

Estos son los archivos base para la solución de la Tarea 2.

- heightmap.png
  Datos de profundidad codificados como imagen
- gendata.m
  Archivo que toma la imagen heightmap.png y la carga como datos de
  posición y profundidad.
- showdata.m
  Archivo de ejemplo, solo para obtener datos aleatorios y mostrarlos 
- regressall.m
  Archivo central, que llama a todas las otras funciones.
- linreg_nointercept.m
  Implementación de regresión lineal sin sesgo, que obliga al hiperplano
  encontrado a pasar por cero.  La implementación es completa
- linreg.m
  Solución para la regresión lineal.
- polyreg.m
  Solución para la regresión polinomial.
- lowess.m
  Solución para la regresión ponderada localmente.
- funcerror.m
  Función para determinar el error de la regresión polinomial y la regres
  ión ponderada localmente. 

Este código necesita el paquete '''image''' que puede instalar dentro de
octave con:

     pkg install -forge image
     
********Utilización del código********

-Para poder utilizar correctamente esta solución de la tarea 2, se debe 
compilar el archivo regressall.m. En seguida, en la ventana de comandos
se le solicitará el orden que desea utilizar para la regresión polinomial 
para mostrarle la gráfica respectiva. De igual manera se le solicitará
el valor de Tau como siguiente paso para graficar la respectiva gráfica
de la regresión ponderada localmente. Por último, el código se ejecutará
por si solo, mostrando el título en cada gráfica para saber de que trata.
