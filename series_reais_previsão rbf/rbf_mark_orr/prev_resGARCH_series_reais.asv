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

    %BDS antes da modelagem GARCH
    [estrutura, prev] = analiseBDS(serie,Nsur);
    resultados(i).bds_serie = estrutura.w_serie;
    resultados(i).prev_serie = prev;
    clear estrutura;
    
    
    %Estima modelo garch
    spec = garchset();
    %spec.Comment
    [Coeff,Errors,LLF,Innovations,Sigmas,Summary] = garchfit(spec,serie);
    
     
    %Calcula série passada por filtro GARCH estimado
    serie = (Innovations./Sigmas);

    %BDS depois da modelagem GARCH
    [estrutura, prev] = analiseBDS(serie,Nsur);
    resultados(i).bds_resGARCH = estrutura.w_serie;
    resultados(i).prev_resGARCH = prev;
    clear estrutura;
    
    disp('Modelagem RBF...');
    [xtr,ydtr,xval,ydval] = preparaDados(serie,Ndelays,Nval);
    %Adapta a saída da função acima para as funções fbr de Mark Orr
    %Limita dados de validação a 500 amostras
    xtr = xtr';
    xval = xval(1:500,:)';
    ydtr = ydtr;
    ydval = ydval(1:500);
    x = [xtr xval];
    yd = [ydtr; ydval];
        
    [c,r,w,info] = rbf_fs_2(xtr,ydtr);
    
    %Validação
    Ht = rbf_dm(xval,c,r,info.dmc);
    yval = Ht * w;
    
    %Simulação com toda a série, para cálculo da est. BDS;
    Ht = rbf_dm(x,c,r,info.dmc);
    y = Ht * w;
    
    e_val = calculaErros(yval,ydval);
    resultados(i).e_val = e_val;
    e_y = calculaErros(y,yd);
    resultados(i).e_y = e_y;
    
    %BDS dos residuos do modelo RBF (dados de validação)
    [estrutura, prev] = analiseBDS(e_val.erros,Nsur);
    resultados(i).bds_resRBF_val = estrutura.w_serie;
    resultados(i).prev_resRBF_val = prev;
    clear estrutura;
    
    %BDS dos residuos do modelo RBF (todos os dados)
    [estrutura, prev] = analiseBDS(e_y.erros,Nsur);
    resultados(i).bds_resRBF_y = estrutura.w_serie;
    resultados(i).prev_resRBF_y = prev;
    clear estrutura;
end
toc

save('tudo_prev_resGARCH.mat');


for i = 1:28
    figure(i);
    str = sprintf('prevresgarch_%d',i)
    print('-depsc',str);
end
    