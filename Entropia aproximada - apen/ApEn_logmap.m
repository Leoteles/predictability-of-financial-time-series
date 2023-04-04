close all;
clear all;
clc;

%Apen demora aprox. 2 minutos para ser calculada para uma s�rie de 3500 elementos e
%m=2;

%Do jeito que sest� o script abaixo, demora 4 horas para rodar tudo.

%Obtem o desvio padr�o do mapa log�stico para definir o intervalo de
%valores de epsilon
carrega_series;

std_logmap = std(logistica);
clearvars ** -except std_logmap;



N = 3500;%N�mero de dados da s�rie
lambda = 3.5:0.1:4;%Par�metro de bifurca��o do mapa  
y(1:length(lambda),1) = 0.1;%Valor inicial;

%Vetor de distancias para o c�lculo da ApEn. No artigo do Pincus � r.
%Varia de 0 a 30% do desvio padr�o. A sugest�o de Pincus � 10 a 20% do desvio.
epsilon = linspace(1e-9,0.3*std_logmap,20);
%Par�metro para ApEn (dimens�o de imers�o para prob. a anteriori)
m = 2;

for i = 1:length(lambda)
    %Calcula o mapa para determinado lambda
    for n = 2:N
        y(i,n) = lambda(i) * y(i,n-1) * (1-y(i,n-1));
    end
    serie = y(i,:);
    
    %Calcula ApEn para esse mapa
    for j = 1:length(epsilon)
        [i j]
        tic
        apen(i,j) = calculaApEn(m,epsilon(j),serie);
        toc
    end
end

%save('apen_calculado_logmap.mat');

%Plota apen para os varios lambda
cores = ['b','g','r','c','m','y'];
%cores = ['k','k','k','k','k','k'];
espessura = linspace(1,6,length(lambda));
figure;
hold on;
for i = 1:length(lambda)
    plot(epsilon,apen(i,:),cores(i),'LineWidth',espessura(i));
end
grid minor;
axis([0 0.15 -0.1 0.8]);
xlabel('\epsilon');
ylabel('ApEn(2,\epsilon,3500)');
legend('\lambda = 3,5','\lambda = 3,6','\lambda = 3,7','\lambda = 3,8','\lambda = 3,9','\lambda = 4,0','Location','SouthEast');
print -depsc 'fig_apen_logmap';
