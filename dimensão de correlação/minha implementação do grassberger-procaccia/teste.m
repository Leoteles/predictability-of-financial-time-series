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

%todos os três algoritmos dão o mesmo resultado, mas o fast2 é muito mais
% %rápido
% myCorDim - Elapsed time is 7.505412 seconds.
% myCorDim_fast - Elapsed time is 4.000828 seconds.
% myCorDim_fast2 - Elapsed time is 0.362489 seconds.
% Este último é usado para se criar o calculadimensãogp, que tem como
% diferença: m=1:10 ou um vetor passado como parâmetro, o cálculo do vetor r,
% o cálculo do log10 e a maneira como são retornados os valores da função
