function erro = erro_rbf(populacao,Nneuronios,xtr, ydtr, xval, ydval)

%Desconsiderando os primeiros Nneuronios(esses sao os sigmas), Ndelays �
%length(populacao)/Nneuronios
Ndelays = (length(populacao)/Nneuronios)-1;

sigma = populacao(1:Nneuronios);

centros = reshape(populacao(Nneuronios+1:end),Nneuronios,Ndelays);

modelo = estimaModeloRBF(xtr,ydtr,Nneuronios,sigma,centros);

yval = previsaoRBF(modelo,xval);

e = calculaErros(yval,ydval);
erro = e.rmse;

end

