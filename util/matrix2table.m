%Transforma uma matriz do matlab em uma tabela no formato LATEX
%Recebe como parametro um vetor ou matriz e retorna o codigo LATEX para a
%tabela correspondente
function tabela = matrix2table(x)
tabela = [];
for i = 1:size(x,1)%Para todas as linhas
    linha = sprintf('%g & ', x(i,:));
    %Retira o ultimo & que sobrou
    linha = linha(1:end-2);
    %Finaliza  a linha com duas barras
    linha = sprintf('%s \\\\ \r\n',linha);
    %tabela(i,:) = linha;
    tabela = [tabela linha];
end
%tabela = 0;

%Substitui o ponto decimal pela vírgula decimal
pontos = strfind(tabela, '.');
tabela(pontos) = ',';