function y = previsaoAR(modelo,x)

parametros = modelo.parametros;
parametros = parametros(:)';%Vetor linha
x = x(:);

y = parametros * x;


end