%function [xtr,ydtr,xval,ydval,xtest,ydtest] = preparaDados(serie,Ndelays,Nval,Ntest)
%serie - a s�rie temporal a serr transformada em vetores entrada e sa�da para a 
%    rede TDNN
%Ndelays - N�mero de atrasos (AR) a serem considerados para a cria��o do vetor de
%    entrada TDNN
%Nval - 'porcentagem' de dados da s�rie a serem destinados ao treinamento.
%    Ex.: Nval = 0.2 -> 20% (finais) dos dados destinados a valida��o
%Ntest - 'porcentagem' de dados da s�rie a serem destinados ao teste final.
%    Ex.: Ntest = 0.2 -> 20% (ap�s os dados de valida��o) dos dados
%    destinados ao teste final. Nesse caso os dados de valida��o
%    representam a valida��o cruzada como em um treinamento mobj que tambem
%    minimiza a complexidade da rede
function [xtr,ydtr,xval,ydval,xtest,ydtest] = preparaDados(serie,Ndelays,Nval,Ntest)

%Vetor serie sempre � vetor coluna
serie = serie(:);

xtr = [];
ydtr = [];
xval = [];
ydval = [];
xtest = [];
ydtest = [];

if nargin < 2
    Ndelays = 1
    Nval = 0;
    Ntest = 0;

end
if nargin < 3
    Nval = 0;
    Ntest = 0;
end
if nargin < 4
    Ntest = 0;
end

Ntr = 1 - Nval - Ntest;

%Gera vetores de entrada e sa�da
[yd,x] = gera_regressores_AR(serie, Ndelays);

%Comprimento da s�rie
N = length(yd);

%�ltimo valor da s�rie de treinamento
fim_tr = floor(Ntr*N);
%�ltimo valor da s�rie de valida��o
fim_val = fim_tr + floor(Nval*N);

%Dados de treinamento
xtr = x(1:fim_tr,:);
ydtr = yd(1:fim_tr);
%Dados de Valida��o
xval = x(fim_tr+1:fim_val,:);
ydval = yd(fim_tr+1:fim_val);
%Dados de teste
xtest = x(fim_val+1:end,:);
ydtest = yd(fim_val+1:end);


end


%Gera a matriz de regressores para uma estrutura AR(n) em que n � passado
%como par�metro, al�m da s�rie. O prot�tipo da fun��o �:
% function [y,psi] = gera_regressores_AR(serie,n)
function [y,psi] = gera_regressores_AR(serie, n)

y = serie(n+1:end);

for i = 1:n
    psi(:,i) = serie(n+1-i:end-i);
end
end