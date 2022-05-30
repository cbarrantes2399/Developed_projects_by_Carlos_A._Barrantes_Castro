##cargar datos de entrenamiento
data=load("escazu.dat");

##separar el vector àrea
area=data(:,1);

##separar el vector precio
precio=data(:,4);

## Extraiga min-max de áreas y precio
amin=min(area);
amax=max(area);

pmax=max(precio);
pmin=min(precio);

## Use las ecuaciones normales para calcular los parámetros de
## regresión lineal

x= [ones((rows(area)),1),area];
theta=inv(x'*x)*x'*precio;

## Grafique los puntos originales y la recta de regresión lineal con
## al menos 100 puntos

a=linspace(amin,amax,100);
aa=[ones((rows(a')),1),a'];

## puntos "soluciòn"

pp=aa*theta;

#figure=(1, "name", "Regresiòn Lineal");

plot(area, precio, "*");

hold on;

plot(a', pp, "linewidth",3);

hold on;
