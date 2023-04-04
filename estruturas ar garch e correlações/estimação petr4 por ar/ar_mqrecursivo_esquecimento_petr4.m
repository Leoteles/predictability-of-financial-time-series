clear all;
close all;
clc;

%Estruturas ARn aplicadas ao retorno dos fechamentos de petr4
%Estimadas por Mínimos quadrados recursivo com fator de esquecimento lambda

%Carrega os dados de petr4 de 95 a junho de 2008
load petr4hist_sem_proventos;

%Obtem retorno dos precos de fechamento
rcl = price2ret(fechamento);


%Ljung-Box-Pierce Q-Test, H=1 confirma correlações significativas
[H,pValue,Stat,CriticalValue] = lbqtest(rcl-mean(rcl),[10 15 20]',0.05);
[H,pValue,Stat,CriticalValue]

%%%%%%%%Minimos quadrados%%%%%%%%

%Série e Regressores
%AR5
n = 5;%AR(n) -> n=5
[y_tr,psi] = gera_regressores_AR(rcl,n);

teta_mq = inv(psi'*psi)*psi'*y_tr;%mq classico


%Minimos quadrados recursivo com esquecimento nos dados de treinamento
teta_mqre(:,1) = zeros(n,1);%Parametros iniciais
P = eye(n);%Matriz de covariancia inicial
lambda = 0.9995;
for k=2:length(y_tr)

    %Previsao 1 passo a frente(valor previsto no instante k, antes da medição)
    y_est(k) = psi(k,:)*teta_mqre(:,k-1);
    %Previsao random walk
    y_rw(k) = psi(k,1);%psi na coluna 1 é o valor em k-1

    %%inicio%MQR%%%%%%%%%%%%
    psi_k = psi(k,:)';%Para o mqr
    K = ( P*psi_k ) / ( psi_k'*P*psi_k + lambda );
    teta_mqre(:,k) = teta_mqre(:,k-1) + K * (y_tr(k)-psi_k'*teta_mqre(:,k-1));
    P = (1/lambda) * ( P  -  (P*psi_k*psi_k'*P) / (psi_k'*P*psi_k+lambda) );
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
direcao_rw = 0;
x = 0;
for i = 1000:length(y_tr)
    x = x + 1;
    if ((y_tr(i)>=0 && y_est(i)>=0) || (y_tr(i)<0 && y_est(i)<0))
        direcao = direcao + 1;
        sinal(i) = 1;
    else
        sinal(i) = 0;
    end
    if ((y_tr(i)>=0 && y_rw(i)>=0) || (y_tr(i)<0 && y_rw(i)<0))
        direcao_rw = direcao_rw + 1;
    end
    
end

disp('Porcentagem de acertos da direção de variação do preço,');
disp('após 1000 iterações do algoritmo, para o random walk em media :');
direcao_rw = 100*direcao_rw/x%Coloca em forma de porcentagem


disp('Porcentagem de acertos da direção de variação do preço,');
disp('após 1000 iterações do algoritmo, para o AR em media :');
direcao = 100*direcao/x%Coloca em forma de porcentagem


figure;
plot(y_tr);
title('Retornos');

figure;
autocorr(y_tr,[],2)
title('Autocorrelação dos retornos');

figure;
plot(y_est,'.-r');
hold on;
plot(y_tr,'-b');
legend('estimado','real');
hold off;
grid on;
title('Previsão 1 passo a frente');

figure;
plot(teta_mqre');
grid on;
title('Tetas estimado para o processo ARn');

figure;
plot(erro_est,'.-r');
hold on;
plot(erro_rw,'.-b');
hold off;
legend('Erro previsão','Erro random walk');
grid on;
title('Erros cometidos em cada iteração');


parametros = [teta_mq teta_mqre(:,end)]
