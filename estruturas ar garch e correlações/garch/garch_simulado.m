close all;
clear all;
clc;

%Define um modelo de media
%Coeficientes AR = [0.5 -0.8]
%C = constante = 0
spec = garchset('AR',[0.5 -0.8],...
                'C',0,...
                'K',0.005);

%Simula
[e,s,y] = garchsim(spec,2000);

%Obtem os parametros do modelo AR2 por Yule-Walker
%'e' é a estimativa da variancia da inovação
%'a' é o vetor de coeficientes na forma polinomial.
%Ou seja, a resposta tem sinal invertido:
%y(k) = -a(2) * y(k-1)  +  -a(3) * y(k-2) +  e
% onde e ~ N(0,var_e)
[a,var_e] = aryule(y,2)


%Obtem os parametros do modelo AR2 pelo garchfit
spec = garchset('R',2);%Define a estrutura a ser usada na identificação
[coeff,errors] = garchfit(spec,y);
garchdisp(coeff,errors)