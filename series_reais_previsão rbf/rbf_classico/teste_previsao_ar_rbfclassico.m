close all;
clear all;
clc;

% serie = serie(:);
% carrega_series;
% 
% serie = ar1;
% serie = logistica;
% serie = rpetc;

load('rpetc_resGARCH11.mat');


Ndelays = 20;%Número de atrasos (AR) a serem considerados para a criação do vetor de entrada TDNN
Nneuronios = 50;%Numero de centros da camada escondida RBF
Ntr = 0.5;%Porcentagem dos dados disponíveis para treinamento



%Gera vetores de entrada e saída
[yd,x] = gera_regressores_AR(serie, Ndelays);

%Último valor da série de treinamento
fim_tr = floor(0.8*length(yd));

%Dados de treinamento
xtr = x(1:fim_tr,:);
ydtr = yd(1:fim_tr);
%Dados de Validação
xval = x(fim_tr+1:end,:);
ydval = yd(fim_tr+1:end);

%Treinamento do modelo linear AR
modeloAR = estimaModeloAR(ydtr,Ndelays);
% 
%Treinamento do modelo RBF
modeloRBF = estimaModeloRBF(xtr,ydtr,Nneuronios);


%Erro de validação
for i = 1:length(ydval)
    yval_lin(i,:) = previsaoAR(modeloAR,xval(i,:));
    yval_rbf(i,:) = previsaoRBF(modeloRBF,xval(i,:));   
end

erro_lin = ydval - yval_lin;
erro_rw = ydval - 0;
erro_rbf = ydval - yval_rbf;

%Calculo do erro percent better
%É a porcentagem de vezes em que a previsão foi melhor que a do RW
pb_lin = 100 * sum((abs(erro_lin)-abs(erro_rw))<0) / length(ydval)
pb_rbf = 100 * sum((abs(erro_rbf)-abs(erro_rw))<0) / length(ydval)

%Acertou a direção
dir_lin = 100 * (sum((yval_lin>=0)&(ydval>=0))+sum((yval_lin<0)&(ydval<0))) / length(ydval)
dir_rbf = 100 * (sum((yval_rbf>=0)&(ydval>=0))+sum((yval_rbf<0)&(ydval<0))) / length(ydval)

S = std(yval_lin);
total_lin = sum(yval_lin>=S) + sum(yval_lin<-S);
dir_std_lin = 100 * (sum((yval_lin>=S)&(ydval>=0))+sum((yval_lin<-S)&(ydval<0))) / total_lin
S = std(yval_rbf);
total_rbf = sum(yval_rbf>=S) + sum(yval_rbf<-S);
dir_std_rbf = 100 * (sum((yval_rbf>=S)&(ydval>=0))+sum((yval_rbf<-S)&(ydval<0))) / total_rbf


% % % %Se MRAE < 1, previsão melhor do que RW
% % % MRAE_lin = mean(abs(erro_lin) ./ abs(erro_rw))
% % % MRAE_rbf = mean(abs(erro_rbf) ./ abs(erro_rw))
% % % 
% % % MdRAE_lin = median(abs(erro_lin) ./ abs(erro_rw))
% % % MdRAE_rbf = median(abs(erro_rbf) ./ abs(erro_rw))
% % % 
% % % GMRAE_lin = geomean(abs(erro_lin) ./ abs(erro_rw))
% % % GMRAE_rbf = geomean(abs(erro_rbf) ./ abs(erro_rw))
% % % 
% % % RMSE_lin = sqrt(mean(erro_lin.^2))
% % % RMSE_rbf = sqrt(mean(erro_rbf.^2))
% % % RMSE_rw = sqrt(mean(erro_rw.^2))
% % % 
% % % U2_lin = RMSE_rbf/RMSE_rw
% % % U2_rbf = RMSE_lin/RMSE_rw

% % % 
% % % plot(ydval,'.-k');
% % % hold on;
% % % plot(yval_lin,'.-b');
% % % plot(yval_rbf,'.-r');
% % % hold off;
% % % grid minor;
% % % legend('série validação','modelo AR','modelo RBF');


%Comparacao BDS antes e depois da modelagem
[estrutura, prev] = analiseBDS(serie,0);
estrutura.w_serie
[estrutura, prev] = analiseBDS(erro_lin,0);
estrutura.w_serie
[estrutura, prev] = analiseBDS(erro_rbf,0);
estrutura.w_serie

