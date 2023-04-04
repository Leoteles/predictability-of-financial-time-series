%Teste da estimação de uma estrutura AR1 por minimos quadrados classico
%separando-se o vetor em dados de treinamento e dados de validação.
%Testa-se tambem a porcentagem de vezes em que a previsao da estrutura
%acerta a direção da tendência. Ou seja, quando o sinal da previsão é igual
%ao sinal do valor real.

clear all;
close all;
clc;
randn('state',0);

%Cria-se um vetor de N posições representando uma estrutura AR1
N = 10000;
var_e = 1;
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

%Numero de vezes em que se acertou a direcao da tendencia
direcao = 0;
x = 0;
for i = 1:length(y_valida)
    x = x + 1;
    if (y_valida(i)>=0 && y_est(i)>=0 || y_valida(i)<0 && y_est(i)<0)
        direcao = direcao + 1;
        sinal(i) = 1;
    else
        sinal(i) = 0;
    end
end
direcao = 100*direcao/x%Coloca em forma de porcentagem


figure;
plot(e);
title('Vetor inicial');

figure;
plot(y);
title('Processo AR1');

figure;
autocorr(y,[],2)
title('Autocorrelação do processo AR1');

figure;
autocorr(qsi,[],2)%Autocorrelação dos residuos
title('Autocorrelação dos resíduos');

figure;
plot(y_est,'.-r');
hold on;
plot(y_valida,'-b');
legend('estimado','real');
hold off;
grid on;
title('Previsão 1 passo a frente - validação');

