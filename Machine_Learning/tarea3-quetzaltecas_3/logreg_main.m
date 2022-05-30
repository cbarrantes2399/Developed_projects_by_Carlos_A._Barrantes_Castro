close all;

[Xtr,Ytr,Xte,Yte,names] = loadpenguindata("sex");


########## Pensando solo en clasificación F y M ########

##Normalizando
n=normalizer("minmax");

Xtrain=n.fit_transform(Xtr);
YtrainF=Ytr(:,1);                       ##clasificación macho y hembra
Yte = Yte(:,1);

Xtest=n.transform(Xte);
Xte = [ones(rows(Xtest),1),Xtest];
Xtr = [ones(rows(Xtrain),1),Xtrain];           ##generando !s para sesgo 


## Now to the logistic regression with (batch) gradient descent

sigmoid = @(x) 1./(1+exp(-x));
############################################################3

## Initial configuration for the optimizer
opt=optimizer("method","batch",
              "minibatch",8,
              "maxiter",5000,
              "alpha",0.002);


# test all optimization methods
methods={"batch","sgd","momentum","rmsprop","adam"};
for m=1:numel(methods)
  method=methods{m};
  printf("Probando método '%s'.\n",method);
  msg=sprintf(";%s;",method); ## use method in legends

  try
    opt.configure("method",method); ## Just change the method
    theta0=rand(columns(Xtr),1)-0.5; ## Common starting point (column vector)
    [ts,errs]=opt.minimize(@logreg_loss,@logreg_gradloss,theta0,Xtr,YtrainF);
    theta=ts{end}
    printf("Error de entrenamiento:")
    hn=logreg_hyp(theta,Xtr);
    [r, cont1, p] = error_funct(YtrainF,hn);
    printf("Error de prueba:")
    hn1=logreg_hyp(theta,Xte);
    [r, cont1, p] = error_funct(Yte,hn1);
    
    figure(1);
    plot(errs,msg,"linewidth",2);  
    hold on
  catch
    printf("\n### Error detectado probando método '%s': ###\n %s\n\n",
           method,lasterror.message);
  end_try_catch
endfor

figure(1);
xlabel("Iteration");
ylabel("Loss");
grid on;  
###########################################################################
##############################Punto 8######################################
###########################################################################

for i = 2:columns(Xtr)
  printf("########Combinación de características: Sesgo y %d ######## \n\n", i-1)
  x8=[];  
  x8=[ones(rows(Xtr),1),Xtr(:,i)];
  xte8=[ones(rows(Xte),1),Xte(:,i)];
  theta=combi_carac(x8,YtrainF,opt)
  hn=logreg_hyp(theta,xte8);
  printf("Errores empíricos:")
  [r, cont1, p] = error_funct(Yte,hn);
endfor

for u = 3:5
  x8=[];  
  x8=[ones(rows(Xtr),1),Xtr(:,2),Xtr(:,u)];
  xte8=[ones(rows(Xte),1),Xte(:,2),Xte(:,u)];
  printf("########Combinación de características: 1 y %d ######## \n\n", u-1)
  theta=combi_carac(x8,YtrainF,opt)
  hn=logreg_hyp(theta,xte8);
  printf("Errores empíricos:")
  [r, cont1, p] = error_funct(Yte,hn);
  if u == 3
    printf("########Combinación de características: 2 y 3 ######## \n\n")
    x8=[ones(rows(Xtr),1),Xtr(:,u),Xtr(:,u+1)];
    xte8=[ones(rows(Xte),1),Xte(:,u),Xte(:,u+1)];
    theta=combi_carac(x8,YtrainF,opt)
    hn=logreg_hyp(theta,xte8);
    printf("Errores empíricos:")
    [r, cont1, p] = error_funct(Yte,hn);
    printf("########Combinación de características: 2 y 4 ######## \n\n")
    xt = [Xtr(:,u),Xtr(:,u+2)];
    x8=[ones(rows(Xtr),1),xt];
    xte8=[ones(rows(Xte),1),Xte(:,u),Xte(:,u+2)];
    theta=combi_carac(x8,YtrainF,opt)
    hn=logreg_hyp(theta,xte8);
    printf("Errores empíricos:")
    [r, cont1, p] = error_funct(Yte,hn);
    ## Plot the data
    figure(2,"name","F vs M considerando características: 2 y 4");
    plot(xt(YtrainF==0,1),xt(YtrainF==0,2),'ro',
         xt(YtrainF==1,1),xt(YtrainF==1,2),'b+');
    hold on;
    x=-1:0.05:1;
    lslope = -theta(2)/theta(3);
    loffset= -theta(1)/theta(3);
    plot(x,lslope*x+loffset,'k;learned;'); ## Learned
    hold off;
    
    ## Plot hypothesis in 3D
    figure(3,"name","Clasificador considerando características: 2 y 4 ");
    hold off;
    [GX,GY]=meshgrid(x,x);
    FX = [ones(size(GX(:)),1) GX(:) GY(:)];
    GZ=reshape(sigmoid(FX*theta'),size(GX));
    surface(GX,GY,GZ);
    daspect([1,1,1]);
    hold on;
    plot3(xt(YtrainF<0.5,1),xt(YtrainF<0.5,2),YtrainF(YtrainF<0.5)+0.5,'ro',
          xt(YtrainF>0.5,1),xt(YtrainF>0.5,2),YtrainF(YtrainF>0.5)*0.5,'b+');
  endif
  if u == 4
    printf("########Combinación de características: 3 y 4 ######## \n\n")
    xt=[Xtr(:,u),Xtr(:,u+1)];
    x8=[ones(rows(xt),1),xt];
    xte8=[ones(rows(Xte),1),Xte(:,u),Xte(:,u+1)];
    theta=combi_carac(x8,YtrainF,opt)
    hn=logreg_hyp(theta,xte8);
    printf("Errores empíricos:")
    [r, cont1, p] = error_funct(Yte,hn);
  endif
endfor

printf("######################################################\n")
printf("#Trayectoria de theta para 3 métodos de optimización #\n")
printf("######################################################\n")
# test all optimization methods
methods={"rmsprop","sgd","momentum"};
for m=1:numel(methods)
  method=methods{m};
  printf("Probando método '%s'.\n",method);
  msg=sprintf(";%s;",method); ## use method in legends
  xt=[Xtr(:,3),Xtr(:,4),Xtr(:,5)];
  #x8=[ones(rows(xt),1),xt];
  try
    opt.configure("method",method); ## Just change the method
    theta0=rand(columns(xt),1)-0.5;
    [ts,errs]=opt.minimize(@logreg_loss,@logreg_gradloss,theta0,xt,YtrainF);
    theta=ts{end}
    ts=cell2mat(ts');
    figure(4);
    plot3(ts(:,1),ts(:,2),ts(:,3));
    hold on
  catch
    printf("\n### Error detectado probando método '%s': ###\n %s\n\n",
           method,lasterror.message);
  end_try_catch
endfor