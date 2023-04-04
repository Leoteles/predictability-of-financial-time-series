close all;
clear all;
clc;

carrega_series;

N = 3500;%Tamanho da série

%Gera estrutura AR(1) com parametro a = 0.3 e inovações uniformes
rand('state',0);
y(1) = rand();
for t=2:N
    y(t) = 0.3 * y(t-1) + (rand-0.5);
end
ar1uni = y';

%Parâmetros da rotina de analise de dados sub-rogados
Nsur = 50;%Número de surrogates
algoritmo = 'alg2';%Algoritmo utilizado
msg = 1;%Mostra mensagens
fig = 1;%Mostra figuras
est = 'todas';%Mostra todas as estatisticas

rand('state',0);
randn('state',0);


%Série AR(1)
serie = ar1;
tic
[estrutura, prev] = analiseSurrogates(serie,Nsur,algoritmo,est,msg,fig);
prev(1)
toc

%Série AR(1) uniforme
serie = ar1uni;
tic
[estrutura, prev] = analiseSurrogates(serie,Nsur,algoritmo,est,msg,fig);
prev(1)
toc

%Transformação não Linear estática do processo linear
% R1 NR2 mais ou menos, quase que rejeita. Mas fica bem próximo dos
% sub-rogados
serie = ar1 .* sqrt(abs(ar1));
tic
[estrutura, prev] = analiseSurrogates(serie,Nsur,algoritmo,est,msg,fig);
prev(1)
toc

%Série ARCH(1)
serie = arch1;
tic
[estrutura, prev] = analiseSurrogates(serie,Nsur,algoritmo,est,msg,fig);
prev(1)
toc

figure(1);
print -depsc 'fig_surr2_ar1_d2';
figure(2);
print -depsc 'fig_surr2_ar1_sampen';
figure(3);
print -depsc 'fig_surr2_ar1_ami';
figure(4);
print -depsc 'fig_surr2_ar1uni_d2';
figure(5);
print -depsc 'fig_surr2_ar1uni_sampen';
figure(6);
print -depsc 'fig_surr2_ar1uni_ami';
figure(7);
print -depsc 'fig_surr2_ar1nl_d2';
figure(8);
print -depsc 'fig_surr2_ar1nl_sampen';
figure(9);
print -depsc 'fig_surr2_ar1nl_ami';
figure(10);
print -depsc 'fig_surr2_arch1_d2';
figure(11);
print -depsc 'fig_surr2_arch1_sampen';
figure(12);
print -depsc 'fig_surr2_arch1_ami';

