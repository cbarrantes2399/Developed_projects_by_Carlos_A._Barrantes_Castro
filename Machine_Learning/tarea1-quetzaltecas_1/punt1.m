%%%Tarea 1 - Aprendizaje Automático%%%

%Autores: Carlos Barrantes y Salomón Ramírez

%Tecnológico de Costa Rica - I Semestre 2022

%A=[2 0.1;0.1 1];
A=eye(2);
b=[-0.5 0];

%function punt1(A,b,rango)
X=[-3:0.5:3];
%X=linspace(1,3,1);
Y=[-3:0.25:3];
%Y=linspace(-1,1,2);

[XX, YY] = meshgrid (X,Y);

eq=[XX(:) YY(:)]';
Z = sum(eq.*(A*eq))+b*eq;
figure(1)
surf(XX, YY, reshape(Z,size(XX)));
%%%%%%%%3.1%%%%%%%
A=[2 0.1;0.1 1];
Z1 = sum(eq.*(A*eq))+b*eq;
figure(2)
surf(XX, YY, reshape(Z1,size(XX)));
%%%%%%%%3.2%%%%%%%
A=diag([4,2]);
Z2 = sum(eq.*(A*eq))+b*eq;
figure(3)
surf(XX, YY, reshape(Z2,size(XX)));