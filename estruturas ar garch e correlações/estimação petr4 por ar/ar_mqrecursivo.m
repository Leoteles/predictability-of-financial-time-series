%Teste da estimação de uma estrutura AR4 por minimos quadrados recursivos
%Testa-se tambem a porcentagem de vezes em que a previsao da estrutura
%acerta a direção da tendência. Ou seja, quando o sinal da previsão é igual
%ao sinal do valor real.

clear all;
close all;
clc;
randn('state',0);

%Cria-se um vetor de N posições representando uma estrutura AR4
N = 1000;
var_e = 1;
e = sqrt(var_e)*randn(N,1);
teta = [-0.3; -0.2; 0.5; -0.1];

t = 1;
y(t)=e(t);
t = 2;
y(t)=teta(1)*y(t-1)+e(t);
t = 3;
y(t)=teta(1)*y(t-1)+teta(2)*y(t-2)+e(t);
t = 4;
y(t)=teta(1)*y(t-1)+teta(2)*y(t-2)+teta(3)*y(t-3)+e(t);
for t = 5:N
    y(t)=teta(1)*y(t-1)+teta(2)*y(t-2)+teta(3)*y(t-3)+teta(4)*y(t-4)+e(t);
end

y = y';%y é, por convenção, vetor coluna


%Série e Regressores
%AR4
n = 4;%AR(n) -> n=4
[y_tr,psi] = gera_regressores_AR(y,n);

teta_mq = inv(psi'*psi)*psi'*y_tr;%mq classico


%Minimos quadrados recursivo nos dados de treinamento
teta_mqr(:,1) = ones(n,1);%Parametros iniciais
P = eye(n);%Matriz de covariancia inicial
for k=2:length(y_tr)

    %Previsao 1 passo a frente(valor previsto no instante k, antes da medição)
    y_est(k) = psi(k,:)*teta_mqr(:,k-1);
    %Previsao random walk
    y_rw(k) = psi(k,1);%psi na coluna 1 é o valor em k-1

    %%inicio%MQR%%%%%%%%%%%%
    psi_k = psi(k,:)';%Para o mqr
    K = ( P*psi_k ) / ( psi_k'*P*psi_k + 1 );
    teta_mqr(:,k) = teta_mqr(:,k-1) + K * (y_tr(k)-psi_k'*teta_mqr(:,k-1));
    P = P - K * psi_k'*P;
    %%fim%MQR%%%%%%%%%%%%%%%
        
end

y_est = y_est';
y_rw = y_rw';

%Raiz do erro quadratico em cada passo
erro_est = sqrt((y_tr - y_est).^2);
erro_rw = sqrt((y_tr - y_rw).^2);

RMSE_estimado = mean(sqrt((y_tr - y_est).^2))
RMSE_rw = mean(sqrt((y_tr - y_rw).^2))

%Numero de vezes em que se acertou a direcao da tendencia
direcao = 0;
x = 0;
for i = 1:length(y_tr)
    x = x+1;
    if (y_tr(i)>=0 && y_est(i)>=0 || y_tr(i)<0 && y_est(i)<0)
        direcao = direcao + 1;
        sinal(i) = 1;
    else
        sinal(i) = 0;
    end
end
disp('Porcentagem de acertos da direção de variação do preço:');
direcao = 100*direcao/x%Coloca em forma de porcentagem


figure;
plot(e);
title('Vetor inicial');

figure;
plot(y);
title('Processo AR4');

figure;
autocorr(y,[],2)
title('Autocorrelação do processo AR4');

figure;
plot(y_est,'.-r');
hold on;
plot(y_tr,'-b');
legend('estimado','real');
hold off;
grid on;
title('Previsão 1 passo a frente - validação');

figure;
plot(teta_mqr');
grid on;
title('Tetas estimado para o processo AR4');

figure;
plot(erro_est,'.-r');
hold on;
plot(erro_rw,'.-b');
hold off;
legend('Erro previsão','Erro random walk');
grid on;
title('Erros cometidos em cada iteração');


parametros = [teta teta_mq teta_mqr(:,end)]