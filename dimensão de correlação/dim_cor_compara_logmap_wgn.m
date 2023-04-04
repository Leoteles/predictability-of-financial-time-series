close all;
clear all;
clc;

load('logmap_m2a8.mat');

logC_logmap = logC;
logr_logmap = logr;
vetor_m_logmap = vetor_m;

load('wgn_m2a8.mat');

logC_wgn = logC;
logr_wgn = logr;
vetor_m_wgn = vetor_m;

%confere se os vetores m s�o iguais
isequal(vetor_m_wgn,vetor_m_logmap)

%Estima a dimens�o de correla��o para todas as dimens�es de imers�o do
%vetor m e plota os valores em fun��o de m
%limites para o scaling range
inicio_logmap = [100 100 100 100 100 100 100];
fim_logmap = [140 140 140 140 140 140 140];
inicio_wgn = [100 110 120 130 140 140 140];
fim_wgn = [150 150 150 150 150 150 150];
for i = 1:length(vetor_m)
    
    fun = fit(logr_logmap(inicio_logmap(i):fim_logmap(i)),logC_logmap(inicio_logmap(i):fim_logmap(i),i),'poly1');
    %Estima��o da dimens�o de correla��o
    dimensoes_logmap(i) = fun.p1;

    fun = fit(logr_wgn(inicio_wgn(i):fim_wgn(i)),logC_wgn(inicio_wgn(i):fim_wgn(i),i),'poly1');
    %Estima��o da dimens�o de correla��o
    dimensoes_wgn(i) = fun.p1;

end

figure;
plot(vetor_m,dimensoes_logmap,'-b','LineWidth',2);
hold on;
plot(vetor_m,dimensoes_wgn,'--r','LineWidth',2);
hold off;
grid on;
xlabel('Dimens�o de imers�o m');
ylabel('Dimens�o de correla��o estimada D_2');
legend('Mapa log�stico','Ru�do branco gaussiano','Location','NorthWest');
print -depsc 'fig_dim_cor_compara_logmap_wgn';

