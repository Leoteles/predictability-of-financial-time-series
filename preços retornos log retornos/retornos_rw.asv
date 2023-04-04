close all;
clear all;
clc;

%Situação 1: 
%Constroi uma sequencia de retornos iid gaussianos e apartir daí
%uma sequencia de precos. Os retornos são dados em log do retorno. Uma
%caracteristica dessa abordagem é fazer com que os retornos sejam
%simétricos em relação a mudança de preços. Ou seja, para se sair de um
%preço x para outro preço y, ou para se sair do preço y para o preço x, o
%módulo do retorno é o mesmo. São feitas N_mc simulações. O numero de
%elementos de cada simulação é variado. Assim, espera-se que quanto maior o
%numero de elementos de cada situação(tamanho do vetor de retornos), mais o
%preço tem chance de variar. 




N_mc = 1000;%Numero de simulacoes
variancia_retornos = 0.001;
randn('state',0);
preco_inicial = 300;

for N = 10:10:1000%Numero de elementos em cada simulação
    for mc = 1:N_mc
        ret = randn(N,1).*sqrt(variancia_retornos);
        precos = ret2price(ret,preco_inicial);
        valores_finais(mc) = precos(end);
        media(mc) = mean(valores_finais);
    end

    min_bin = preco_inicial - (preco_inicial*0.5);
    max_bin = preco_inicial + (preco_inicial*0.5);
    bins = linspace(min_bin,max_bin,50);
    freq(N,:) = hist(valores_finais,bins);
    %bar(bins,freq);
    
    %Parametros para uma modelagem gaussiana
    gauss(N,:) = gaussmf(bins,[std(valores_finais) mean(valores_finais)]);
    
    N
end

figure;
surf(gauss);



%Situação 2: 
%Constroi uma sequencia de retornos iid gaussianos e apartir daí
%uma sequencia de precos. Os retornos são dados em log do retorno. Uma
%caracteristica dessa abordagem é fazer com que os retornos sejam
%simétricos em relação a mudança de preços. Ou seja, para se sair de um
%preço x para outro preço y, ou para se sair do preço y para o preço x, o
%módulo do retorno é o mesmo. São feitas N_mc simulações. O numero de
%elementos de cada simulação é variado. Assim, espera-se que quanto maior o
%numero de elementos de cada situação(tamanho do vetor de retornos), mais o
%preço tem chance de variar. 




N_mc = 1000;%Numero de simulacoes
variancia_retornos = 0.001;
randn('state',0);
preco_inicial = 300;

for N = 10:10:1000%Numero de elementos em cada simulação


    for mc = 1:N_mc
        ret = randn(N,1).*sqrt(variancia_retornos);
        precos(1) = preco_inicial;
        for i = 2:N
            precos(i) = precos(i-1) * (1+ret(i));
        end
        valores_finais(mc) = precos(end);
        media(mc) = mean(valores_finais);
    end

    min_bin = preco_inicial - (preco_inicial*0.5);
    max_bin = preco_inicial + (preco_inicial*0.5);
    bins = linspace(min_bin,max_bin,50);
    freq(N,:) = hist(valores_finais,bins);
    %bar(bins,freq);
    
    %Parametros para uma modelagem gaussiana
    gauss(N,:) = gaussmf(bins,[std(valores_finais) mean(valores_finais)]);
    
    N
end



figure;
surf(gauss);
