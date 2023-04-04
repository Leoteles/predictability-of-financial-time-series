%Teste de heteroscedasticidade
%function [H ,pValor,v,vCritico] = testaHeteroscedasticidade(serie,teste)
%Testa a série de resíduos quanto a presença de heteroscedasticidade.
%Supõe-se que a série seja originada de um processo homocedástico(H=0).
%Considerando-se, essa hipótese, a estatística LM calculada pelo teste deve
%ser inferior ao valor limite (vCritico) em 95% dos casos.
%
%A função recebe como parâmetro a série a ser testada (deve ser um
%vetor coluna) e a váriável teste, que pode possuir os valores:
%   'bp'    = realiza o teste segundo Breusch-Pagan
%   'white' = realiza o teste segundo White.

%A função retorna H:
%H:
%   H = 1 - A série em questão possui heteroscedasticidade. O teste
%   foi capaz de rejeitar a hipótese de homoscedasticidade. Correponde ao
%   resultado: v >= vCritico
%   H = 0 - Não se pode dizer se a série possui heteroscedasticidade. O
%   teste não foi capaz de rejeitar a hipótese. Corresponde ao 
%   resultado: v < vCritico
%
%   Isso é feito considerando que o modelo usado nos teste foi o adequado.
%
%pValor: Pode ser visto como a probabilidade de o resultado de o teste
%falhar, dado que a hipótese tenha sido rejeitada.
%
%v: Valor da estatística LM, usada no teste. Se esse valor é maior que o
%valor crítico, a hipótese de homoscedasticidade é rejeitada.
%
%vCritico: Valor da CDF (qui-quadrado com K graus de liberdade) que
%corresponde a 95% da área de sua PDF. É o limite de rejeição, a partir do
%qual se pode rejeitar a hipótese de homoscedasticidade
%
%Os testes são implementados seguindo o livro:
%Wooldridge, J.M. (2 ed.) Introductory Econometrics: A Modern Approach - Thomson
%cap. 8 (Heteroskedasticity)


function [H ,pValor,v,vCritico] = testaHeteroscedasticidade(serie,teste)

K = 5;%número de regressores (desconsiderando o delta0 abaixo)
%K tem relação com o número de graus de liberdade do qui-quadrado limite

%Constroi-se o modelo (White):
% u^2(k) = delta0 + 
%          delta1 * xu2(k) + delta2 * xu2(k-1) + ... +
%          delta3 *  xu(k) + delta4 *  xu(k-1) + ... +
%          delta5 *  xu(k) * xu2(k) + delta6 *  xu(k-1) + xu2(k-1) + ...
%Em que xu2(k),xu2(k-1),... são os regressores de u^2.
%Para o modelo de Breusch-Pagan utiliza-se apenas as duas primeiras linhas
%da equação acima.
%ps:A equação acima poderia ser modificada para qualquer conjunto de
%variáveis indepententes, como por exemplo, escolher apenas a primeira e
%terceira linha da equação. A única mudança a ser feita se refere a
%modificar o número de graus de liberdade para um valor igual a quantidade
%de variáveis independentes dessa equação como descrito no final da pg. 258

u = serie;

%Quadrado dos resíduos
u2 = u.^2;

%Regressores
[u,xu] = gera_regressores_AR(u, K);
[u2,xu2] = gera_regressores_AR(u2, K);

%Monta matriz de regressores para cada um dos testes
if strcmp(teste,'bp')%breush-pagan
    X = [ones(length(u2),1) xu];%coluna com ones representa o regressor para delta0
    grausLiberdade = size(X,2) - 1;%Número de regressores (desconsiderando delta0)
end
if strcmp(teste,'white')%white
    X = [ones(length(u2),1) xu];%coluna com ones representa o regressor para delta0
    %X = [X xu2];%Regressores xu2(k),xu2(k-1),etc.
    %Inclui regressores cruzados: u(k-1)*u2(k-1),u(k-1)*u2(k-2),etc.
    for i = 1:K%Para cada regressor u(k-i)
        for j = 1:K%Para cada regressor u(k-j)
            if (j>=i)
                X = [X xu(:,i).* xu(:,j)];
            end
        end
    end
    grausLiberdade = size(X,2) - 1;%Número de regressores (desconsiderando delta0)
end

%Mínimos quadrados
teta = (X'*X)\X'*u2;%Parametros estimados

%Encontra resíduos do modelo
u2hat = X * teta;
residuo_u2 = u2 - u2hat;

%Funções para cálculo do R^2
SSR = sum(residuo_u2.^2);%Soma dos quadrados dos resíduos(variancia dos residuos)
SST = sum((u2-mean(u2)).^2);%Soma dos desvios da série(variancia da série)
SSE = sum((u2hat-mean(u2)).^2);%mean(u2) == mean(u2hat); (variancia explicada pelo modelo)

%R^2 do modelo
r2 = SSE / SST; %ou 1 - (SSR/SST)

%LM statistic
LM = r2 * length(u2);
v = LM;

%p-valor
pValor = 1-chi2cdf(LM,grausLiberdade);

%Valor limite para o intervalo de confiaça de 95%
vCritico = chi2inv(0.95,grausLiberdade);

%Se o modelo usado nos teste for o adequado,
if (LM >= vCritico)%Rejeita a hipótese de homoscedasticidade
    H = 1;%A série possui heteroscedasticidade
else%O teste não foi capaz de rejeitar a hipótese
    H = 0;%Não se pode dizer se a série possui heteroscedasticidade
end


function [y,x] = gera_regressores_AR(serie, k)

serie = serie(:);%serie deve ser vetor coluna
y = serie(k+1:end);

for i = 1:k
   x(:,i) = serie(k+1-i:end-i);
end

