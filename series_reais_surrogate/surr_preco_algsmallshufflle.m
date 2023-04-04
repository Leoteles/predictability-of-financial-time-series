close all;
clear all;
clc;

carrega_series;

%Parâmetros da rotina de analise de dados sub-rogados
Nsur = 50;%Número de surrogates
msg = 1;%Mostra mensagens
fig = 1;%Mostra figuras
est = 'ami';%Mostra todas as estatisticas

rand('state',0);
randn('state',0);


algoritmo = 'ss';%Algoritmo utilizado

series = {djia sp500 ibov peto peth petl petc};
%Strings para o nome das figuras
series_str = {'djia' 'sp500' 'ibov' 'peto' 'peth' 'petl' 'petc'};
strfig = 'fig_preco_ss_';


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



for fig = 1:size(series,2)%Para cada figura da série
    figure(fig);
    str = strcat(strfig,series_str{fig},'_ami');
    print('-depsc',str);
end

% % % 
% % % djia
% % % gerando small-shuffle
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
% % %     9.1218
% % % 
% % % Elapsed time is 80.253206 seconds.
% % % sp500
% % % gerando small-shuffle
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
% % %     6.4320
% % % 
% % % Elapsed time is 43.420572 seconds.
% % % ibov
% % % gerando small-shuffle
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
% % %     6.0857
% % % 
% % % Elapsed time is 30.093436 seconds.
% % % peto
% % % gerando small-shuffle
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
% % %     7.3924
% % % 
% % % Elapsed time is 11.603544 seconds.
% % % peth
% % % gerando small-shuffle
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
% % %     6.9064
% % % 
% % % Elapsed time is 11.557934 seconds.
% % % petl
% % % gerando small-shuffle
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
% % %     6.3815
% % % 
% % % Elapsed time is 11.563745 seconds.
% % % petc
% % % gerando small-shuffle
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
% % %     5.9407
% % % 
% % % Elapsed time is 11.580152 seconds.
