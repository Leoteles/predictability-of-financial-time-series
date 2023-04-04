close all;
clear all;
clc;

carrega_series;

%Par�metros da rotina de analise de dados sub-rogados
Nsur = 50;%N�mero de surrogates
algoritmo = 'alg1';%Algoritmo utilizado
msg = 1;%Mostra mensagens
fig = 1;%Mostra figuras
est = 'todas';%Mostra todas as estatisticas

rand('state',0);
randn('state',0);

inovacoes = rand(3501,1) - 0.5;%inova��es uniformes
serie(1) = inovacoes(1);
for i = 2:3501
    serie(i) = 0.3 * inovacoes(i-1) + inovacoes(i);
end

%S�rie ma(1) uniforme
tic
[estrutura, prev] = analiseSurrogates(serie,Nsur,algoritmo,est,msg,fig);
prev(1)
toc
res1 = estrutura;
prev1 = prev;




figure(1);
print -depsc 'fig_surr1_ma1uni_d2';
figure(2);
print -depsc 'fig_surr1_ma1uni_sampen';
figure(3);
print -depsc 'fig_surr1_ma1uni_ami';
