close all;
clear all;
clc;

carrega_series;

%Parâmetros da rotina de analise de dados sub-rogados
Nsur = 50;%Número de surrogates
msg = 1;%Mostra mensagens
fig = 1;%Mostra figuras
est = 'todas';%Mostra todas as estatisticas

rand('state',0);
randn('state',0);


algoritmo = 'ss';%Algoritmo utilizado

series = {rdjia rsp500 ribov rpeto rpeth rpetl rpetc};
%Strings para o nome das figuras
series_str = {'djia' 'sp500' 'ibov' 'peto' 'peth' 'petl' 'petc'};
strfig = 'fig_ss_';


% % series = {rpetl rpetc};
% % series_str = {'petl' 'petc'};


for i = 1:size(series,2)
    disp(series_str{i});
    serie = series{i};
    tic
    [estrutura, prev] = analiseSurrogates(serie,Nsur,algoritmo,est,msg,fig);
    disp('PREV(serie)');prev(1)
    toc
end


ser = 1;%Incrementa o vetor dos nomes das séries
for fig = 1:3:size(series,2)*3%Para cada figura da série
    figure(fig);
    str = strcat(strfig,series_str{ser},'_d2');
    print('-depsc',str);
    figure(fig+1);
    str = strcat(strfig,series_str{ser},'_sampen');
    print('-depsc',str);
    figure(fig+2);
    str = strcat(strfig,series_str{ser},'_ami');
    print('-depsc',str);
    ser = ser + 1;
end
% % % 
% % % djia
% % % gerando small-shuffle
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
% % %     0.2972
% % % 
% % % Elapsed time is 2936.447406 seconds.
% % % sp500
% % % gerando small-shuffle
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
% % %     3.4970
% % % 
% % % Elapsed time is 942.704048 seconds.
% % % ibov
% % % gerando small-shuffle
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
% % %     3.6391
% % % 
% % % Elapsed time is 523.639736 seconds.
% % % peto
% % % gerando small-shuffle
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
% % %     0.4844
% % % 
% % % Elapsed time is 175.696132 seconds.
% % % peth
% % % gerando small-shuffle
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
% % %     1.9818
% % % 
% % % Elapsed time is 180.337759 seconds.
% % % petl
% % % gerando small-shuffle
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
% % %     0.9655
% % % 
% % % Elapsed time is 248.060458 seconds.
% % % petc
% % % gerando small-shuffle
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
% % %     0.3557
% % % 
% % % Elapsed time is 260.712606 seconds.