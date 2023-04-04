close all;
clear all;
clc;

%Teste BDS com as s�ries reais

%Modelagem GARCH e teste BDS com seus res�duos

% carrega_series;
% 
% Nsur = 0;
% 
% series = {rdjia rsp500 ribov rpeto rpeth rpetl rpetc};
% %Strings para o nome das figuras
% series_str = {'djia' 'sp500' 'ibov' 'peto' 'peth' 'petl' 'petc'};
% 
% 
% series = {rpetc};
% 
% c1 = clock;
% 
% 
% for i = 1:size(series,2)
%     disp(series_str{i});
%     serie_i = series{i};
% 
%     Nj = 1000;
%     for j = Nj:length(serie_i)
%         j
%         %Realiza o 'janelamento da s�rie'
%         
%         serie = serie_i(j-Nj+1:j);
%         
%     %Estima modelo garch
%     spec = garchset();
%     [Coeff,Errors,LLF,Innovations,Sigmas,Summary] = garchfit(spec,serie);
%     
%     %Calcula s�rie passada por filtro GARCH estimado
%     serie = (Innovations./Sigmas);
% 
%     
%     
%     [estrutura, prev] = analiseBDS(serie,Nsur);
%     w(i,j-Nj+1) = estrutura.w_serie;
%     
% 
%     end
% end
% 
% c2 = clock;
% etime(c2,c1)
% 
% plot(w');
% % % % save('janela_djia.mat')



% A primeira janela � do elementos 1:1000
% A segunda � de 2:1001, etc.
load('janela_djia.mat')
w_serie{1} = w;
clearvars -except w_serie;
load('janela_sp500.mat')
w_serie{2} = w;
clearvars -except w_serie;
load('janela_ibov.mat')
w_serie{3} = w;
clearvars -except w_serie;
load('janela_peto.mat')
w_serie{4} = w;
clearvars -except w_serie;
load('janela_pethl.mat')
w_serie{5} = w(1,:);
w_serie{6} = w(2,:);
clearvars -except w_serie;
load('janela_petc.mat');
w_serie{7} = w;
clearvars -except w_serie;

%%%%%%%save('bds_resGARCH_janela.mat','w_serie');





