function erro = erro_rbf(modelo, xval, ydval)

yval = previsaoRBF(modelo,xval);

e = calculaErros(yval,ydval);
erro = e.rmse;

end

