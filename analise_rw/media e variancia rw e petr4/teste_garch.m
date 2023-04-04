clear all;
close all;
clc;

%Carrega os dados de petr4 de 95 a junho de 2008
load petr4hist_sem_proventos;

%Filtro GARCH

%Obtem retornos dos precos de fechamento
rcl = price2ret(fechamento);

N = length(rcl);
%Serie aleatoria de mesmo comprimento da série de retornos
rw = randn(N,1);


for i=1:N
    var_rcl(i) = var(rcl(1:i));
    var_rw(i) = var(rw(1:i));
end


%Graficos que mostram a  o processo da variancia amostral de rcl e rw
%var rcl
figure;
plot(var_rcl,'-r');
title('variancia rcl');
xlabel('amostras');
ylabel('variancia');
grid on;
%var rw
figure;
plot(var_rw,'-b');
title('variancia rw');
xlabel('amostras');
ylabel('variancia');
grid on;

%Altera a variancia do processo rw criado para que se aproxime da variancia
%de rcl. Usa-se a variancia amostral obtida depois de 1000 amostras, 
%em que supostamente o processo de variancia convergiu. Pode-se modificar
%a variancia simplesmente multiplicando-se a serie pelo novo valor porque a
%variancia anterior era unitaria 
rw_nova_var = sqrt(var_rcl(1000)) .* rw;
for i=1:N
    var_rw_nova_var(i) = var(rw_nova_var(1:i));
end



%Grafico que compara o processo da media amostral de rcl e rw
figure;
plot(var_rcl,'-r');
hold on;
plot(var_rw_nova_var,'-b');
hold off;
legend('variancia rcl modificada','variancia rw');
xlabel('amostras');
ylabel('variancia');
grid on;
