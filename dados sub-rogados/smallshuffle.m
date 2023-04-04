function z = smallshuffle (serie,Nsur)

serie =  serie(:);

%Parâmetro de dispersão do algoritmo
A = 1;

for sur = 1:Nsur
    
    %Vetor de índices da série original
    i = (1:length(serie))';
    %Vetor de perturbação
    g = randn(length(serie),1);
    %Vetor de índices perturbado
    i2 = i + A * g;
    %Ordena i2
    [i2_ord,i_hat] = sort(i2);
    %Gera dados subrogados
    z(:,sur) = serie(i_hat);
end