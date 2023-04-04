% Exemplo identificação da eq. logisitica
close all;
clear all;
clc; 

% Carregar dados
N = 3500;
lambda = 3.9;%Parâmetro de bifurcação do mapa  
y(1) = 0.1;%Valor inicial;
for n = 2:N
    y(n) = lambda * y(n-1) * (1-y(n-1));
end
y = y';

% Montar matriz de regressores
reg1=ones(8,1);		% constante
reg2=y(12:19);		% y(k-1)
reg3=y(11:18);		% y(k-2)
reg4=reg2.^2;		% y(k-1)^2
reg5=reg2.*reg3;	% y(k-1)y(k-2)
reg6=reg3.^2;		% y(k-2)^2

psi=[reg1 reg2 reg3 reg4 reg5 reg6];
vec=y(13:20);
Psi=[psi vec];


[A,err,piv]=myhouse(Psi,6)
% numero de parametros no modelo final
np=3;
Psit=Psi(:,piv(1:np));
teta=inv(Psit'*Psit)*Psit'*vec

%eliminando o regressor "constante" 

Psit=Psi(:,piv(2:3));
teta=inv(Psit'*Psit)*Psit'*vec
