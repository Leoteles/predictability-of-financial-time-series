close all;
clear all;
clc;

carrega_series;


%Parâmetros da rotina de analise de dados sub-rogados
Nsur = 50;%Número de surrogates
algoritmo = 'ss';%Algoritmo utilizado
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
print -depsc 'fig_surrss_arch1_d2';
figure(2);
print -depsc 'fig_surrss_arch1_sampen';
figure(3);
print -depsc 'fig_surrss_arch1_ami';

figure(4);
print -depsc 'fig_surrss_garch11_d2';
figure(5);
print -depsc 'fig_surrss_garch11_sampen';
figure(6);
print -depsc 'fig_surrss_garch11_ami';

figure(7);
print -depsc 'fig_surrss_logmap_d2';
figure(8);
print -depsc 'fig_surrss_logmap_sampen';
figure(9);
print -depsc 'fig_surrss_logmap_ami';


% % % 
% % % Calculando D2 para sub-rogados... 10% concluido
% % % Calculando D2 para sub-rogados... 20% concluido
% % % Calculando D2 para sub-rogados... 30% concluido
% % % Calculando D2 para sub-rogados... 40% concluido
% % % Calculando D2 para sub-rogados... 50% concluido
% % % Calculando D2 para sub-rogados... 60% concluido
% % % Calculando D2 para sub-rogados... 70% concluido
% % % Calculando D2 para sub-rogados... 80% concluido
% % % Calculando D2 para sub-rogados... 90% concluido
% % % Calculando D2 para sub-rogados... 100% concluido
% % % Calculando D2 para série original.
% % % Calculando SampEn para sub-rogados... 20% concluido
% % % Calculando SampEn para sub-rogados... 40% concluido
% % % Calculando SampEn para sub-rogados... 60% concluido
% % % Calculando SampEn para sub-rogados... 80% concluido
% % % Calculando SampEn para sub-rogados... 100% concluido
% % % Calculando SampEn para série original.
% % % Calculando AMI para sub-rogados... 20% concluido
% % % Calculando AMI para sub-rogados... 40% concluido
% % % Calculando AMI para sub-rogados... 60% concluido
% % % Calculando AMI para sub-rogados... 80% concluido
% % % Calculando AMI para sub-rogados... 100% concluido
% % % Calculando AMI para série original.
% % % PREV(serie)
% % % 
% % % ans =
% % % 
% % %     3.0367
% % % 
% % % Elapsed time is 129.255942 seconds.
% % % Calculando D2 para sub-rogados... 10% concluido
% % % Calculando D2 para sub-rogados... 20% concluido
% % % Calculando D2 para sub-rogados... 30% concluido
% % % Calculando D2 para sub-rogados... 40% concluido
% % % Calculando D2 para sub-rogados... 50% concluido
% % % Calculando D2 para sub-rogados... 60% concluido
% % % Calculando D2 para sub-rogados... 70% concluido
% % % Calculando D2 para sub-rogados... 80% concluido
% % % Calculando D2 para sub-rogados... 90% concluido
% % % Calculando D2 para sub-rogados... 100% concluido
% % % Calculando D2 para série original.
% % % Calculando SampEn para sub-rogados... 20% concluido
% % % Calculando SampEn para sub-rogados... 40% concluido
% % % Calculando SampEn para sub-rogados... 60% concluido
% % % Calculando SampEn para sub-rogados... 80% concluido
% % % Calculando SampEn para sub-rogados... 100% concluido
% % % Calculando SampEn para série original.
% % % Calculando AMI para sub-rogados... 20% concluido
% % % Calculando AMI para sub-rogados... 40% concluido
% % % Calculando AMI para sub-rogados... 60% concluido
% % % Calculando AMI para sub-rogados... 80% concluido
% % % Calculando AMI para sub-rogados... 100% concluido
% % % Calculando AMI para série original.
% % % PREV(serie)
% % % 
% % % ans =
% % % 
% % %     5.4050
% % % 
% % % Elapsed time is 130.150174 seconds.
% % % Calculando D2 para sub-rogados... 10% concluido
% % % Calculando D2 para sub-rogados... 20% concluido
% % % Calculando D2 para sub-rogados... 30% concluido
% % % Calculando D2 para sub-rogados... 40% concluido
% % % Calculando D2 para sub-rogados... 50% concluido
% % % Calculando D2 para sub-rogados... 60% concluido
% % % Calculando D2 para sub-rogados... 70% concluido
% % % Calculando D2 para sub-rogados... 80% concluido
% % % Calculando D2 para sub-rogados... 90% concluido
% % % Calculando D2 para sub-rogados... 100% concluido
% % % Calculando D2 para série original.
% % % Calculando SampEn para sub-rogados... 20% concluido
% % % Calculando SampEn para sub-rogados... 40% concluido
% % % Calculando SampEn para sub-rogados... 60% concluido
% % % Calculando SampEn para sub-rogados... 80% concluido
% % % Calculando SampEn para sub-rogados... 100% concluido
% % % Calculando SampEn para série original.
% % % Calculando AMI para sub-rogados... 20% concluido
% % % Calculando AMI para sub-rogados... 40% concluido
% % % Calculando AMI para sub-rogados... 60% concluido
% % % Calculando AMI para sub-rogados... 80% concluido
% % % Calculando AMI para sub-rogados... 100% concluido
% % % Calculando AMI para série original.
% % % PREV(serie)
% % % 
% % % ans =
% % % 
% % %    83.2450
% % % 
% % % Elapsed time is 337.496954 seconds.