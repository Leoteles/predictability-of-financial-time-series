clear all;
close all;
clc;

%Comparação entre a variancia do retorno e o nivel do preço no caso de
%petr4


%Carrega os dados de petr4 de 95 a junho de 2008
load petr4hist_sem_proventos;

n_intervalos = 100;%numero de intervalos em que a serie deve ser dividida

figure;
plot(fechamento);
title('Preços de fechamento');

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
title('Média do preço ao longo do tempo');

figure;
plot(media_preco,var_rcl,'.r');
title('Média do preço x Variancia para o logretorno');
xlabel('nível do preço');
ylabel('variância');