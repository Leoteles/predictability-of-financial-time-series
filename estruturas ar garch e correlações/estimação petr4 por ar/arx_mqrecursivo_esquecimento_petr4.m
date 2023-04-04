clear all;
close all;
clc;

%Estruturas ARX aplicadas ao retorno dos fechamentos de petr4
%Estimadas por Mínimos quadrados recursivo com fator de esquecimento lambda
%São considerados, para a previsão do retorno de fechamento, valores
%passados do retorno de abertura, maxima e minima
%Carrega os dados de petr4 de 95 a junho de 2008
load petr4hist_sem_proventos;

%Obtem retorno dos precos de fechamento
rcl = price2ret(fechamento);
%Obtem retorno dos precos de abertura
rop = price2ret(abertura);
%Obtem retorno dos precos de fechamento
rhi = price2ret(maxima);
%Obtem retorno dos precos de abertura
rlo = price2ret(minima);

%%%%%%%%Minimos quadrados%%%%%%%%

%Série e Regressores
%AR5
n = 5;%AR(n) -> n=5
[y_cl,psi_cl] = gera_regressores_AR(rcl,n);
[y_op,psi_op] = gera_regressores_AR(rop,n);
[y_hi,psi_hi] = gera_regressores_AR(rhi,n);
[y_lo,psi_lo] = gera_regressores_AR(rlo,n);

y_tr = y_cl;%A saida a ser predita é o retorno do fechamento
psi = [psi_cl psi_op psi_hi psi_lo];
n = 4 * n;%A matriz de regressores tem 4 estruturas ARn

teta_mq = inv(psi'*psi)*psi'*y_tr;%mq classico


%Minimos quadrados recursivo com esquecimento nos dados de treinamento
teta_mqre(:,1) = zeros(n,1);%Parametros iniciais
P = eye(n);%Matriz de covariancia inicial
lambda = 0.9995;
for k=2:length(y_tr)

    %Previsao 1 passo a frente(valor previsto no instante k, antes da medição)
    y_est(k) = psi(k,:)*teta_mqre(:,k-1);
    %Previsao random walk
    y_rw(k) = y_tr(k-1);

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
    x = x+1;
    if ((y_tr(i)>=0 && y_est(i)>=0) || (y_tr(i)<0 && y_est(i)<0))
        direcao = direcao + 1;
    end
    if ((y_tr(i)>=0 && y_rw(i)>=0) || (y_tr(i)<0 && y_rw(i)<0))
        direcao_rw = direcao_rw + 1;
    end

end

disp('Porcentagem de acertos da direção de variação do preço,');
disp('após 1000 iterações do algoritmo, em media para o Random Walk :');
direcao_rw = 100*direcao_rw/x%Coloca em forma de porcentagem

disp('Porcentagem de acertos da direção de variação do preço,');
disp('após 1000 iterações do algoritmo, em media para o modelo ARX:');
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
title('Tetas estimados para o processo ARX');

figure;
plot(erro_est,'.-r');
hold on;
plot(erro_rw,'.-b');
hold off;
legend('Erro previsão','Erro random walk');
grid on;
title('Erros cometidos em cada iteração');


parametros = [teta_mq teta_mqre(:,end)]
