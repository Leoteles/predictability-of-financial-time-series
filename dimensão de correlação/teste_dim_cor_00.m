close all;
clear all;
clc;

%dimens�o da reta

N = 100;
y = 1:0.01:N;%reta
epsilon = 0.01:0.01:0.1;%Valores de dist�ncia para os quais os pontos s�o considerados vizinhos
vizinhos = zeros(length(y),1);

for e = 1:length(epsilon)
    for i = 1:length(y)
        for j = 1:length(y)
            if i~=j
                d = abs(y(i)-y(j));%Distancia
                if (d<=epsilon(e))
                    vizinhos(i) = vizinhos(i) + 1;
                end
            end
        end
    end
    vizinhos = vizinhos / length(y);%M�dia para cada ponto
    C(e) = sum(vizinhos) / length(y);%M�dia para todos os pontos
end

figure;
plot(epsilon,C)

figure;
plot(log(epsilon),log(C))