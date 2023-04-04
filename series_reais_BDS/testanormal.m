function resultados = testanormal(x)
% %h = 0 -> n�o rejeita a hipotese de que � normal
% %h = 1 -> rejeita a hipotese de que � normal
% %com intervalo de confian�a de 95%
%Se k>c, rejeita a hipotese de gaussianidade
%Lilliefors test
[hli pli kli cli] = lillietest(x);
%Jarque-Bera test
[hjb pjb kjb cjb] = jbtest(x);
%One-sample Kolmogorov-Smirnov test
[hks,pks,kks,cks] = kstest(x);

%So envia resultados do ks
resultados = [hks kks cks];