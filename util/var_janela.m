%Calcula a variancia em janelas
%serie = a serie a se estimar a variancia. Deve ser maior que t_jan
%t_jan = tamanho daq janela utilizada para se estimar a variancia
%function [var_jan] = varjanela(serie,t_jan)
function [var_jan] = varjanela(serie,t_jan)

N = length(serie)

for i=1:N-t_jan+1
    var_jan(i) = var(serie(i:t_jan+i-1));
end

