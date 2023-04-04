close all;
clear all;
clc;

load 'serieRuidoBranco.mat';
x = serieRuidoBranco;

%h = 0 -> não rejeita a hipotese de que é normal
%h = 1 -> rejeita a hipotese de que é normal
%com intervalo de confiança de 95%
disp('Testes de normalidade para ruído branco gaussiano');
%Valor da estatistica k
%Valor limite c
%Se k>c, rejeita a hipotese de gaussianidade
%Lilliefors test
[hli pli kli cli] = lillietest(x);
[hli kli cli]
%Jarque-Bera test
[hjb pjb kjb cjb] = jbtest(x);
[hjb kjb cjb]
%One-sample Kolmogorov-Smirnov test
[hks,pks,kks,cks] = kstest(x);
[hks kks cks]


disp('Testes de normalidade para processo com inovações uniformes');
%Para x uniforme
x = rand(3500,1);

%Valor da estatistica k
%Valor limite c
%Se k>c, rejeita a hipotese de gaussianidade
%Lilliefors test
[hli pli kli cli] = lillietest(x);
[hli kli cli]
%Jarque-Bera test
[hjb pjb kjb cjb] = jbtest(x);
[hjb kjb cjb]
%One-sample Kolmogorov-Smirnov test
[hks,pks,kks,cks] = kstest(x);
[hks kks cks]



