%function modelo = estimaModeloAR(serie,k)
%serie deve ser vetor coluna
%k � o n�mero de par�metros
%Se k n�o foi definido, detecta k por meio do teste Ljung-box, v�lido para
%   k at� 50;
%
%modelo � uma estrutura com:
%modelo.parametros - vetor de parametros na ordem y(k-1) y(k-2) etc.
%modelo.y - vetor usado para se calcular o modelo (y desejado)
%modelo.x - vetor usado para se calcular o modelo (regressores)
%modelo.yhat - vetor estimado por meio de x e parametros
%modelo.residuos  - residuos (y - yhat)
%modelo.SSR - soma dos quadrados dos residuos (representa a variancia dos residuos)
%modelo.SST - soma dos quadrados dos desvios da s�rie em rela��o a sua
%m�dia (representa a variancia da s�rie)
%modelo.SSE - soma dos quadrados dos desvios do modelo em rela��o a sua
%m�dia (representa a variancia explicada pelo modelo)
%modelo.r2 - R^2 encontrado na regress�o 
%modelo.AIC - valor do crit�rio de informa��o de akaike do modelo
function modelo = estimaModeloAR(serie,k)

%Se k n�o foi definido, detecta k por meio do teste Ljung-box, v�lido para
%   k at� 50;
if nargin <2
    for k = 1:50
        modelo = estimaModeloARfixo(serie,k);
        [h,pValue,stat,cValue] = lbqtest(modelo.residuos);
        if h == 0
            break;
        end
    end
    if k == 50
        disp('imposs�vel modelar AR(50)')
    end
else
    modelo = estimaModeloARfixo(serie,k);
end

end
function modelo = estimaModeloARfixo(serie,k)

serie = serie(:);%serie deve ser vetor coluna

[y,x] = gera_regressores_AR(serie,k);

%M�nimos quadrados
teta = inv(x'*x)*x'*y;%Parametros estimados

yhat = x * teta;
u = y - yhat;

SSR = sum(u.^2);%Soma dos quadrados dos res�duos(variancia dos residuos)
SST = sum((y-mean(y)).^2);%Soma dos desvios da s�rie(variancia da s�rie)
SSE = sum((yhat-mean(y)).^2);%mean(y) == mean(yhat); (variancia explicada pelo modelo)

%R^2 do modelo
rsquare = SSE / SST; %ou 1 - (SSR/SST)

%Crit�rio de informa��o de Akaike
n = length(y);
AIC = 2*k + n*(log(SSR));

%escreve resultados na estrutura
modelo.parametros = teta;
modelo.y = y;
modelo.x = x;
modelo.yhat = yhat;
modelo.residuos = u;
modelo.SSR = SSR;
modelo.SSE = SSE;
modelo.SST = SST;
modelo.r2 = rsquare;
modelo.AIC = AIC;
modelo.k = k;
end

function [y,x] = gera_regressores_AR(serie, k)

serie = serie(:);%serie deve ser vetor coluna
y = serie(k+1:end);

for i = 1:k
   x(:,i) = serie(k+1-i:end-i);
end

end