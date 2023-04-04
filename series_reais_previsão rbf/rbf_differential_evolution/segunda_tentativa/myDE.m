%function [x, f] = myDE(funcao, opcao_grafica,limPop)
%
% Onde:
% x = Valor da solução ótima encontrada
% f(x) = Valor da função no ponto ótimo encontrado
% funcao = handle da funcao a ser minimizada Ex.: @teste
% opcao_grafica = 0 (não plota), 1 (plota) { O gráfico deve mostrar a
%   evolução da função objetivo do melhor indivíduo em termos do número 
%   de gerações}
% limPop = matriz com o limite da populacao:
%    Ex.: limPop = repmat([-10 10],[nVar 1]);
%         nesse caso, todas as variáveis devem estar entre -10 e 10
function [x, f] = myDE(funcao, opcao_grafica, limP,maxGer)

global nVar nPop limPop Cr F K pF fobj;
limPop = limP;
fobj = funcao;


Cr = 0.1;%Probabilidade de crossover
F = 1;%Constante de ponderação de diferenças do algoritmo
K = 0.5 * (F + 1);
pF = 0.7;

%maxGer = 56;

nVar = size(limPop,1); %Dimensão da função

%pg. 6 Advances in DE
nPop = 9*nVar;


%Executa o algoritmo
[melhoresIndividuos, melhoresFits] = DE(maxGer);


%Plota os resultados
if (opcao_grafica)
    figure;
    plot(melhoresFits,'-r','LineWidth',2);
    grid minor;
    title('Melhor indivíduo');
    xlabel('Gerações');
    ylabel('Desempenho');
    legend('Função objetivo');
end


%Retorna os resultados
x = melhoresIndividuos(:,end);
f = melhoresFits(end);
end


%Algoritmo Differential Evolution
function [melhoresIndividuos, melhoresFits] = DE(maxGer)
global limPop nVar nPop Cr F K pF fobj;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Cria a população inicial%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D = size(limPop,1); %Numero de variaveis (dimensões)de cada individuo
% População inicial (geração 1)
range = (limPop(:,2) - limPop(:,1));%Maximo - minimo
minimo = limPop(:,1);
%Cria população inicial
popIni = rand(D,nPop);%Matriz de variaveis dos individuos
%Matriz de individuos espalhados aleatoriamente e uniformemente pelo
%espaço de entrada
%A geracao corresponde a terceira dimensão da matriz populacao. No caso,
%esta é a geração 1.
%Os individuos estão organizados em:
%populacao(variavel,individuo,geracao)
ger = 1;
for ind = 1:nPop
    populacao(:,ind,ger) = popIni(:,ind) .* range + minimo;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% Inicio do algoritmo %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ger = 0;
while (ger<=maxGer)    
    ger = ger + 1;
    %clc
    ger
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Calcula fitness%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %h é a func. pseudo-objetivo (com restrições)
    if ger==1
        for ind = 1:nPop
            f(1,ind) = feval(fobj,populacao(:,ind,ger));
        end
    end
    
    %Ordena f
    [fOrd,iFOrd] = sort(f);
    melhoresFits(ger) = f(iFOrd(1));
    melhoresIndividuos(:,ger) = populacao(:,iFOrd(1),ger);

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Calcula nova geração%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for ind = 1:nPop%Para todos os individuos
    
        %%%Mutação
        %%%%%%%%%%    
        %Melhores ou iguais a "ind"
        melhoresQueInd = iFOrd(1:find(iFOrd==ind));
        %Escolhe aleatoriamente um dos que são melhores ou iguais para ser
        %o r0
        r = randperm(length(melhoresQueInd)); r = r(1);
        iR0 = melhoresQueInd(r);%Indice do r0
        r0(:,1) = populacao(:,iR0,ger);
        
        %Escolhe r1 e r2 aleatoriamente, diferentes entre si e diferentes
        %de r0
        %Retira r0 e ind da busca aleatória para r1 e r2
        pop = 1:nPop;
        pop = pop(pop~=iR0);%pop sem r0
        pop = pop(pop~=ind);%pop sem r0 e sem ind
        %Sorteia indices aleatorios para r1 e r2
        r = randperm(length(pop));
        iR1 = pop(r(1));%indice aleatório para r1
        iR2 = pop(r(2));%indice aleatório para r2
        r1(:,1) = populacao(:,iR1,ger);
        r2(:,1) = populacao(:,iR2,ger);
        
        %Monta vetor de evolução diferencial
        if rand < pF %Mutação ou recombinação (pg.118)
            v = r0 + F * (r1 - r2);
        else
            v = r0 + K * (r1 + r2 - 2 * r0);
        end
            

        %Garante que ao menos uma variável (varRand) sofrerá mutação
        varRand = randperm(nVar); varRand = varRand(1);
        for var = 1:nVar
            %Realiza a mutação, dependendo do parametro Cr
            if (rand <= Cr) || (var == varRand)
                u(var,1) = v(var);%Usa variavel do individuo de teste v
            else
                u(var,1) = populacao(var,ind,ger);%Usa a variavel do individuo da pop. atual
            end
        end
    


        %Testa se o indíviduo teste está dentro do espaço permitido e o coloca
        %se não estiver
        for var = 1:nVar
            if u(var) < limPop(var,1)%Variavel i, mínimo
                u(var) = limPop(var,1);%Recalcula u0
            end
            if u(var) > limPop(var,2)%Variavel i, máximo
                u(var) = limPop(var,2);%Recalcula u0
            end
        end
        
        %Calcula o desempenho do novo individuo u
        fU = feval(fobj,u);
        %Compara individuo existente (ind) com o novo individuo (u)
        %Retem o de maior fitness (elitismo implicito)
        %%%Seleção
        %%%%%%%%%%    
        if (fU < f(ind))
            %disp('Substitui indivíduo e seu desempenho')
            populacao(:,ind,ger+1) = u;
            f(ind) = fU;
            f(ind) = fU;
        else
            %disp('Mantém indivíduo')
            populacao(:,ind,ger+1) = populacao(:,ind,ger);
        end
        
    end
    
    
    
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%