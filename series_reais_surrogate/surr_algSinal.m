close all;
clear all;
clc;

carrega_series;

%Par�metros da rotina de analise de dados sub-rogados
Nsur = 50;%N�mero de surrogates
msg = 1;%Mostra mensagens
fig = 1;%Mostra figuras
est = 'todas';%Mostra todas as estatisticas

rand('state',0);
randn('state',0);


algoritmo = 'sinal';%Algoritmo utilizado

series = {rdjia rsp500 ribov rpeto rpeth rpetl rpetc};
%Strings para o nome das figuras
series_str = {'djia' 'sp500' 'ibov' 'peto' 'peth' 'petl' 'petc'};
strfig = 'fig_sinal_';


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


ser = 1;%Incrementa o vetor dos nomes das s�ries
for fig = 1:3:size(series,2)*3%Para cada figura da s�rie
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


% 
% djia
% Calculando D2 para sub-rogados... 10% concluido
% Calculando D2 para sub-rogados... 20% concluido
% Calculando D2 para sub-rogados... 30% concluido
% Calculando D2 para sub-rogados... 40% concluido
% Calculando D2 para sub-rogados... 50% concluido
% Calculando D2 para sub-rogados... 60% concluido
% Calculando D2 para sub-rogados... 70% concluido
% Calculando D2 para sub-rogados... 80% concluido
% Calculando D2 para sub-rogados... 90% concluido
% Calculando D2 para sub-rogados... 100% concluido
% Calculando D2 para s�rie original.
% Calculando SampEn para sub-rogados... 20% concluido
% Calculando SampEn para sub-rogados... 40% concluido
% Calculando SampEn para sub-rogados... 60% concluido
% Calculando SampEn para sub-rogados... 80% concluido
% Calculando SampEn para sub-rogados... 100% concluido
% Calculando SampEn para s�rie original.
% Calculando AMI para sub-rogados... 20% concluido
% Calculando AMI para sub-rogados... 40% concluido
% Calculando AMI para sub-rogados... 60% concluido
% Calculando AMI para sub-rogados... 80% concluido
% Calculando AMI para sub-rogados... 100% concluido
% Calculando AMI para s�rie original.
% PREV(serie)
% 
% ans =
% 
%     4.3986
% 
% Elapsed time is 2986.919264 seconds.
% sp500
% Calculando D2 para sub-rogados... 10% concluido
% Calculando D2 para sub-rogados... 20% concluido
% Calculando D2 para sub-rogados... 30% concluido
% Calculando D2 para sub-rogados... 40% concluido
% Calculando D2 para sub-rogados... 50% concluido
% Calculando D2 para sub-rogados... 60% concluido
% Calculando D2 para sub-rogados... 70% concluido
% Calculando D2 para sub-rogados... 80% concluido
% Calculando D2 para sub-rogados... 90% concluido
% Calculando D2 para sub-rogados... 100% concluido
% Calculando D2 para s�rie original.
% Calculando SampEn para sub-rogados... 20% concluido
% Calculando SampEn para sub-rogados... 40% concluido
% Calculando SampEn para sub-rogados... 60% concluido
% Calculando SampEn para sub-rogados... 80% concluido
% Calculando SampEn para sub-rogados... 100% concluido
% Calculando SampEn para s�rie original.
% Calculando AMI para sub-rogados... 20% concluido
% Calculando AMI para sub-rogados... 40% concluido
% Calculando AMI para sub-rogados... 60% concluido
% Calculando AMI para sub-rogados... 80% concluido
% Calculando AMI para sub-rogados... 100% concluido
% Calculando AMI para s�rie original.
% PREV(serie)
% 
% ans =
% 
%     1.7623
% 
% Elapsed time is 946.040786 seconds.
% ibov
% Calculando D2 para sub-rogados... 10% concluido
% Calculando D2 para sub-rogados... 20% concluido
% Calculando D2 para sub-rogados... 30% concluido
% Calculando D2 para sub-rogados... 40% concluido
% Calculando D2 para sub-rogados... 50% concluido
% Calculando D2 para sub-rogados... 60% concluido
% Calculando D2 para sub-rogados... 70% concluido
% Calculando D2 para sub-rogados... 80% concluido
% Calculando D2 para sub-rogados... 90% concluido
% Calculando D2 para sub-rogados... 100% concluido
% Calculando D2 para s�rie original.
% Calculando SampEn para sub-rogados... 20% concluido
% Calculando SampEn para sub-rogados... 40% concluido
% Calculando SampEn para sub-rogados... 60% concluido
% Calculando SampEn para sub-rogados... 80% concluido
% Calculando SampEn para sub-rogados... 100% concluido
% Calculando SampEn para s�rie original.
% Calculando AMI para sub-rogados... 20% concluido
% Calculando AMI para sub-rogados... 40% concluido
% Calculando AMI para sub-rogados... 60% concluido
% Calculando AMI para sub-rogados... 80% concluido
% Calculando AMI para sub-rogados... 100% concluido
% Calculando AMI para s�rie original.
% PREV(serie)
% 
% ans =
% 
%     3.9481
% 
% Elapsed time is 525.618706 seconds.
% peto
% Calculando D2 para sub-rogados... 10% concluido
% Calculando D2 para sub-rogados... 20% concluido
% Calculando D2 para sub-rogados... 30% concluido
% Calculando D2 para sub-rogados... 40% concluido
% Calculando D2 para sub-rogados... 50% concluido
% Calculando D2 para sub-rogados... 60% concluido
% Calculando D2 para sub-rogados... 70% concluido
% Calculando D2 para sub-rogados... 80% concluido
% Calculando D2 para sub-rogados... 90% concluido
% Calculando D2 para sub-rogados... 100% concluido
% Calculando D2 para s�rie original.
% Calculando SampEn para sub-rogados... 20% concluido
% Calculando SampEn para sub-rogados... 40% concluido
% Calculando SampEn para sub-rogados... 60% concluido
% Calculando SampEn para sub-rogados... 80% concluido
% Calculando SampEn para sub-rogados... 100% concluido
% Calculando SampEn para s�rie original.
% Calculando AMI para sub-rogados... 20% concluido
% Calculando AMI para sub-rogados... 40% concluido
% Calculando AMI para sub-rogados... 60% concluido
% Calculando AMI para sub-rogados... 80% concluido
% Calculando AMI para sub-rogados... 100% concluido
% Calculando AMI para s�rie original.
% PREV(serie)
% 
% ans =
% 
%     0.2078
% 
% Elapsed time is 204.202196 seconds.
% peth
% Calculando D2 para sub-rogados... 10% concluido
% Calculando D2 para sub-rogados... 20% concluido
% Calculando D2 para sub-rogados... 30% concluido
% Calculando D2 para sub-rogados... 40% concluido
% Calculando D2 para sub-rogados... 50% concluido
% Calculando D2 para sub-rogados... 60% concluido
% Calculando D2 para sub-rogados... 70% concluido
% Calculando D2 para sub-rogados... 80% concluido
% Calculando D2 para sub-rogados... 90% concluido
% Calculando D2 para sub-rogados... 100% concluido
% Calculando D2 para s�rie original.
% Calculando SampEn para sub-rogados... 20% concluido
% Calculando SampEn para sub-rogados... 40% concluido
% Calculando SampEn para sub-rogados... 60% concluido
% Calculando SampEn para sub-rogados... 80% concluido
% Calculando SampEn para sub-rogados... 100% concluido
% Calculando SampEn para s�rie original.
% Calculando AMI para sub-rogados... 20% concluido
% Calculando AMI para sub-rogados... 40% concluido
% Calculando AMI para sub-rogados... 60% concluido
% Calculando AMI para sub-rogados... 80% concluido
% Calculando AMI para sub-rogados... 100% concluido
% Calculando AMI para s�rie original.
% PREV(serie)
% 
% ans =
% 
%     1.3178
% 
% Elapsed time is 222.214912 seconds.
% petl
% Calculando D2 para sub-rogados... 10% concluido
% Calculando D2 para sub-rogados... 20% concluido
% Calculando D2 para sub-rogados... 30% concluido
% Calculando D2 para sub-rogados... 40% concluido
% Calculando D2 para sub-rogados... 50% concluido
% Calculando D2 para sub-rogados... 60% concluido
% Calculando D2 para sub-rogados... 70% concluido
% Calculando D2 para sub-rogados... 80% concluido
% Calculando D2 para sub-rogados... 90% concluido
% Calculando D2 para sub-rogados... 100% concluido
% Calculando D2 para s�rie original.
% Calculando SampEn para sub-rogados... 20% concluido
% Calculando SampEn para sub-rogados... 40% concluido
% Calculando SampEn para sub-rogados... 60% concluido
% Calculando SampEn para sub-rogados... 80% concluido
% Calculando SampEn para sub-rogados... 100% concluido
% Calculando SampEn para s�rie original.
% Calculando AMI para sub-rogados... 20% concluido
% Calculando AMI para sub-rogados... 40% concluido
% Calculando AMI para sub-rogados... 60% concluido
% Calculando AMI para sub-rogados... 80% concluido
% Calculando AMI para sub-rogados... 100% concluido
% Calculando AMI para s�rie original.
% PREV(serie)
% 
% ans =
% 
%     0.7192
% 
% Elapsed time is 256.607463 seconds.
% petc
% Calculando D2 para sub-rogados... 10% concluido
% Calculando D2 para sub-rogados... 20% concluido
% Calculando D2 para sub-rogados... 30% concluido
% Calculando D2 para sub-rogados... 40% concluido
% Calculando D2 para sub-rogados... 50% concluido
% Calculando D2 para sub-rogados... 60% concluido
% Calculando D2 para sub-rogados... 70% concluido
% Calculando D2 para sub-rogados... 80% concluido
% Calculando D2 para sub-rogados... 90% concluido
% Calculando D2 para sub-rogados... 100% concluido
% Calculando D2 para s�rie original.
% Calculando SampEn para sub-rogados... 20% concluido
% Calculando SampEn para sub-rogados... 40% concluido
% Calculando SampEn para sub-rogados... 60% concluido
% Calculando SampEn para sub-rogados... 80% concluido
% Calculando SampEn para sub-rogados... 100% concluido
% Calculando SampEn para s�rie original.
% Calculando AMI para sub-rogados... 20% concluido
% Calculando AMI para sub-rogados... 40% concluido
% Calculando AMI para sub-rogados... 60% concluido
% Calculando AMI para sub-rogados... 80% concluido
% Calculando AMI para sub-rogados... 100% concluido
% Calculando AMI para s�rie original.
% PREV(serie)
% 
% ans =
% 
%     0.1214
% 
% Elapsed time is 256.130702 seconds.