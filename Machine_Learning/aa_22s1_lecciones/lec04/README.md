## Lección 04: Aprendizaje Automático

En esta clase deberemos calcular algunas probabilidades usando un
enfoque frecuentista.

Para eso usaremos estadísticas que podrían ser usadas en el juego
WORDLE.

En el sitio

    https://analisisydecision.es/actor-senil-wordle-castellano/

se encuentra la lista de todas las palabras en el DRAE, y de allí se
extrajeron todas las palabras de 5 letras, con todo y tildes
(codificado con UTF-8), en el archivo palabras5.txt.  Se eliminaron
las tildes y diéresis y se eliminaron las réplicas.  La letra ñ se
mantuvo en la lista, pero para evitar problemas de codificación, se
usó la letra N para representarla.  Todas las otras letras son
minúsculas.

Debe ahora calcular:

1. La probabilidad de cada letra en general
2. La probabilidad de cada letra en función de su posición
3. La probabilidad condicional general de cada letra, dado que la anterior es
   otra letra.
4. La probabilidad condicional general de cada letra, dado que otra letra está
   presente en la palabra.
