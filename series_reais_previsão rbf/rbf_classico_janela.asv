close all;
clear all;
clc;

%Faz a previsão trenando a rede a cada iteração com o novo dado. No final
%são calculados os erros em uma janela de dadso cujo último elemento
%coincide com o último elemento do BDS calculado em janela

% carrega_series;
% 
% rand('state',0);
% randn('state',0);
% 
% series = {rdjia rsp500 ribov rpeto rpeth rpetl rpetc};
% series_str = {'djia' 'sp500' 'ibov' 'peto' 'peth' 'petl' 'petc'};
% 
% 
% Nval = 0.15;
% Ntest = 0.15;
% 
% 
% load('resultados.mat');
% 
% for i = 1:size(resultados,1)
%     clear e_rmse e_pb e_gmrae;
%     for j = 1:size(resultados,2)
%         for k = 1:size(resultados,3)
%             e_rmse(j,k) = resultados(i,j,k).e1.rmse;
%             e_pb(j,k) = resultados(i,j,k).e1.pb;
%             e_gmrae(j,k) = resultados(i,j,k).e1.gmrae;
%         end
%     end
%     
%     
%     [C,x] = min(e_rmse);
%     [C,y] = min(C);
%     x = x(y);
%     melhor_delay_neuronio(i,:) = [x y];
%     melhor_desempenho(i) = C;
% end
% 
% melhor_delay_neuronio
% 
% 
% for s = 1:size(series,2)
%     disp(series_str{s});
%     serie = series{s};
%     
%     %serie = serie(1:522);
%     
%     Ndelays = melhor_delay_neuronio(s,1);
%     Nneuronios = melhor_delay_neuronio(s,2);
%     Ntreinamento = 500;
%         
%     [x,yd] = preparaDados(serie,Ndelays);
% 
%     xtr = x(1:Ntreinamento,:);
%     ydtr = yd(1:Ntreinamento);
%     xval = x(Ntreinamento+1:end,:);
%     ydval = yd(Ntreinamento+1:end);
%     
%     %Treina a rede com dados de treinamento
%     modelo = estimaModeloRBF(xtr,ydtr,Nneuronios);
% 
%     %Valida o resultado do treinamento
%     clear yval;
%     tic
%     for t = 1:length(ydval)
%         yval(t,:) = previsaoRBF(modelo,xval(t,:));
%         %Treina a rede novamente, com dados antigos de validação
%         xtr = [xtr(2:end,:); xval(t,:)];
%         ydtr = [ydtr(2:end); ydval(t)];%
%         modelo = estimaModeloRBF(xtr,ydtr,Nneuronios);
%         
%         if mod(t,50)==0
%             100*t/length(ydval)
%             toc
%         end
%     end
%     
%     yd_serie{s} = ydval;
%     y_serie{s} = yval;
% 
% end


load('res_janela_previsao.mat');

% % %Confere o ponto de coincidência entre a série e sua janela
% % for s = 1:size(series,2)
% % 
% %     %Carrega série
% %     disp(series_str{s});
% %     serie = series{s};    
% %     Ndelays = melhor_delay_neuronio(s,1);
% %     
% %     %Para todos os elementos da série
% %     for t = 1:length(yd_serie{s})
% %         %Primeira observação da janela == serie(t+Ntreinamento+Ndelays)
% %         if ~isequal(serie(t+Ntreinamento+Ndelays),yd_serie{s}(t))
% %             disp('diferente');
% %         end
% %     end
% %     isequal(length(yd_serie{s})+Ntreinamento+Ndelays,length(serie))
% % end

%Calcula erro da janela
%A janela deve terminar no mesmo elemento
for s = 1:size(series,2)

    %Carrega série
    disp(series_str{s});
    serie = series{s};    
    Ndelays = melhor_delay_neuronio(s,1);
    
    % A primeira janela é do elementos serie(1:1000)
    % A segunda é de serie(2:1001), etc.
    % Isso equivale aos elementos yd_serie{s}(t:(t+Njanela_serie-1) -Njanela - Ndelays)
    % onde t varia de 1:length(yd_serie{s})+Njanela+Ndelays+1-Njanela_serie
    Njanela = 500;
    Njanela_serie = 1000;
    %Para todos os elementos da série
    for t = 1:length(yd_serie{s}) + Njanela + Ndelays + 1 - Njanela_serie
        %Calcula intervalo da janela
        primeiro_elemento = t;
        ultimo_elemento = (t+Njanela_serie-1) -Njanela - Ndelays;
        %Constroi a janela
        yd = yd_serie{s}(primeiro_elemento:ultimo_elemento);
        y = y_serie{s}(primeiro_elemento:ultimo_elemento);
        
        %Calcula o erro nessa janela de dados
        e{s}(t) = calculaErros(y,yd);
    end
        
end

%%%%%%%%%save('erros_janela.mat','e');
