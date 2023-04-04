clear all;
close all;
clc;

%Estruturas AR aplicadas ao quadrado do retorno dos fechamentos de petr4
%Estimadas por Mínimos quadrados recursivo com fator de esquecimento lambda
%São considerados, para a previsão do quadrado do retorno de fechamento,
%valores passados do quadrado do retorno de fechamento
%Carrega os dados de petr4 de 95 a junho de 2008

load petr4hist_sem_proventos;

%Obtem retorno dos precos de fechamento
rcl = price2ret(fechamento);
rcl2 = rcl.^2;
%%%%%%%%Minimos quadrados%%%%%%%%

%Série e Regressores
%AR5
n = 10;%AR(n) -> n=5
[y_cl,psi_cl] = gera_regressores_AR(rcl2,n);

y_tr = y_cl;%A saida a ser predita é o retorno do fechamento
psi = [psi_cl];
n = 1 * n;%A matriz de regressores tem 1 estrutura ARn

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

figure;
plot(y_tr);
title('Retornos^2');

figure;
autocorr(y_tr,[],2)
title('Autocorrelação dos retornos^2');

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
title('Tetas estimados para o processo AR');

figure;
plot(erro_est,'.-r');
hold on;
plot(erro_rw,'.-b');
hold off;
legend('Erro previsão','Erro random walk');
grid on;
title('Erros cometidos em cada iteração');


parametros = [teta_mq teta_mqre(:,end)]


y_est_mq_classico = psi * teta_mq;
qsi = y_est_mq_classico - y_tr;
figure;
plot(y_tr,'-k');
hold on;
plot(y_est_mq_classico,'-ob');
plot(y_est,'-or');
hold off;
legend('real','mq classico','mq recurssivo esquecimento');

figure;
autocorr(qsi , [] , 2);

RMSE_mq_classico = mean(sqrt((y_tr - y_est_mq_classico).^2))

RMSE_null = mean(sqrt((y_tr).^2))

x = 1;
for i = 1:length(y_tr)
    if (y_tr(i)~=0)
        erro(x) = 100*abs(y_est_mq_classico(i)-y_tr(i))/y_tr(i);
        x = x + 1;
    end
end

mean(erro)
        
