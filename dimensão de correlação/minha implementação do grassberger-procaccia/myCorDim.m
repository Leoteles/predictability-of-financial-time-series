%function beta = myCorDim(serie,m,r)
%Como definido no artigo Pincus - Approximate Entropy as A Measure of
%System Complexity - refs 21 e 22 do artigo
function beta = myCorDim(serie)

%m - número de elementos dos vetores os quais serão calculadas as
%distâncias. Se a série é imersa em uma dimensão 2, por exemplo, os vetores
%serão [x(t) x(t-1)] e isso é feito fazendo m=2;
%Varia m de 2 a 8
m = 2:8;

r = linspace(0,std(serie),20);
%r = 0.1 * (max(serie)-min(serie)) * linspace(0.05,1,20)';
%logr = log10(r);

for i = 1:length(m)
    %i
    for j = 1:length(r)
        %Calcula Cm(r) para determinado m e r
        Cm(i,j) = calculaCm(serie,m(i),r(j));
    end
end
%Cada vetor linha i possui uma curva Cm com um 'm' e vários 'r'
beta.Cm = Cm;%log10(Cm)/log10(r);
beta.m = m;
beta.r = r;

%Calcula Cm(r) para determinado m
function Cm = calculaCm(serie,m,r)
%Como definido no artigo Pincus - Approximate Entropy as A Measure of
%System Complexity - refs 21 e 22 do artigo

%No artigo a série é o vetor u
u = serie;
%Comprimento do vetor u
N = length(u);
%Número de vetores
nVec = N-m+1;

%Define-se uma sequencia de vetores x(1),x(2),...x(N-m+1) em R^m
%em que x(i) = [u(i),u(i+1),...,u(i+m-1)] e nVec = N-m+1
for i = 1:nVec
   x(:,i) = u(i:i+m-1);
end

%x

Cim = zeros(1,nVec);
%Para todos os vetores
for i = 1:nVec
    for j = 1:nVec
        if j~=i%Só considera distância entre pontos diferentes
            %Calcula a distância d entre cada vetor,...
            d(i,j) = max(abs(x(:,i) - x(:,j)));
            
            %Calcula C_i^m(r), o número de j's tal que [d(x(i),x(j))<=r]
            %dividido pelo número de vetores ([N-m+1] = nVec)
            if d(i,j) <= r
                Cim(i) = Cim(i) + 1;
            end
        end
    end
end

%Calculo do Cm - média do Cim em todos os i's
%Divide (sum(Cim) / nVec) pelo número de vetores ([N-m+1] = nVec)
Cm = (sum(Cim) / nVec) / nVec;

