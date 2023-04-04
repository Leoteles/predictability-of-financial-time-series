function erro = erro_rbf(sigma,Nneuronios, xtr, ydtr, xval, ydval)

sigma = sigma(:);

modelo = estimaModeloRBF(xtr,ydtr,Nneuronios,sigma);

yval = previsaoRBF(modelo,xval);

e = calculaErros(yval,ydval);
erro = e.rmse;

end

