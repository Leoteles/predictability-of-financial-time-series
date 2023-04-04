function z = sinalAleatorio (serie,Nsur)

serie =  serie(:);

for i = 1:Nsur
    serie_sinal = randn(length(serie),1)>0;
    serie_sinal = 2*serie_sinal -1;
    serie_sinal = serie_sinal(:);
    z(:,i) = serie .* serie_sinal;
end