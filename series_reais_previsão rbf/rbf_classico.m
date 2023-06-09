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

% % % tic
% % % for s = 1:size(series,2)
% % %     disp(series_str{s});
% % %     serie = series{s};
% % %     %serie = serie(1:200);
% % %         
% % %     for Ndelays = 1:10%N�mero de atrasos (AR) a serem considerados para a cria��o do vetor de entrada TDNN
% % %         
% % %         
% % %         [xtr,ydtr,xval,ydval,xtest,ydtest] = preparaDados(serie,Ndelays,Nval,Ntest);
% % % 
% % %         
% % %         for Nneuronios = 1:30
% % %             [s Ndelays Nneuronios]
% % %             tic
% % %             modelo = estimaModeloRBF(xtr,ydtr,Nneuronios);
% % %             
% % %             clear yval;
% % %             for t = 1:length(ydval)
% % %                 yval(t,:) = previsaoRBF(modelo,xval(t,:));
% % %             end
% % %             e = calculaErros(yval,ydval);
% % %             resultados(s,Ndelays,Nneuronios).e1 = e;
% % %             
% % % 
% % %             toc
% % %         end
% % %     end
% % %     toc
% % % end

% % % % % save resultados.mat

load('resultados.mat');

for i = 1:size(resultados,1)
    clear e_rmse e_pb e_gmrae;
    for j = 1:size(resultados,2)
        for k = 1:size(resultados,3)
            e_rmse(j,k) = resultados(i,j,k).e1.rmse;
            e_pb(j,k) = resultados(i,j,k).e1.pb;
            e_gmrae(j,k) = resultados(i,j,k).e1.gmrae;
        end
    end
    
    
    figure;
    surf(e_rmse);
    colormap(gray)
    shading interp
    %lighting gouraud
%     %surf(e_gmrae);
%     %surf(e_pb);
    xlabel('Qtd. Neuronios','fontsize',14);
    ylabel('Qtd. Atrasos','fontsize',14);
    zlabel('RMSE','fontsize',14);
    grid on;
    str = strcat('fig_surf_rbf_',series_str{i});
    print('-depsc',str);
%     figure;
%     plot(e_rmse);
%     %plot(e_pb);
%     xlabel('Qtd. Atrasos');
%     ylabel('RMSE');
    [C,x] = min(e_rmse);
    [C,y] = min(C);
    x = x(y);
    melhor_delay_neuronio(i,:) = [x y];
    melhor_desempenho(i) = C;
end

melhor_delay_neuronio


for s = 1:size(series,2)
    disp(series_str{s});
    serie = series{s};
    
    Ndelays = melhor_delay_neuronio(s,1);
    Nneuronios = melhor_delay_neuronio(s,2);
    
    [xtr,ydtr,xval,ydval,xtest,ydtest] = preparaDados(serie,Ndelays,Nval,Ntest);

    
    
%     %Transforma o problema em classifica��o
%     ydval = (ydval>=0)*2 - 1;
%     ydtr = (ydtr>=0)*2 - 1;
%     ydtest = (ydtest>=0)*2 - 1;
    
    
    %Concatena os dados de treinamento e valida��o
%    xtr2 = [xtr; xval];
%    ydtr2 = [ydtr; ydval];
    xtr2 = [xval];
    ydtr2 = [ydval];
%    xtr2 = [xtr];
%    ydtr2 = [ydtr];
    
    
    %xtr2 � definido logo acima. � diferente de xtr!!!!
    modelo = estimaModeloRBF(xtr2,ydtr2,Nneuronios);
    
    clear ytest;
    for t = 1:length(ydtest)
        ytest(t,:) = previsaoRBF(modelo,xtest(t,:));
    end
    %Calcula resultado no ytr2 para verificar que seus residuos
    %sao brancos
    clear ytr2;
    for t = 1:length(ydtr2)
        ytr2(t,:) = previsaoRBF(modelo,xtr2(t,:));
    end
    
    e = calculaErros(ytest,ydtest);
    erros(s,:) = [e.rmse e.u2 e.pb e.gmrae e.direcao];
   
    %Comparacao BDS antes e depois da modelagem
    %calculo do w2 antes da modelagem (nao se faz o pre porque demora e 
    %j� est� calculado em outra rotina)
    erro_rbf = ydtest - ytest;
    [estrutura, prev] = analiseBDS(serie,0);
    w2_serie(s) = estrutura.w_serie;
    %BDS com surrogate 0,... gerando w2 e prev
    [estrutura, prev] = analiseBDS(erro_rbf,50);
    w2_erro(s) = estrutura.w_serie;
    prev_erro(s) = prev;
    %Os residuos de treinamento s�o brancos?
    erro_tr2 = ydtr2 - ytr2;
    [estrutura, prev] = analiseBDS(erro_tr2,50);
    w2_erro_tr2(s) = estrutura.w_serie;
    prev_erro_tr2(s) = prev;
    
    %Estima modelo garch dos res�duos do modelo rbf
    spec = garchset();
    spec.Comment
    [Coeff,Errors,LLF,Innovations,Sigmas,Summary] = garchfit(spec,erro_rbf);
    %Calcula s�rie passada por filtro GARCH estimado
    residuo_filtrado = (Innovations./Sigmas);
    
    [estrutura, prev] = analiseBDS(residuo_filtrado,50);
    w2_erro_filtrado(s) = estrutura.w_serie;
    prev_erro_filtrado(s) = prev;


    %Estima modelo garch dos res�duos DE TREINAMENTO!!! do modelo rbf
    spec = garchset();
    spec.Comment
    [Coeff,Errors,LLF,Innovations,Sigmas,Summary] = garchfit(spec,erro_tr2);
    %Calcula s�rie passada por filtro GARCH estimado
    residuo_filtrado = (Innovations./Sigmas);
    
    [estrutura, prev] = analiseBDS(residuo_filtrado,50);
    w2_erro_tr2_filtrado(s) = estrutura.w_serie;
    prev_erro_tr2_filtrado(s) = prev;


end

%Normal  PB     DIR
%tr      341.33 358.63
%tr+val  339.53 357.91
%val     344.89 366.24

%y � +1 ou -1
%        DIR
%tr      352.23
%tr+val  352.88
%val     358.82


%erros
matrix2table(erros)

sum(erros)


%os erros ainda s�o heterosced�sticos???

w = [w2_serie' w2_erro_tr2' w2_erro_tr2_filtrado' w2_erro' w2_erro_filtrado']
matrix2table(w)



p = [prev_erro_tr2' prev_erro_tr2_filtrado' prev_erro' prev_erro_filtrado']
matrix2table(p)

%Erro RMSE da valida��o cruzada
melhor_desempenho'



