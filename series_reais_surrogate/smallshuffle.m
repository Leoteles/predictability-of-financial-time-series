function z = smallshuffle (serie,Nsur)

serie =  serie(:);

%Par�metro de dispers�o do algoritmo
A = 1;

for sur = 1:Nsur
    
    %Vetor de �ndices da s�rie original
    i = (1:length(serie))';
    %Vetor de perturba��o
    g = randn(length(serie),1);
    %Vetor de �ndices perturbado
    i2 = i + A * g;
    %Ordena i2
    [i2_ord,i_hat] = sort(i2);
    %Gera dados subrogados
    z(:,sur) = serie(i_hat);
end