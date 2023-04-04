clear all;
close all;
clc;
randn('state',0);

%Cria-se um vetor de N posições representando uma estrutura AR1
N = 10000;
var_e = 0.1;
e = sqrt(var_e)*randn(N,1);
teta = -0.385;
y(1) = 0;
for t = 2:N
    y(t) = teta * y(t-1) + e(t);
end
y = y';%y é, por convenção, vetor coluna

%Dados de treinamento
y_treino = y(2:N/2);%y comeca de k=2 para que existam regressores y(k-1)
psi = y (1:(N/2)-1);%Regressor y(k-1)

%Dados de validação
y_valida = y((N/2)+2:end);%y comeca de k=2 para que existam regressores y(k-1)
y_kmenos1 = y((N/2)+1:end-1);



%Minimos quadrados nos dados de treinamento
teta_mq = inv(psi'*psi)*psi'*y_treino;
qsi = y_treino-psi*teta_mq;%Residuo

%Previsao 1 passo a frente dos dados de validacao
y_est = y_kmenos1*teta_mq;
%Previsao random walk
y_rw = y_kmenos1;

RMSE_estimado = mean(sqrt((y_valida - y_est).^2))
RMSE_rw = mean(sqrt((y_valida - y_rw).^2))

%var_RMSE_estimado = var(sqrt((y_valida - y_est).^2))
%var_RMSE_rw = var(sqrt((y_valida - y_rw).^2))



[a,e] = aryule(y,1)
[a,e] = arcov(y,1)
[a,e] = arburg(y,1)
[a,e] = armcov(y,1)


