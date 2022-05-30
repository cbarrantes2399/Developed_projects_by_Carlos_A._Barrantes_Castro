% Copyright (C) 2022 Pablo Alvarado
% EL5857 Aprendizaje Automático
% Tarea 3
% (C) 2022 Carlos Barrantes y Salomón Ramírez

% Softmax testbench
close all;
[Xtr,Ytr,Xte,Yte,names] = loadpenguindata("species");

y= [Ytr(:,1) , 2*Ytr(:,2), 3*Ytr(:,3)];
y = sum(y,2);

n=normalizer("normal");

Xtrain=n.fit_transform(Xtr);
Xtest=n.transform(Xte);

k=columns(Ytr);
m=k*rows(Xtr);
X = [Xtrain(:,1),Xtrain(:,2)]; ##################
X = [ones(rows(Xtrain),1) X]; ## Prefix them with the bias term (ones)
Xt = [Xtest(:,1),Xtest(:,2)];
Xt = [ones(rows(Xt),1) Xt];


## Plot the data
figure(1,"name","All classes"); hold off;

colors={"r";"g";"b";"m";"c";"k"};
markers={"o";"s";"v";"*";"x";"+"};

hold on;
for kk=1:k
  scatter(X(Ytr(:,kk)==1,2),X(Ytr(:,kk)==1,3),colors{kk},markers{kk},"filled");
endfor
grid on;
xlabel("x");
ylabel("y");

if (~exist("Theta","var") || ~prod(size(Theta) == [5,k]) ) ######## 3 o 5
  Theta=zeros(5,k); ## For simplicity we will carry the k-th
endif

fflush(stdout);

## Initial configuration for the optimizer
opt=optimizer("method","adam",
              "minibatch",8,
              "maxiter",15000,
              "alpha",0.002);

# test all optimization methods
methods={"batch","sgd","momentum","rmsprop","adam"};
for m=1:numel(methods)
  method=methods{m};
  printf("Probando método '%s'.\n",method);
  msg=sprintf(";%s;",method); ## use method in legends

  try
    opt.configure("method",method); ## Just change the method
    if (~exist("Theta1","var") || ~prod(size(Theta1) == [3,k]) ) ######## 3 o 5
      Theta1=zeros(3,k); ## For simplicity we will carry the k-th
    endif
    [ts,errs]=opt.minimize(@softmax_loss,@softmax_gradloss,Theta1,X,Ytr);
    Theta1=ts{end}
    
    figure(20);
    plot(errs,msg,"linewidth",2);  
    hold on
  catch
    printf("\n### Error detectado probando método '%s': ###\n %s\n\n",
           method,lasterror.message);
  end_try_catch
endfor

figure(20);
xlabel("Iteration");
ylabel("Loss");
grid on;  

###########################################################################
##############################Punto 7######################################
###########################################################################
Xtrain=[ones(rows(Xtrain),1),Xtrain];
for u = 3:5
  x8=[];
  x8=[ones(rows(Xtrain),1),Xtrain(:,2),Xtrain(:,u)];
  printf("########Combinación de características: 1 y %d ######## \n\n", u-1)
  if (~exist("Theta1","var") || ~prod(size(Theta1) == [3,k]) ) ######## 3 o 5
      Theta1=zeros(3,k); ## For simplicity we will carry the k-th
  endif
  [ts,errs]=opt.minimize(@softmax_loss,@softmax_gradloss,Theta1,x8,Ytr);
  Theta1=ts{end}
  if u == 3
    printf("########Combinación de características: 2 y 3 ######## \n\n")
    x8=[ones(rows(Xtrain),1),Xtrain(:,u),Xtrain(:,u+1)];
    if (~exist("Theta1","var") || ~prod(size(Theta1) == [3,k]) ) ######## 3 o 5
        Theta1=zeros(3,k); ## For simplicity we will carry the k-th
    endif
    [ts,errs]=opt.minimize(@softmax_loss,@softmax_gradloss,Theta1,x8,Ytr);
    Theta1=ts{end}
    printf("########Combinación de características: 2 y 4 ######## \n\n")
    xt = [Xtrain(:,u),Xtrain(:,u+2)];
    x8=[ones(rows(xt),1),xt];
    if (~exist("Theta1","var") || ~prod(size(Theta1) == [3,k]) ) ######## 3 o 5
        Theta1=zeros(3,k); ## For simplicity we will carry the k-th
    endif
    [ts,errs]=opt.minimize(@softmax_loss,@softmax_gradloss,Theta1,x8,Ytr);
    Theta1=ts{end}
         #Create an image, where the color of the pixel is created by
     #combining a bunch of colors representing each class, and the
     #mixture is made with the probabilities.

    x=linspace(-1,1,256);
    [GX,GY]=meshgrid(x,x);
    FX = [ones(size(GX(:)),1) GX(:) GY(:)];
    FZ = softmax_hyp(Theta1,FX)';
    #FZ = [FZ; ones(1,columns(FZ))-sum(FZ)]; ## Append the last probability

    ## A figure with the winners
    [maxprob,maxk]=max(FZ);

    figure(21,"name","Winner classes, características 2 y 4");

    winner=flip(uint8(reshape(maxk,size(GX))),1);
    cmap = [0,0,0; 1,0,0; 0,1,0; 0,0,1; 0.5,0,0.5; 0,0.5,0.5; 0.5,0.5,0.0];
    wimg=ind2rgb(winner,cmap);
    imshow(wimg);

    ## A figure with the weighted winners
    figure(23,"name","Softmax classes, características 2 y 4");

    ccmap = cmap(2:1+k,:);
    cwimg = ccmap'*FZ;

    redChnl   = reshape(cwimg(1,:),size(GX));
    greenChnl = reshape(cwimg(2,:),size(GX));
    blueChnl  = reshape(cwimg(3,:),size(GX));

    mixed = flip(cat(3,redChnl,greenChnl,blueChnl),1);
    imshow(mixed);

    ## Show the output probability for each class separately
    for (kk=1:k)
      figure(kk+1,"name",cstrcat("Class ",num2str(kk)));
      hold off;

      x=-3:0.05:3;
      [GX,GY]=meshgrid(x,x);
      FX = [ones(size(GX(:)),1) GX(:) GY(:)];
      FZ = softmax_hyp(Theta1,FX)';
      FZ = [FZ; ones(1,columns(FZ))-sum(FZ)]; ## Add the last probability
      GZ = reshape(FZ(kk,:),size(GX));
      surface(GX,GY,GZ);
      daspect([1,1,1]);
      hold on;
      
      scatter3(X(y==kk,2),X(y==kk,3),y(y==kk)/kk,
               [],colors{kk},markers{kk},"filled");
      scatter3(X(y!=kk,2),X(y!=kk,3),y(y!=kk)*0,
               [],"k","+","filled");

      xlabel("x");
      ylabel("y");
    endfor;

  endif
  if u == 4
    printf("########Combinación de características: 3 y 4 ######## \n\n")
    xt=[Xtrain(:,u),Xtrain(:,u+1)];
    x8=[ones(rows(xt),1),xt];
    if (~exist("Theta1","var") || ~prod(size(Theta1) == [3,k]) ) ######## 3 o 5
        Theta1=zeros(3,k); ## For simplicity we will carry the k-th
    endif
    [ts,errs]=opt.minimize(@softmax_loss,@softmax_gradloss,Theta1,x8,Ytr);
    Theta1=ts{end}
  endif
endfor