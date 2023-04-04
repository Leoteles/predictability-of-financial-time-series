%cd ~/calculations/money

%figure 1
figure;
n=1000;
filename={'djia','yen','gold'};
tits={'DJIA','USDJPY','GOLD'}
for df=1:3,
    y=load([filename{df},'-all.dat']);
    if length(y)>n,
        y=y((end-n):end);
    end;
    y=diff(log(y));
    subplot(5,1,df);
    p=plot(y);
    set(p,'LineWidth',1);
    title(tits{df});
end;

%figure 2
figure;
n=1000;
filename='djia';
algs={'alg0','alg1','alg2','pps'};
tits={'Alg. 0','Alg. 1','Alg. 2','PPS'};
y=load([filename,'-all.dat']);
if length(y)>n,
    y=y((end-n):end);
end;
y=diff(log(y));
rho=findrho2(y,8,1);
[yp,yi]=pps(y,8,1,1000,rho);
subplot(5,1,1);
p=plot(shuffle(y));
set(p,'LineWidth',1);
title(tits{1});
subplot(5,1,2);
p=plot(surrogate(y,1));
set(p,'LineWidth',1);
title(tits{2});
subplot(5,1,3);
p=plot(surrogate(y,2));
set(p,'LineWidth',1);
title(tits{3});
subplot(5,1,4);
p=plot(yp);
set(p,'LineWidth',1);
title(tits{4});

%figure 3
figure;
thisfile='n1000-djia';
algs={'alg0','alg1','alg2','pps'};
tits={'Alg. 0','Alg. 1','Alg. 2','PPS'};
for a=1:4,
  load([thisfile,'-',algs{a}]);
  subplot(4,4,a);
  dimcontold(dim);hold on;
  plot(dc(:,1),dc(:,2),'k-');
  plot(dc(:,1),dc(:,2),'k*');hold off
  %  dimplot(dc,[],[],'k-','k*');
  title(['CD (',tits{a},')']);
  axis tight;
  subplot(4,4,a+4);
  [barh,barp]=hist(perr,20);
  bar(barp,barh,1,'y');
  hold on;
  p=plot([pe pe],[0 max(barh)+1],'k-');
  set(p,'LineWidth',2);
  axis([0.98*min(pe,min(barp)) 1.02*max(pe,max(barp)) 0 max(barh)+ 1]);
  xlabel('NLPE');
  title(['NLPE (',tits{a},')']);
  ylabel('population');
end;

%figure 3B... the additional figure
figure;

files={'n1000-arch','n1000-garch','n1000-egarch'};
proc={'ARCH','GARCH','EGARCH'};
algs={'alg0','alg1','alg2','pps'};
tits={'Alg. 0','Alg. 1','Alg. 2','PPS'};
for f=1:3,
  thisfile=files{f};
  for a=1:4,
  load([thisfile,'-',algs{a}]);
    subplot(4,4,a+(f-1)*4);
    dimcont(dim);hold on;
    plot(log(dc(1,:)),dc(2,:),'k-');
    plot(log(dc(1,:)),dc(2,:),'k*');
    hold off;
    title(['CD (',tits{a},')']);
    axis tight;
    if f==3,
      xlabel('log(\epsilon_0)');
    end;
  end;
  subplot(4,4,(f-1)*4+1);
  ylabel([proc{f},': d_c(\epsilon_0)']);
  
end;
subplot(444);
axis([-2.70200249775709  -1.29142631778423   2.94359391553925 ...
      5.39950238265241]);

%figure 4
figure;
dl=[];err=[];
for kkk=1:17,
    load(['thismodel-k',int2str(kkk)]);
    dl=[dl descr_length];
    err=[err rms(e')];
    plot(e);title(['thismodel-k',int2str(kkk)]);
    drawnow;
end;
subplot(211);
[ax,p1,p2]=plotyy(1:17,dl,1:17,err);
set(get(ax(1),'YLabel'),'String','description length');
set(get(ax(2),'YLabel'),'String','root-mean-square error');
xlabel('model size');
set(p2,'LineStyle','-.');

%figure 5
figure;
load answers
tits={'DJIA','USDJPY','GOLD'}
ii=[2 3 1];
for i=1:3
    subplot(5,1,i)
    plot(nc(ii(i),:));
    ylabel('model size');
    title(tits{i});
    set(gca,'XLim',[1 14]);
    set(gca,'YLim',[0 25]);
    set(gca,'XTick',1:14);
    set(gca,'XTickLabel',[100:100:900 1000:1000:5000]);
end;
xlabel('length');

%figure 6
figure;
for i=1:3
    subplot(5,1,i);
    plot(per(ii(i),:),'-.');hold on;
    plot(err(ii(i),:),'-');hold off;
    title(tits{i});
    ylabel('prediction error');
    set(gca,'XLim',[1 14]);
    set(gca,'YLim',[0 1.5e-2]);
    set(gca,'XTick',1:14);
    set(gca,'XTickLabel',[100:100:900 1000:1000:5000]);
end;
xlabel('length');

%figure 7
figure;
lt2={'ko','bd','rp'};
for i=1:3
    plot(dc_alg2(i,1:length(nc))',nc(i,:)',lt2{i});hold on;
end;
xlabel('significance of d_c (algorithm 2) in \sigma s');
ylabel('model size');
title('Correlation of model size and rejection of H_2');
grid on;

%cd ~/manuscripts/money


