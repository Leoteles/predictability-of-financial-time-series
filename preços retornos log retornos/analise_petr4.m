clear all;
close all;
clc;

%Compara��o entre a variancia do retorno e o nivel do pre�o no caso de
%petr4


%Carrega os dados de petr4 de 95 a junho de 2008
load petr4hist_sem_proventos;

n_intervalos = 100;%numero de intervalos em que a serie deve ser dividida

figure;
plot(fechamento);
title('Pre�os de fechamento');

rcl = price2ret(fechamento);


indices = linspace(1,length(rcl),n_intervalos);
indices = floor(indices);
for i=2:length(indices)
    inicio = indices(i-1);
    fim = indices(i);
    var_rcl(i-1) = var(rcl(inicio:fim));
    media_preco(i-1) = mean(fechamento(inicio:fim));
end

figure;
plot(var_rcl);
title('Variancia ao longo do tempo para o logretorno');

figure;
plot(media_preco);
title('M�dia do pre�o ao longo do tempo');

figure;
plot(media_preco,var_rcl,'.r');
title('M�dia do pre�o x Variancia para o logretorno');
xlabel('n�vel do pre�o');
ylabel('vari�ncia');