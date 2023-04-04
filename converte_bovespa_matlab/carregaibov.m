%Carrega os dados de ibov contidos nos xls
% disponibilizados pela BOVESPA
clc;
clear all;

indice = 1;

%Dados anteriores a 1998(1968 a 1997)
anoinicial = 1968;
anofinal = 1997;
for ano = anoinicial:anofinal
    histano = xlsread('IBOVDIA1968-1997.XLS',int2str(ano));
    histano = histano(1:31,:);%Retira as linhas a mais do arquivo original
    histano = histano(:,2:end);%retira a primeira coluna, que indica o dia

    %Organiza as colunas da seguinte maneira, para todas as linhas:
    %ano | mês | dia | valor ibov |

    for j=1:size(histano,2)%Para cada coluna(mes)
        for i=1:size(histano,1)%Para cada linha da coluna j(dia)
            if (~isnan(histano(i,j)))%Se ha um valor neste dia...
                %histnovo(indice,:) = [ano j i hist(i,j)];
                hist(indice,:) = [ano j i histano(i,j)];
                indice = indice + 1;
            end
        end
    end
    clear histnovo;
    clear histano;
end

%Dados de 1998 a 2007
anoinicial = 1998;
anofinal = 2007;
for ano = anoinicial:anofinal
    histano = xlsread('IBOVDIA1998-2007.XLS',int2str(ano));
    histano = histano(1:31,:);%Retira a linhas a mais do arquivo original

    %Retira as colunas nao usadas do arquivo original
    i = 1;
    for j = 1:2:size(histano,2)
        histnovo(:,i) = histano(:,j);
        i = i+1;
    end
    histano = histnovo(:,2:end);%retira a primeira coluna, que indica o dia
    clear histnovo;
    %Organiza as colunas da seguinte maneira, para todas as linhas:
    %ano | mês | dia | valor ibov |

    for j=1:size(histano,2)%Para cada coluna(mes)
        for i=1:size(histano,1)%Para cada linha da coluna j(dia)
            if (~isnan(histano(i,j)))%Se ha um valor neste dia...
                %histnovo(indice,:) = [ano j i hist(i,j)];
                hist(indice,:) = [ano j i histano(i,j)];
                indice = indice + 1;
            end
        end
    end
    clear histnovo;
    clear histano;
end

ibov = hist;


%save('ibovhist', 'ibov');