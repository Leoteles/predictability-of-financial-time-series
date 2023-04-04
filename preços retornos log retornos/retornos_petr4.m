clear all;
close all;
clc;

%Compara��o entre a variancia do retorno, log retorno e primeira diferenca
%para petr4.


%Carrega os dados de petr4 de 95 a junho de 2008
load petr4hist_sem_proventos;



figure;
plot(fechamento);
title('Pre�os de fechamento');

rcl = price2ret(fechamento);

indices = linspace(1,length(rcl),100);
indices = floor(indices);
for i=2:length(indices)
    inicio = indices(i-1);
    fim = indices(i);
    var_rcl(i-1) = var(rcl(inicio:fim));
end
figure;
plot(rcl);
title('log retorno');
figure;
plot(var_rcl);
title('Variancia ao longo do tempo para o logretorno');

razao = (fechamento(2:end)./fechamento(1:end-1))-1;

indices = linspace(1,length(razao),100);
indices = floor(indices);
for i=2:length(indices)
    inicio = indices(i-1);
    fim = indices(i);
    var_razao(i-1) = var(razao(inicio:fim));
end
figure;
plot(razao);
title('retorno dos pre�os');
figure;
plot(var_razao);
title('Variancia ao longo do tempo para a retorno dos pre�os');


diferenca = fechamento(2:end)-fechamento(1:end-1);

indices = linspace(1,length(diferenca),30);
indices = floor(indices);
for i=2:length(indices)
    inicio = indices(i-1);
    fim = indices(i);
    var_diferenca(i-1) = var(diferenca(inicio:fim));
end
figure;
plot(diferenca);
title('Primeira diferen�a dos pre�os');
figure;
plot(var_diferenca);
title('Variancia ao longo do tempo para a primeira diferen�a da s�rie de pre�os');


figure;
plot(var_rcl,'-r');
hold on;
plot(var_razao,'-b');
hold off;
legend('log retorno','retorno');
title('Compara��o entre as variancias');

figure;
autocorr(var_rcl , [] , 2)
