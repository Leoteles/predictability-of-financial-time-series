function modelo = estimaModeloRBF(xtr,ydtr,Nneuronios,sigma,centros)


N = size(xtr,1);%N�mero de "vetores linha" de entrada.


%Define os raios
if nargin < 5
    %Define os centros
    %Treinamento k-m�dias
    opts = statset('Display','off');
    [idx,ctrs] = kmeans(xtr,Nneuronios,...
        'Distance','sqEuclidean',...%'city',...
        ...%'Replicates',5,...
        'Options',opts);
    c = ctrs;
else
    c = centros;
end


%Define os raios
if nargin < 4
    sigma = calcula_Raios(c,'menor');
end


%Pesos da primeira camada
% c
% sigma

%Calcula entradas e saida da camada de saida da rede
for i=1:Nneuronios%Para todos os neuronios
    for j=1:N%Para todos os dados de entrada
        %Distancia do vetor de entrada j ao centro i
        u = norm(xtr(j,:)-c(i,:));
        %Saida da camada escondida GAUSSIANA
        %Cada linha j tem a resposta de cada estimulo (dado de entrada) j ao neuronio i
        y1(j,i) = exp( -(u^2) / (2*sigma(i)^2) );
    end
end


y1 = [ones(N,1) y1];%K+1 elementos, por causa do bias (o bias � como um neuronio cuja sa�da � sempre um)


%Estima��o dos parametros da segunda camada por MQ classico
psi = y1;%Lembrar que os dados devem estar em linhas e nao em colunas
yd = ydtr;
% size(psi)
% size(yd)
%tetaMQ = inv(psi'*psi)*psi'*yd;
%%tetaMQ = psi \ yd;
tetaMQ = pinv(psi'*psi) * (psi'*yd);


% yMQ = psi * tetaMQ;

w2 = tetaMQ;

modelo.c = c;%Centros
modelo.sigma = sigma;%Raios
modelo.w2 = w2;%Pesos da segunda camada




end



function sigma = calcula_Raios(c,alg)

Nneu = size(c,1);

%Calculo dos raios
for i=1:Nneu%Calcula a distancia entre os centros

    %Inicializa a vari�vel "menor distancia" com a dist�ncia ao pr�x. vetor
    if (i~=Nneu)%Quando o vetor i for o �ltimo, inicializa coma dist. entre ele e o primeiro
        menor(i) = norm(c(i,:)-c(i+1,:));
    else
        menor(i) = norm(c(i,:)-c(1,:));
    end
    
    %Encontra menor distancia do vetor i
    for j=1:Nneu%roda em todos os vetor j,
        if (i~=j)%em que j � diferente de i
            dist = norm(c(i,:)-c(j,:));
            if (dist<menor(i))
                menor(i) = dist;
            end
        end
    end
end

menor = menor(:);

if strcmp(alg,'mediamenor')
    %Procedimento 1: Todos os raios iguais
    %Calcula sigma, o raio dos neuronios
    sigma = ones(Nneu,1) .* mean(menor);
end
if strcmp(alg,'menor')
    %Procedimento 2: Raios diferentes, menor distancia entre os centros
    %Calcula sigma, o raio dos neuronios
    sigma = menor;
end
end

%function [w,y] = mykmeans(dados,K)
%Calcula os K pesos(centros dos padroes) para o vetor de dados fornecido
%Cada dado est� em uma coluna
%w s�o os K centros obtidos. Cada coluna de w representa um centro.
%y � a identifica��o de qual dados pertence a qual centro. O valor de y
%identifica uma coluna de w.
function [w,y] = mykmeans(dados,K)

N_dados = size(dados,2);
N_dimensoes = size(dados,1);


dados = dados(:,randperm(size(dados,2)));%Vetor de dados em ordem aleatoria

%Os primeiros K dados ja foram atribuidos aos centros w
for i=1:K
    w(:,i) = dados(:,i);
end

% figure;
% plot(dados(1,:),dados(2,:),'.r');
% hold on;
% plot(w(1,:),w(2,:),'*b');
% hold off;
% pause;

mudou = 1;%Flag que indica a mudan�a dos pesos
while (mudou)
    for i=1:N_dados
        %Associa o novo dado ao centro mais pr�ximo
        for j=1:K
            %Calcula as dist�ncias entre o dado i e o centro j
            yi(j) = norm(dados(:,i)-w(:,j));
        end
        [C,I] = min(yi);%Encontra o centro mais proximo
        %Atribui ao dado i o centro do grupo mais proximo I
        y(i) = I;
    end

    %Calcula os novos centros
    
    soma = zeros(N_dimensoes,K);
    for i=1:N_dados
        %Soma os dados relativos a cada centro
        soma(:,y(i)) = soma(:,y(i)) + dados(:,i);
    end
    %O novo centro ser� o vetor da m�dia dos vetores pertencentes a cada
    %centro
    for i=1:K
        %Calcula a m�dia
        w_novo(:,i) = soma(:,i)./length(find(y==i));
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
end

