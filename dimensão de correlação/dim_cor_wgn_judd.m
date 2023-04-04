close all;
clear all;
clc;

carrega_series

%serie = sin(1:100);
serie = logistica;%(1:1000); %Demora um minuto para calcular essa série toda para um único m
clearvars ** -except serie

vetor_m = 2;
%No código abaixo deve-se fazer pretty=1
figure;
[m,dc,eps0,ci] = judd(serie,vetor_m);%,tau,nbins,nt,dt);


% %Calcula logC para o vetor m de dimensões de imersão
% tic
% [m,logC,logr] = calculaDimensaoGP(serie,vetor_m);
% logC = logC';
% logr = logr';
% toc
% 
% %Plota logc X logr para os varios m
% cores = ['b','g','r','c','m','y','k'];
% %cores = ['k','k','k','k','k','k','k'];
% espessura = linspace(0.5,5,length(vetor_m));
% figure;
% hold on;
% for i = 1:length(vetor_m)
%     plot(logr,logC(:,i),cores(i),'LineWidth',espessura(i));
% end
% grid minor;
% xlabel('log(\epsilon)');
% ylabel('log(C(\epsilon))');
% legend('m = 2','m = 3','m = 4','m = 5','m = 6','m = 7','m = 8','Location','SouthEast');
% %print -depsc 'fig_dim_cor_wgn_m2a8';
% 
% 
% 
% %Estima e plota a dimensão de correlação para um determinado m
% im = find(vetor_m==2);%Estima a reta apenas para m = 2
% %n = find(isinf(logC,m)==0,1);%Primeiro indice que não é infinito
% inicio = 90;
% fim = 140;
% %fun = fit(logr(n:end),logC(n:end,m),'poly1');
% fun = fit(logr(inicio:fim),logC(inicio:fim,im),'poly1');
% 
% %Estimação da dimensão de correlação
% D_2 = fun.p1
% 
% %Calcula a reta estimada
% y_reta = fun.p1 * logr + fun.p2;
% 
% figure;
% plot(logr,logC(:,im),'.b');
% hold on;
% plot(logr,y_reta,'--r');
% hold on;
% grid minor;
% xlabel('log(\epsilon)');
% s1 = sprintf('log(C(\\epsilon))   m = %g', vetor_m(im));
% ylabel(s1);
% legend('log(C(\epsilon))','Reta estimada','Location','SouthEast');
% s2 = sprintf('Dimensão estimada: %g', fun.p1);
% annotation('textbox',  [.15 .6 .3 .1],'string',s2,'BackgroundColor',[1 1 1]);
% %print -depsc 'fig_dim_cor_wgn_m2';
% 
% 
% %Estima a dimensão de correlação para todas as dimensões de imersão do
% %vetor m e plota os valores em função de m
% inicio = [90 115 120 130 135 140 140];
% fim = [150 150 150 150 150 150 150];
% for i = 1:length(vetor_m)
%     fun = fit(logr(inicio(i):fim(i)),logC(inicio(i):fim(i),i),'poly1');
%     %Estimação da dimensão de correlação
%     dimensoes(i) = fun.p1;
% end
% figure;
% plot(vetor_m,dimensoes,'-b');
% grid minor;
% xlabel('Dimensão de imersão m');
% ylabel('Dimensão de correlação estimada D_2');
% %print -depsc 'fig_dim_cor_wgn_compara_m';


%save('wgn_m2a8.mat','logC','logr','vetor_m');