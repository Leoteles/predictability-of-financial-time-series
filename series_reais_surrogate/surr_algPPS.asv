close all;
clear all;
clc;

carrega_series;


%Parâmetros da rotina de analise de dados sub-rogados
Nsur = 50;%Número de surrogates
algoritmo = 'PPS';%Algoritmo utilizado
msg = 1;%Mostra mensagens
fig = 1;%Mostra figuras
est = 'todas';%Mostra todas as estatisticas

rand('state',0);
randn('state',0);


%Série ARCH(1)
serie = arch1;
tic
[estrutura, prev] = analiseSurrogates(serie,Nsur,algoritmo,est,msg,fig);
disp('PREV(serie)');prev(1)
toc


%Série GARCH(1,1)
serie = garch11;
tic
[estrutura, prev] = analiseSurrogates(serie,Nsur,algoritmo,est,msg,fig);
disp('PREV(serie)');prev(1)
toc

%Série LOGMAP
serie = logistica;
tic
[estrutura, prev] = analiseSurrogates(serie,Nsur,algoritmo,est,msg,fig);
disp('PREV(serie)');prev(1)
toc



figure(1);
print -depsc 'fig_surrpps_arch1_d2';
figure(2);
print -depsc 'fig_surrpps_arch1_sampen';
figure(3);
print -depsc 'fig_surrpps_arch1_ami';

figure(4);
print -depsc 'fig_surrpps_garch11_d2';
figure(5);
print -depsc 'fig_surrpps_garch11_sampen';
figure(6);
print -depsc 'fig_surrpps_garch11_ami';

figure(7);
print -depsc 'fig_surrpps_logmap_d2';
figure(8);
print -depsc 'fig_surrpps_logmap_sampen';
figure(9);
print -depsc 'fig_surrpps_logmap_ami';
