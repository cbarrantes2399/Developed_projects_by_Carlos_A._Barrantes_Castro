## (C) 2022 Pablo Alvarado
## (C) 2022 Salomón Ramírez y Carlos Barrantes
## EL5857 Aprendizaje automático
## Tarea 2

## Template file for the whole solution

1;

## Just use 0,1% of the total available data in the experiments
[X,z] = gendata(0.001);

## This is the ground-truth (reference) data to be used for comparison
[RX,rz] = gendata(1,0,0);

## Show the sensed data
close all;

figure(1,"name","Sensed data");
plot3(X(:,1),X(:,2),z',".");
xlabel("x")
ylabel("y")
zlabel("z")
daspect([1,1,0.001]);

## Extract from the ground-truth RX the coordinate range:
minx=min(RX(:,1));
maxx=max(RX(:,1));

miny=min(RX(:,2));
maxy=max(RX(:,2));

## partition is the size of the desired final grid
## the smaller the value, the faster the estimation but
## the coarser the result.
#partition=25;
#partition=50;
partition=75;

[xx,yy]=meshgrid(round(linspace(minx,maxx,partition)),
                 round(linspace(miny,maxy,partition)));

## Flatten the mesh
NX = [xx(:) yy(:)];

printf("Linear regression with no intercept started...");
fflush(stdout);
tic();
nz = linreg_nointercept(NX,X,z);
printf("done.\n");
toc()
fflush(stdout);


figure(2,"name","Linearly regressed data with no intercept");
hold off;
surf(xx,yy,reshape(nz,size(xx)));
xlabel("x")
ylabel("y")
zlabel("z")
daspect([1,1,0.001]);

#####*****************Regresión lineal*****************#####

rz2=linreg(NX,X,z);
figure(3,"name","Punto IV.1.1");
hold off;
surf(xx,yy,reshape(rz2,size(xx)));
xlabel("x")
ylabel("y")
zlabel("z")
title("Regresión lineal sin pasar por el origen")
daspect([1,1,0.001]);


#####*****************Regresión polinomial*****************#####
O=input("Digite el orden que desea para la regresión polinomial:");

rz4=polyreg(NX,X,z,O);
figure(4,"name","Punto IV.1.3");
hold off;
#plot3(xx(:), yy(:),rz4,".");
surf(xx,yy,reshape(rz4,size(xx)));
xlabel("x")
ylabel("y")
zlabel("z")
title("Regresión polinomial sin pasar por el origen")
daspect([1,1,0.001]);

#####*****************Reresión ponderada localmente*****************#####

tau=input("Digite el tau para la regresión ponderada localmente:");

rz5=lowess(NX,X,z,tau);
figure(5,"name","Gráfica para regresión ponderada localmente");
hold off
surf(xx,yy,reshape(rz5,size(xx)));
xlabel("x")
ylabel("y")
zlabel("z")
title("Regresión ponderada localmente")


#####*****************Para error de regresión polinomial*****************#######
indice=sub2ind([maxy,maxx],yy(:),xx(:));
prof=rz(indice);
err=funcerror(NX,X,z,prof,1);

rz6=polyreg(NX,X,z,err);
figure(6,"name","Gráfica con errores mínimos para regresión polinomial");
surf(xx,yy,reshape(rz6,size(xx)));
xlabel("x")
ylabel("y")
zlabel("z")
title("Gráfica con errores mínimos para regresión polinomial")

#####*****************Para error de regresión ponderada*****************#######
err=funcerror(NX,X,z,prof,2);

rz7=lowess(NX,X,z,err);
figure(8,"name","Gráfica con errores mínimos para regresión ponderada localmente");
surf(xx,yy,reshape(rz7,size(xx)));
xlabel("x")
ylabel("y")
zlabel("z")
title("Gráfica con errores mínimos para regresión ponderada localmente")
