clear all;
close all;
clc;

%Carrega os dados de petr4 de 95 a junho de 2008
load petr4hist_sem_proventos;

%Compara o processo da media amostral de rcl e rw

%Obtem retornos dos precos de fechamento
rcl = price2ret(fechamento);

N = length(rcl);
%Serie aleatoria de mesmo comprimento da série de retornos
rw = randn(N,1);


media_temporal_rcl = cumsum(rcl)./(1:N)';
media_temporal_rw = cumsum(rw)./(1:N)';


%Grafico que compara o processo da media amostral de rcl e rw
figure;
plot(media_temporal_rcl,'-r');
hold on;
plot(media_temporal_rw,'-b');
hold off;
legend('media temporal rcl','media temporal rw');
xlabel('amostras');
ylabel('media');
grid on;
