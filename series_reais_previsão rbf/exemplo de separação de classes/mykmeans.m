%function [w,y] = mykmeans(dados,K)
%Calcula os K pesos(centros dos padroes) para o vetor de dados fornecido
%Cada dado está em uma coluna
function [w,y] = mykmeans(dados,K)

N_dados = size(dados,2);
N_dimensoes = size(dados,1);


dados = dados(:,randperm(size(dados,2)));%Vetor de dados em ordem aleatoria

%Os primeiros K dados ja foram atribuidos aos pesos
for i=1:K
    w(:,i) = dados(:,i);
end

% figure;
% plot(dados(1,:),dados(2,:),'.r');
% hold on;
% plot(w(1,:),w(2,:),'*b');
% hold off;
% pause;

mudou = 1;%Flag que indica a mudança dos pesos
while (mudou)
    for i=1:N_dados
        %Associa o novo dado ao centro mais próximo
        for j=1:K
            yi(j) = norm(dados(:,i)-w(:,j));
        end
        [C,I] = min(yi);%Encontra o centro mais proximo
        %Atribui ao dado i o centro do grupo mais proximo I
        y(i) = I;
    end

    %Calcula os novos centros
    soma = zeros(N_dimensoes,K);
    for i=1:N_dados
        soma(:,y(i)) = soma(:,y(i)) + dados(:,i);
    end
    for i=1:K%Calcula a média
        if length(find(y==i))==0%Se nao ha dados no neuronio
            w_novo(:,i) = w(:,i);%Nao muda o seu peso
        else
            w_novo(:,i) = soma(:,i)./length(find(y==i));
        end
    end
    if (isequal(w,w_novo))
        mudou = 0;
    else
        w = w_novo;
    end

%     plot(dados(1,:),dados(2,:),'.r');
%     hold on;
%     plot(w(1,:),w(2,:),'*b');
%     hold off;
%     pause;
end
