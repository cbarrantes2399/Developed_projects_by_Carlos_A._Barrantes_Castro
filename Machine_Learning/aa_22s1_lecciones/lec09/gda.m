## Copyright (C) 2022 Pablo Alvarado
## EL5857 Aprendizaje Automático
## Escuela de Ingeniería Electrónica
## Tecnológico de Costa Rica
##
## Para uso exclusivo del curso.

## Borre todo lo que existía hasta ahora
clear all; close all;

## Cargue los datos y use como clase a "sex"
## (otras opciones:"island", "species")
[Xtr,Ytr,Xte,Yte,names] = loadpenguindata("sex");

## ADVERTENCIA: Asegúrese SIEMPRE de normalizar los datos
n=normalizer("normal");

Xtrain=n.fit_transform(Xtr);
Ytrain=Ytr(:,1); # Usar solo columna de "FEMALE" (la otra es el complemento)

Xtest=n.transform(Xte);
Ytest=Yte(:,1);

## Su código aquí:

# Para el entrenamiento
# 1. Extraiga todos los datos correspondientes a 'FEMALE' (i.e. y=1)
# 2. Extraiga todos los datos correspondientes a 'MALE' (i.e. y=0)
# 3. Calcule los parámetros correspondientes a las distribuciones
#    gaussianas de cada clase (Ver lección 8, folio 9)
#
# Para los datos de prueba
# 4. Calcule la predicción de que el dato sea de la clase 'FEMALE',
#    dado cada dato; es decir, indique con y=1 si el dato es de esa
#    clase o 0 de otro modo.
#    La función mvnpdf le puede ser útil (paquete statistics)
#    (multivariate normal probability density function).
# 5. Calcule el error empírico con los datos de entrenamiento y con
#    los datos de prueba.


