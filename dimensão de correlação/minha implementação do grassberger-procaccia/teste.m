close all;
clear all;
clc;


carrega_series

%serie = sin(1:100);
serie = logistica(1:200);
clearvars ** -except serie


tic
beta = myCorDim(serie);
toc

Cm0 = beta.Cm;

tic
beta = myCorDim_fast(serie);
toc

Cm1 = beta.Cm;

tic
beta = myCorDim_fast2(serie);
toc

Cm2 = beta.Cm;

isequal(Cm0,Cm1)
isequal(Cm0,Cm2)

%todos os tr�s algoritmos d�o o mesmo resultado, mas o fast2 � muito mais
% %r�pido
% myCorDim - Elapsed time is 7.505412 seconds.
% myCorDim_fast - Elapsed time is 4.000828 seconds.
% myCorDim_fast2 - Elapsed time is 0.362489 seconds.
% Este �ltimo � usado para se criar o calculadimens�ogp, que tem como
% diferen�a: m=1:10 ou um vetor passado como par�metro, o c�lculo do vetor r,
% o c�lculo do log10 e a maneira como s�o retornados os valores da fun��o
