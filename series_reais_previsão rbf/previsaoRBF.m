function y = previsaoRBF(modelo,x)

c = modelo.c;
sigma = modelo.sigma;
w2 = modelo.w2;

Nneu = size(c,1);%Numero de neuronios

for i=1:Nneu
    %Distancia do vetor de entrada ao centro i
    u = norm(x-c(i,:));
    %Saida da camada escondida GAUSSIANA
    yG(i) = exp( -(u^2) / (2*sigma(i)^2) );
end
%A saida da camada escondida é a entrada para a camada de saída
x2 = yG;

%Adiciona o bias
x2 = [1 x2];


y2 = x2 * w2;

y = y2;

end



