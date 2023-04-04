%Saida da camada escondida (camada 1) da rede rbf
%function y1 = rbf1out(dados,c,r)
%A resposta y1 tem em suas linhas a resposta de cada neuronio ao estimulo
%da coluna
function y1 = rbf1out(dados,c,r)


K = size(c,2);%Numero de neuronios
nDados = size(dados,2);

for i=1:nDados%Para todos os dados
    x = dados(:,i);
    for j=1:K%Para todos os neuronios
        %Distancia do vetor de entrada ao centro j
        u = norm(x-c(:,j));
        %Saida da camada escondida GAUSSIANA
        yG(i,j) = exp( -(u^2) / (2*r(j)^2) );
    end
end
%A saida da camada escondida é a entrada para a camada de saída
%y1 é transposto pois deve ser:
%Neuronios nas linhas e estimulos nas colunas
y1 = (yG)';

