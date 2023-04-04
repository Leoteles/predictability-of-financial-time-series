clear all;
close all;
clc;

%Estruturas ARn aplicadas ao retorno dos fechamentos de petr4
%Estimadas por Mínimos quadrados clássico

%Carrega os dados de petr4 de 95 a junho de 2008
load petr4hist_sem_proventos;

%Obtem retorno dos precos de fechamento
rcl = price2ret(fechamento);

%Ljung-Box-Pierce Q-Test, H=1 confirma correlações significativas
[H,pValue,Stat,CriticalValue] = lbqtest(rcl-mean(rcl),[10 15 20]',0.05);
[H,pValue,Stat,CriticalValue]

%%%%%%%%Minimos quadrados%%%%%%%%
%Divisão dos dados
meio = floor(length(rcl)/2);
rcl_tr = rcl(1:meio);
rcl_val = rcl(meio+1:end);

%Série e Regressores
%ARn
n = 5;%AR(n)
[y_tr,psi] = gera_regressores_AR(rcl_tr,n);
teta_mq = inv(psi'*psi)*psi'*y_tr;
qsi = y_tr-psi*teta_mq;%Residuo

%Previsao 1 passo a frente
[y_val,psi] = gera_regressores_AR(rcl_val,n);
y_est = psi*teta_mq;
%Previsao random walk
y_rw = psi(:,1);%y(k-1) é o primeiro regressor

RMSE_estimado = mean(sqrt((y_val - y_est).^2))
RMSE_rw = mean(sqrt((y_val - y_rw).^2))

%Numero de vezes em que se acertou a direcao da tendencia
direcao = 0;
x = 0;
for i = 1:length(y_val)
    x = x + 1;
    if (y_val(i)>=0 && y_est(i)>=0 || y_val(i)<0 && y_est(i)<0)
        direcao = direcao + 1;
        sinal(i) = direcao;
    else
        sinal(i) = direcao;
    end
end
direcao = 100*direcao/x%Coloca em forma de porcentagem

figure;
plot(y_tr);
title('Retornos');

figure;
autocorr(y_tr,[],2)
title('Autocorrelação dos retornos');

figure;
autocorr(qsi,[],2)%Autocorrelação dos residuos
title('Autocorrelação dos resíduos');

figure;
plot(y_est,'.-r');
hold on;
plot(y_val,'.-b');
legend('estimado','real');
hold off;
grid on;
title('Previsão 1 passo a frente - validação');

%teste lbq dos residuos
[H,pValue,Stat,CriticalValue] = lbqtest(qsi-mean(qsi),[10 15 20]',0.05);
[H,pValue,Stat,CriticalValue]
