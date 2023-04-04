
Nx = length(lags);
Nbins = 20;

%Obtem os centros dos bins, que devem ser comuns a todos os x para que
%se possa fazer a figura contour
min_bin = 1e30;
max_bin = 1e-30;
for i = 1:Nx
    [n,x] = hist(v_sur(i,:),Nbins);
    if x(1) < min_bin
        min_bin = x(1);
    end
    if x(end) > min_bin
        max_bin = x(end);
    end
end

bins = linspace(min_bin,max_bin,Nbins);
for i = 1:Nx
    [n,x] = hist(v_sur(i,:),bins);
    n_sur(:,i) = n';
end

figure;
[C,h] = contour(interp2(n_sur,4));
text_handle = clabel(C,h);
set(text_handle,'BackgroundColor',[1 1 .6],...
    'Edgecolor',[.7 .7 .7])

figure;
[x,y] = meshgrid(lags,bins);
contour(x,y,n_sur,5);


figure;
[x,y] = meshgrid(lags,bins);
contour3(interp2(n_sur,4),20);
