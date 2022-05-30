function [Cout,P,R,F1]=conf_matrix(actual,prediction)  # recibe 2 matricez con los elementos en cada columna y su clasificaci�n en cada fila
  
  [ma,ia]=max(prediction);
  I=eye(rows(prediction));
  one=I(:,ia);

  Cout=zeros(rows(actual),rows(one));
  actual=2.*actual;
  wm=actual+one;
  P=zeros(1,rows(actual));
  R=zeros(1,rows(actual));
  F1=zeros(1,rows(actual));



  
  for i= [1:columns(actual)]
    for k= [1:rows(actual)]
      if wm(k,i)==3
        Cout(k,k)=Cout(k,k)+1;
      elseif wm(k,i)==1
        for j = [1:(rows(actual)-1)]
          if (wm(j,i) == 2 || wm(j,i) == 1)==1
            Cout(j,k)=Cout(j,k)+1;
          endif
        endfor
      endif
      
      
    endfor
  endfor

  for i= [1:rows(Cout)]
    P(i)=Cout(i,i)/sum(Cout(:,i));
    R(i)=Cout(i,i)/sum(Cout(i,:),2);
    F1(i)=(2*P(i)*R(i))/(P(i)+R(i));
  endfor
  printf("Vector de presici�n es de:")
  disp(P)
  printf("Vector de exhaustividad es de:")
  disp(R)
  pause;
  
endfunction
    
   
