% Gera n precos que seguem um passeio aleatorio
% com uma variancia v .
%Prototipo:  
%function [abertura, maxima, minima, fechamento] = gera_precos_rw(n,variancia)
%O resultado sao vetores coluna
function [abertura, maxima, minima, fechamento] = gera_precos_rw(n,variancia)

fechamento(1) = 0;
for i = 2:n+1%O primeiro valor será desprezado
    inovacao = randn(4,1)*sqrt(variancia);
    %Ordena vetores de inovacao para separa o maior e o menor
    [inov_ord,index] = sortrows(inovacao);
    maxima(i) = fechamento(i-1) + inov_ord(4);
    minima(i) = fechamento(i-1) + inov_ord(1);
    %O valor de abertura e fechamento é aleatoriamente um dois dois valores
    %de inovação restante
    openclose = inov_ord(2:3);
    openclose = openclose(randperm(2));
    abertura(i) = fechamento(i-1) + openclose(1);
    fechamento(i) = fechamento(i-1) + openclose(2);
end

%Despreza o primeiro valor
abertura = abertura(2:end);
fechamento = fechamento(2:end);
maxima = maxima(2:end);
minima = minima(2:end);

%Todos os valores de preço devem ser positivos
preco_minimo = min(minima);
if (preco_minimo<=0)
    soma_aleatoria = abs(100*randn(1));
    abertura = abertura - preco_minimo + soma_aleatoria;
    fechamento = fechamento - preco_minimo + soma_aleatoria;
    maxima = maxima - preco_minimo + soma_aleatoria;
    minima = minima - preco_minimo + soma_aleatoria;
end

%Os valores abaixo de 1 centavo devem ser desprezados
abertura = abertura * 100;
abertura = floor(abertura);
abertura = abertura / 100;
fechamento = fechamento * 100;
fechamento = floor(fechamento);
fechamento = fechamento / 100;
maxima = maxima * 100;
maxima = floor(maxima);
maxima = maxima / 100;
minima = minima * 100;
minima = floor(minima);
minima = minima / 100;


%Os resultados devem ser vetores coluna
abertura = abertura';
fechamento = fechamento';
maxima = maxima';
minima = minima';