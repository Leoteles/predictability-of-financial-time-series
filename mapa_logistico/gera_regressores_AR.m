%Gera a matriz de regressores para uma estrutura AR(n) em que n � passado
%como par�metro, al�m da s�rie. O prot�tipo da fun��o �:
% function [y,psi] = gera_regressores_AR(serie,n)

function [y,psi] = gera_regressores_AR(serie, n)

y = serie(n+1:end);

for i = 1:n
    psi(:,i) = serie(n+1-i:end-i);
end
