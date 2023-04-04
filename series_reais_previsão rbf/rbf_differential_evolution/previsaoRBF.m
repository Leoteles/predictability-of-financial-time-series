function y = previsaoRBF(modelo,X)

c = modelo.c;
sigma = modelo.sigma;
w2 = modelo.w2;

Nneu = size(c,1);%Numero de neuronios

Ndados = size(X,1);%N�mero de dados a serem calculados

for i = 1:Ndados
    
    x = X(i,:);
    
    for j=1:Nneu
        %Distancia do vetor de entrada ao centro j
        u = norm(x-c(j,:));
        %Saida da camada escondida GAUSSIANA
        yG(j) = exp( -(u^2) / (2*sigma(j)^2) );
    end
    %A saida da camada escondida � a entrada para a camada de sa�da
    x2 = yG;
    
    %Adiciona o bias
    x2 = [1 x2];
    
    
    y2 = x2 * w2;
    
    y(i,:) = y2;
    
end

end



