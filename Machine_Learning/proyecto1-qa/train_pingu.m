## Copyright (C) 2021-2022 Pablo Alvarado
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5857 Aprendizaje Automático
## Escuela de Ingeniería Electrónica
## Tecnológico de Costa Rica

## Ejemplo de configuración de red neuronal y su entrenamiento
close all;
1;
pkg load statistics;

datashape='spirals';
##datashape='curved';
##datashape='vertical';

colors={"r";"g";"b";"m";"c";"k"};
markers={"o";"s";"v";"*";"x";"+"};

[X,Y,vX,vY,names] = loadpenguindata("species");
numClasses=columns(Y);

k = 4 #simboliza la cantidad de características, 2 o 4
n = normalizer("minmax");
if(k == 4)
X=n.fit_transform(X);
X=[X(:,1) , X(:,2),X(:,3), X(:,4)];

vX=n.transform(vX);
vX=[vX(:,1), vX(:,2),vX(:,3), vX(:,4)];
endif
if(k == 2)
X=n.fit_transform(X);
X=[X(:,1) , X(:,2)];

vX=n.transform(vX);
vX=[vX(:,1), vX(:,2)];
endif

figure(1,"name","Datos de entrenamiento");
hold off;
plot_data(X,Y);

ann=sequential();

file="ann.dat";

reuseNetwork = false;

if (reuseNetwork && exist(file,"file")==2)
  ann.load(file);
else
  ann.nEpochs=2000;
  ann.alpha=0.01;  ## Learning rate
  ann.beta2=0.99;  ## ADAM si beta2>0
  ann.beta=0.9;    ## Momentum
  ann.minibatch=128;
  ann.method="adam";

  ann.add({input_layer(k),
           batchnorm(),
           dense_biased(16),
           LELELU(),
           dense_biased(16),
           LELELU(),
           dense_biased(numClasses),
           Softmax()});
  
  
  #ann.add(input_layer(2));
  #ann.add(dense_unbiased(16));
  #ann.add(sigmoide());
  #ann.add(dense_unbiased(16));
  #ann.add(sigmoide());
  #ann.add(dense_unbiased(numClasses));
  #ann.add(sigmoide());
  
  
  ann.add(mseloss());
endif

loss=ann.train(X,Y,vX,vY);
ann.save(file);

figure(2,"name","Grafica de perdida");
plot(loss(:,1), 'r;Training;')
hold on;
plot(loss(:,2), 'b;Validation;')


## TODO: falta agregar el resto de pruebas y visualizaciones

#Create an image, where the color of the pixel is created by
#combining a bunch of colors representing each class, and the
#mixture is made with the probabilities.

FF=ann.test(vX);
[Cout,P,R,F1]=conf_matrix(vY',FF');
##printf("Vector de presici�n es de: %d\n",P )
##printf("Vector de exhaustividad es de: %d\n",R )

if(k == 2)
x=linspace(-1,1,256);
[GX,GY]=meshgrid(x,x);
FX = [GX(:) GY(:)];
FZ1 = ann.test(FX)';
FZ = [FZ1; ones(1,columns(FZ1))-sum(FZ1)]; ## Append the last probability

## A figure with the winners
[maxprob,maxk]=max(FZ);

figure(3,"name","Winner classes");

winner=flip(uint8(reshape(maxk,size(GX))),1);
cmap = [0,0,0; 1,0,0; 0,1,0; 0,0,1; 0.5,0,0.5; 0,0.5,0.5; 0.5,0.5,0.0];
wimg=ind2rgb(winner,cmap);
imshow(wimg);

## A figure with the weighted winners
figure(4,"name","Sigmoide classes");

ccmap = cmap(2:2+numClasses,:);
cwimg = ccmap'*FZ;

redChnl   = reshape(cwimg(1,:),size(GX));
greenChnl = reshape(cwimg(2,:),size(GX));
blueChnl  = reshape(cwimg(3,:),size(GX));

mixed = flip(cat(3,redChnl,greenChnl,blueChnl),1);
imshow(mixed);
endif

pause;
