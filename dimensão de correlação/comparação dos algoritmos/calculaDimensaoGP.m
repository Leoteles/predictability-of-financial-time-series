%function [m,logCm,logr] = calculaDimensaoGP(serie,vetor_m)
%Implementação do algoritmo-GP
%Algumas idéias de A fast general purpose algorithm for the computation of auto- and
%cross-correlation integrals from single channel data
function [m,logCm,logr] = calculaDimensaoGP(serie,vetor_m)
%m - número de elementos dos vetores os quais serão calculadas as
%distâncias. Se a série é imersa em uma dimensão 2, por exemplo, os vetores
%serão [x(t) x(t-1)] e isso é feito fazendo m=2;

if ~exist('vetor_m','var')
    %Varia m de 1 a 10
    vetor_m = 1:10;
end

%Calculo do vetor r
%vetor_r = linspace(0,std(serie),20);
%vetor_r = 0.1 * (max(serie)-min(serie)) * linspace(0.05,1,20)';
nbins=200;
%Seleção do r baseado no algoritmo do Small corrint.m
%get bins : distributed logarithmically
binl=log(min(diff(unique(serie))))-1;   %smallest diff 
%if isempty(binl),binl=eps;end;  %just in-case
binh=log(max(vetor_m)*(max(serie)-min(serie)))+1;%seems to work
%if isnan(binh),binh=log(max(de)*max(y))+1;end; %just in-case 
binstep=(binh-binl)./(nbins-1);
bins=binl:binstep:binh;
bins=exp(bins);
vetor_r = bins;


for im = 1:length(vetor_m)
    %im
    %Calcula C(m) para determinado m e vários r(vetor_r)
    Cm(im,:) = calculaCm(serie,vetor_m(im),vetor_r);
end
%Cada vetor linha i possui uma curva Cm com um 'm' e vários 'r'
logCm = log10(Cm);
m = vetor_m;
logr = log10(vetor_r);

%Calcula C(m) para determinado m
function [Cm] = calculaCm(serie,m,vetor_r)

%A série é o vetor u
u = serie(:);
%Comprimento do vetor u
N = length(u);
%Número de vetores
nVec = N-m+1;

%Define-se uma sequencia de vetores x(1),x(2),...x(N-m+1) em R^m
%em que x(i) = [u(i),u(i+1),...,u(i+m-1)] e nVec = N-m+1
for i = 1:nVec
   x(:,i) = u(i:i+m-1);
end

Cmr = zeros(1,length(vetor_r));%inicializa Cmr

%Para todos os vetores
for i = 1:nVec
    for j = i+1:nVec%Só considera distância entre pontos diferentes
        
        %Calcula a distância d entre cada vetor,...
        d = max(abs(x(:,i) - x(:,j)));
        %Incrementa os C(m,r);Se r>d == d<=r incrementa indices r (ir)
        ir = find(vetor_r > d);
        %Considera o dobro da quantidade de pontos encontrados, já que
        %tanto d(i,j) quanto d(j,i) devem ser contados
        Cmr(ir) = Cmr(ir) + 2;
    end
end

%Calculo do Cm
%Divide (Cim / nVec) pelo número de vetores ([N-m+1] = nVec)
Cm = (Cmr / nVec) / nVec;
%size(Cm)%Deve ser vetor linha