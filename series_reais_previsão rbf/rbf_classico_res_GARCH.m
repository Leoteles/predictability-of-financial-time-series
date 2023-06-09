close all;
clear all;
clc;

carrega_series;

rand('state',0);
randn('state',0);

series = {rdjia rsp500 ribov rpeto rpeth rpetl rpetc};
series_str = {'djia' 'sp500' 'ibov' 'peto' 'peth' 'petl' 'petc'};


Nval = 0.15;
Ntest = 0.15;
% 
% tic
% for s = 1:size(series,2)
%     disp(series_str{s});
%     serie = series{s};
%     %serie = serie(1:200);
%         
%     for Ndelays = 1:10%N�mero de atrasos (AR) a serem considerados para a cria��o do vetor de entrada TDNN
%                 
%         %Estima modelo garch
%         spec = garchset();
%         spec.Comment
%         [Coeff,Errors,LLF,Innovations,Sigmas,Summary] = garchfit(spec,serie);
%         %Calcula s�rie passada por filtro GARCH estimado
%         serie = (Innovations./Sigmas);
% 
%         [xtr,ydtr,xval,ydval,xtest,ydtest] = preparaDados(serie,Ndelays,Nval,Ntest);
%         %sum(linspace(4,96,300))
%         
%         for Nneuronios = 1:30
%             [s Ndelays Nneuronios]
%             tic
% 
%             modelo = estimaModeloRBF(xtr,ydtr,Nneuronios);
%             
%             clear yval;
%             for t = 1:length(ydval)
%                 yval(t,:) = previsaoRBF(modelo,xval(t,:));
%             end
%             e = calculaErros(yval,ydval);
%             resultados(s,Ndelays,Nneuronios).e2 = e;
% 
%             toc
%         end
%         save('resultados_res_parcial.mat');
%     end
%     toc
% end
% 
% % % % save resultados_res.mat




load('resultados_res.mat');

for i = 1:size(resultados,1)
    clear e_rmse e_pb e_gmrae;
    for j = 1:size(resultados,2)
        for k = 1:size(resultados,3)
            e_rmse(j,k) = resultados(i,j,k).e2.rmse;
            e_pb(j,k) = resultados(i,j,k).e2.pb;
            e_gmrae(j,k) = resultados(i,j,k).e2.gmrae;
        end
    end

%     figure;
%     
%     surf(e_rmse);
%     colormap(gray)
%     shading interp
%     %lighting gouraud
% %     %surf(e_gmrae);
% %     %surf(e_pb);
%     xlabel('Qtd. Neuronios','fontsize',14);
%     ylabel('Qtd. Atrasos','fontsize',14);
%     zlabel('RMSE','fontsize',14);
%     grid on;
%     str = strcat('fig_surf_rbf_resGARCH_',series_str{i});
%     print('-depsc',str);
% %     figure;
% %     plot(e_rmse);
% %     %plot(e_pb);
% %     xlabel('Qtd. Atrasos');
% %     ylabel('RMSE');
    
    [C,x] = min(e_rmse);
    [C,y] = min(C);
    x = x(y);
    melhor_delay_neuronio(i,:) = [x y];
end

melhor_delay_neuronio

for s = 1:size(series,2)
    disp(series_str{s});
    serie = series{s};
    
    Ndelays = melhor_delay_neuronio(s,1);
    Nneuronios = melhor_delay_neuronio(s,2);
    
    [xtr,ydtr,xval,ydval,xtest,ydtest] = preparaDados(serie,Ndelays,Nval,Ntest);
    
    %Transforma o problema em classifica��o
    ydval = (ydval>=0)*2 - 1;
    ydtr = (ydtr>=0)*2 - 1;
    ydtest = (ydtest>=0)*2 - 1;
    
    
    %Concatena os dados de treinamento e valida��o
%     xtr2 = [xtr; xval];
%     ydtr2 = [ydtr; ydval];
    xtr2 = [xval];
    ydtr2 = [ydval];
%     xtr2 = [xtr];
%     ydtr2 = [ydtr];

    
    modelo = estimaModeloRBF(xtr2,ydtr2,Nneuronios);
    
    clear ytest;
    for t = 1:length(ydtest)
        ytest(t,:) = previsaoRBF(modelo,xtest(t,:));
    end
    e = calculaErros(ytest,ydtest);
    erros(s,:) = [e.rmse e.u2 e.pb e.gmrae  e.direcao];
    
    %Comparacao BDS antes e depois da modelagem
    erro_rbf = ydtest - ytest;
    [estrutura, prev] = analiseBDS(serie,0);
    w2_serie(s) = estrutura.w_serie;
    [estrutura, prev] = analiseBDS(erro_rbf,0);
    w2_erro(s) = estrutura.w_serie;
end

%Normal  PB     DIR
%tr      335.05 351.50
%tr+val  337.94 354.86
%val     338.62 364.05

%y � +1 ou -1
%        DIR
%tr      355.51
%tr+val  359.55
%val     358.96

erros

sum(erros)



close all

