%function [w,erroEpoca] = myPerceptron(dados,yd,nEpocas,eta)
function [w,erroEpoca] = myPerceptron(dados,yd,nEpocas,eta)
nDados = size(dados,2);
nDim = size(dados,1);%Dimensao dos dados
%Inicializa os pesos de maneira aleatoria
w = randn(nDim+1,1);%Numero de pesos é a dimensão de entrada mais o bias
nNeu = size(w,1);

%Treinamento Perceptron
for ep=1:nEpocas
    %Vetor de dados em ordem aleatoria
    ordem = randperm(nDados);
    dados = dados(:,ordem);
    yd = yd(:,ordem);
    erroEpoca(ep) = 0;
    %Para todos os dados
    for i=1:nDados
        xi = [1; dados(:,i)];%Inclui o bias na entrada atual
        ydi = yd(i);
        %Saida do perceptron para as entradas atuais
        u = w' * xi;
        %HardThreshold
        if (u>=0)
            y = 1;
        else
            y = -1;
        end
        %Corrige os pesos da rede
        erro = ydi - y;
        w = w + eta * erro * xi;
        erroEpoca(ep) = erroEpoca(ep) + erro.^2;
    end
    eta = 0.9;
end


