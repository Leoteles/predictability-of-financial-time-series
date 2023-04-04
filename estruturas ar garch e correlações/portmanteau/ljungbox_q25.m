%Calcula a estatistica q modificada por Ljung e Box (1978) para se realizar
%o teste de portmanteau. Recebe como par�metro a s�rie.
%O resultado � um vetor q(m) em que m � o n�mero de atrasos at� 25
%q(end) � a estat�stica q calculada com o n�mero de atrasos fornecido
%para a fun��o.
%function q = ljungbox_q(vetor)
function q = ljungbox_q(vetor)

m = 25; %Numero de atrasos a serem calculados
nSTDs = 2;%Numero de desvios padrao para o intervalo de confian�a

%Gera FAC do vetor criado. A FAC � normalizada (ex. FAC(0) = 1)
[ACF,Lags,Bounds] = autocorr(vetor,m,nSTDs);
ACF = ACF(2:end);%Desconsidera-se ACF(1), equivalente a FAC(0), ou atraso = 0

%Calcula Q(m)
T = length(vetor);
N = [T - [1:m]]';%vetor de valores do denominado do somatorio N = T-1, T-2,...
somatorio = cumsum( (ACF.^2)./N );%somatorio calculado at� o atraso m
q = T * (T + 2) * somatorio;
