## (C) 2022 Pablo Alvarado
## 5857 Aprendizaje Automático
## Tecnológico de Costa Rica

## Genere datos 
[X,y]=gendata(20);

minx=min(X(:));
maxx=max(X(:));

## Estos son los puntos en donde se quiere evaluar la función con regresión
nx=linspace(minx,maxx,100);

figure(1,"name","Lowess");

## Grafique los datos de entrenamiento
hold off;
plot(X,y,"ko","markersize",6);


## Realice la regresión ponderada localmente
z=lowess(nx,X,y,0.5);

## Muestre el resultado de la regresión
hold on;
plot(nx,z,"r","linewidth",3);
