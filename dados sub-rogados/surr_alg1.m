close all;
clear all;
clc;

carrega_series;

%Parâmetros da rotina de analise de dados sub-rogados
Nsur = 50;%Número de surrogates
algoritmo = 'alg1';%Algoritmo utilizado
msg = 1;%Mostra mensagens
fig = 1;%Mostra figuras
est = 'todas';%Mostra todas as estatisticas

rand('state',0);
randn('state',0);

serie = rand(3501,1) - 0.5;

%Série AR(1)
serie = ar1;
tic
[estrutura, prev] = analiseSurrogates(serie,Nsur,algoritmo,est,msg,fig);
prev(1)
toc
res1 = estrutura;
prev1 = prev;

%Série ARCH(1)
serie = arch1;
tic
[estrutura, prev] = analiseSurrogates(serie,Nsur,algoritmo,est,msg,fig);
prev(1)
toc
res2 = estrutura;
prev2 = prev;



figure(1);
print -depsc 'fig_surr1_ar1_d2';
figure(2);
print -depsc 'fig_surr1_ar1_sampen';
figure(3);
print -depsc 'fig_surr1_ar1_ami';

figure(4);
print -depsc 'fig_surr1_arch1_d2';
figure(5);
print -depsc 'fig_surr1_arch1_sampen';
figure(6);
print -depsc 'fig_surr1_arch1_ami';

