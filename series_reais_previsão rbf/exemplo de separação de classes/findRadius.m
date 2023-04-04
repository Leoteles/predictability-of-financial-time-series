%Calculo dos raios baseado nos seguintes metodos
%Metodo 1: Todos os raios iguais
%Metodo 2: Raios diferentes, menor distancia entre os centros
%Metodo 3: Raios diferentes, desvio padrao dos dados que participam
%dos centros
%function [raios] = findRadius(centros,metodo) para os metodos 1 e 2
%function [raios] = findRadius(centros,metodo,dados,classeDados) para o
%metodo 3
%centros - centros dos padroes
%dados - vetor de dados de entrada (necessario somente no metodo 3)
%classeDados - vetor que indica a classe dos dados(necessario somente no
%metodo 3)
function [raios] = findRadius(centros,metodo,dados,classeDados)
c = centros;
K = size(centros,2);

if (metodo==1 || metodo==2)

    for i=1:K%Calcula a distancia entre os centros
        %Inicializa menor distancia
        if (i~=K)
            menor(i) = norm(c(:,i)-c(:,i+1));
        else
            menor(i) = norm(c(:,i)-c(:,1));
        end
        %Encotra menor distancia
        for j=1:K
            if (i~=j)
                dist = norm(c(:,i)-c(:,j));
                if (dist<menor(i))
                    menor(i) = dist;
                end
            end
        end
    end
    
    if (metodo==1)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %Procedimento 1: Todos os raios iguais
        %Calcula sigma, o raio dos neuronios
        raios = ones(1,K)*mean(menor);
    else
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %Procedimento 2: Raios diferentes, menor distancia entre os centros
        %Calcula sigma, o raio dos neuronios
        raios = menor;
    end
else
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Procedimento 3: Raios diferentes, desvio padrao dos dados que participam
    %dos centros
    y = classeDados;
    N_dados = size(dados,2);

    %Calcula sigma, o raio dos neuronios
    for i=1:K
        somatorio = 0;
        N_x = 0;
        for j=1:N_dados
            if (y(j)==i)
                somatorio = somatorio + (norm(c(:,i)-dados(:,j))^2);
                N_x = N_x + 1;
            end
        end
        raios(i) =sqrt(somatorio/N_x);
    end
end