function surrcalcfigs(n);

% function surrcalcfigs(n);
%
% figures for completed surrogate calculations (all of them) 
% as a function of the length of data n
% for financial data

if nargin<1,
   n=1000;
end;

%test llpred surrogate
%names={'gold','djia','yen'};
names={'arch','garch','egarch'};
algs={'alg0','alg1','alg2','pps'};

fig1=gcf;
fig2=figure;

for nn=1:3,
    for a=1:4,
        thisfile=['n',int2str(n),'-',names{nn},'-',algs{a}];
        load(thisfile);
        figure(fig1);
        subplot(4,3,3*(a-1)+nn);
        dimcont(dim);
%        dimplot(dc,[],[],'k-.','k:');
hold on;
plot(log(dc(1,:)),dc(2,:),'k-');
        axis tight;
        title(thisfile);
        figure(fig2);
        subplot(4,3,3*(a-1)+nn);
        [barh,barp]=hist(perr,20);
        bar(barp,barh,1,'y');
        hold on;
        p=plot([pe pe],[0 max(barh)+1],'k-');
        set(p,'LineWidth',2);
        axis([0.98*min(pe,min(barp)) 1.02*max(pe,max(barp)) 0 max(barh)+1]);
        title(thisfile);
        xlabel('nonlinear prediction error');
        ylabel('population');
   end;
end;

