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


algoritmo = 'PPS';%Algoritmo utilizado

series = {rdjia rsp500 ribov rpeto rpeth rpetl rpetc};
%Strings para o nome das figuras
series_str = {'djia' 'sp500' 'ibov' 'peto' 'peth' 'petl' 'petc'};
strfig = 'fig_surrPPS_';


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

% %PREV
% djia 77.5802
% sp500 28.5761
% ibov 18.6901
% peto 27.0557
% peth 20.3825
% petl 20.4725
% petc 14.8212

% % % djia
% % % Gerando parâmetro rho para sub-rogados...
% % % WARNING: too much data to handle in findrho3 ... truncating
% % % 
% % % rho =
% % % 
% % %     0.0011
% % % 
% % % Gerando sub-rogados...
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
% % %     2.2607
% % % 
% % % Elapsed time is 5506.545274 seconds.
% % % sp500
% % % Gerando parâmetro rho para sub-rogados...
% % % WARNING: too much data to handle in findrho3 ... truncating
% % % 
% % % rho =
% % % 
% % %     0.0011
% % % 
% % % Gerando sub-rogados...
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
% % %     0.0873
% % % 
% % % Elapsed time is 1456.810426 seconds.
% % % ibov
% % % Gerando parâmetro rho para sub-rogados...
% % % WARNING: too much data to handle in findrho3 ... truncating
% % % 
% % % rho =
% % % 
% % %     0.0027
% % % 
% % % Gerando sub-rogados...
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
% % %     1.7983
% % % 
% % % Elapsed time is 737.881916 seconds.
% % % peto
% % % Gerando parâmetro rho para sub-rogados...
% % % 
% % % rho =
% % % 
% % %     0.0040
% % % 
% % % Gerando sub-rogados...
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
% % %     0.7152
% % % 
% % % Elapsed time is 208.648694 seconds.
% % % peth
% % % Gerando parâmetro rho para sub-rogados...
% % % 
% % % rho =
% % % 
% % %     0.0034
% % % 
% % % Gerando sub-rogados...
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
% % %     0.6240
% % % 
% % % Elapsed time is 211.141472 seconds.
% % % petl
% % % Gerando parâmetro rho para sub-rogados...
% % % 
% % % rho =
% % % 
% % %     0.0036
% % % 
% % % Gerando sub-rogados...
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
% % %     0.0540
% % % 
% % % Elapsed time is 198.452630 seconds.
% % % petc
% % % Gerando parâmetro rho para sub-rogados...
% % % 
% % % rho =
% % % 
% % %     0.0038
% % % 
% % % Gerando sub-rogados...
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
% % %     0.3353
% % % 
% % % Elapsed time is 205.317562 seconds.






%%%%rho 0.5
% % % djia
% % % Gerando parâmetro rho para sub-rogados...
% % % WARNING: too much data to handle in findrho3 ... truncating
% % % 
% % % rho =
% % % 
% % %   9.0654e-004
% % % 
% % % Gerando sub-rogados...
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
% % %     1.3623
% % % 
% % % Elapsed time is 7700.450937 seconds.
% % % sp500
% % % Gerando parâmetro rho para sub-rogados...
% % % WARNING: too much data to handle in findrho3 ... truncating
% % % 
% % % rho =
% % % 
% % %   9.3085e-004
% % % 
% % % Gerando sub-rogados...
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
% % %     0.0722
% % % 
% % % Elapsed time is 2330.482950 seconds.
% % % ibov
% % % Gerando parâmetro rho para sub-rogados...
% % % WARNING: too much data to handle in findrho3 ... truncating
% % % 
% % % rho =
% % % 
% % %     0.0023
% % % 
% % % Gerando sub-rogados...
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
% % %     0.7216
% % % 
% % % Elapsed time is 1180.774035 seconds.
% % % peto
% % % Gerando parâmetro rho para sub-rogados...
% % % 
% % % rho =
% % % 
% % %     0.0034
% % % 
% % % Gerando sub-rogados...
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
% % %     1.0911
% % % 
% % % Elapsed time is 328.632982 seconds.
% % % peth
% % % Gerando parâmetro rho para sub-rogados...
% % % 
% % % rho =
% % % 
% % %     0.0029
% % % 
% % % Gerando sub-rogados...
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
% % %   6.5508e-004
% % % 
% % % Elapsed time is 321.427045 seconds.
% % % petl
% % % Gerando parâmetro rho para sub-rogados...
% % % 
% % % rho =
% % % 
% % %     0.0031
% % % 
% % % Gerando sub-rogados...
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
% % %     0.3246
% % % 
% % % Elapsed time is 362.512128 seconds.
% % % petc
% % % Gerando parâmetro rho para sub-rogados...
% % % 
% % % rho =
% % % 
% % %     0.0033
% % % 
% % % Gerando sub-rogados...
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
% % %     0.3948
% % % 
% % % Elapsed time is 360.478016 seconds.