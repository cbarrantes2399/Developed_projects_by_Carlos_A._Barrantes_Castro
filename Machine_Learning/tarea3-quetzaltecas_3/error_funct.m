function [r, cont1, p] = error_funct(Ytruth,Yevaluada);
  Ybin1= [];
  cont1= 0;
  r=rows(Yevaluada);
  for m=1:rows(Yevaluada)
    if Yevaluada(m,1)<=0.5
      Ybin1=[Ybin1;0];
     else
      Ybin1=[Ybin1;1];
    endif
  endfor
#Ematrix=Ybin1
  for m=1:rows(Ytruth)
    if Ybin1(m,1)!=Ytruth(m,1)
      cont1+=1;
     else
      cont1=cont1;
    endif
  endfor
  #cont1
  p=100*cont1/rows(Ybin1);
  printf(" %d de %d (%f%%)\n", cont1,r,p)
endfunction