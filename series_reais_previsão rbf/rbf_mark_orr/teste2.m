close all;
clear all;
clc;

%Previsão RBF com as séries reais

%Modelagem GARCH e previsão RBF com seus resíduos

carrega_series;


series = {rdjia rsp500 ribov rpeto rpeth rpetl rpetc};
%Strings para o nome das figuras
series_str = {'djia' 'sp500' 'ibov' 'peto' 'peth' 'petl' 'petc'};

Nval = 0.15; %'Porcentagem' dos dados destinada a validação do modelo
Ndelays = 2;
Nsur = 50;

%series = {rdjia(1:500) rsp500(1:500)};

tic
for i = 1:size(series,2)
    disp(series_str{i});
    serie = series{i};

    
%     %Estima modelo garch
%     spec = garchset();
%     %spec.Comment
%     [Coeff,Errors,LLF,Innovations,Sigmas,Summary] = garchfit(spec,serie);
%     
%      
%     %Calcula série passada por filtro GARCH estimado
%     serie = (Innovations./Sigmas);

    
    disp('Modelagem RBF...');
    [xtr,ydtr,xval,ydval] = preparaDados(serie,Ndelays,Nval);
    %Adapta a saída da função acima para as funções rbf de Mark Orr
    %Limita dados de validação a 500 amostras
    xtr = xtr(end-500:end,:)';
    xval = xval(1:500,:)';
    ydtr = ydtr(end-500:end);
    ydval = ydval(1:500);
    
    ydval = (ydval>=0)*2 - 1;
    ydtr = (ydtr>=0)*2 - 1;
    
    [c,r,w,info] = rbf_fs_2(xtr,ydtr);
    
    %Validação
    Ht = rbf_dm(xval,c,r,info.dmc);
    yval = Ht * w;
    
    
    e_val = calculaErros(yval,ydval);
    resultados(i).e_val = e_val;
    
end
toc

clear r;
for i = 1:7
    r(i) = resultados(i).e_val.pb;
end
r'

sum(r)

%normal 
% r =
% 
%    49.2000
%    49.8000
%    52.2000
%    48.4000
%    56.8000
%    53.4000
%    49.4000
%com classes y>0 = 1 e y<0 = -1
%    50.6000
%    52.8000
%    47.6000
%    48.6000
%    56.6000
%    57.0000
%    48.6000
% 

% normal se garch
%    51.6000
%    50.2000
%    53.8000
%    50.2000
%    49.8000
%    50.6000
%    48.6000
%com classes y>0 = 1 e y<0 = -1 e sem garch
% na média, esse foi o melhor resultado
%    50.6000
%    52.2000
%    56.6000
%    47.6000
%    56.8000
%    53.2000
%    46.8000

