%script surrcalcres
%
%display the results of the surrogate calculations in a table... or two

nn=[100:100:1000 2000:1000:10000];
files={'gold','djia','yen'};
algs={'alg0','alg1','alg2','pps'};

for dn=1:length(nn)
  for df=1:3,
    for da=1:4,
      %surrogate stuff  
      filename=['n',int2str(nn(dn)),'-',files{df},'-',algs{da}];
      load(filename);
      eval(['dc_',algs{da},'(df,dn)=sig;']);
      eval(['pe_',algs{da},'(df,dn)=(pe-mean(perr))./std(perr);']);
    end;
    
    if nn(dn)<6000,
        %modelling stuff
        filename=['n',int2str(nn(dn)),'-',files{df},'-model'];
        load(filename); 
        nc(df,dn)=length(rb_basis); %size of model
        mdl(df,dn)=rb_descr_length./length(rb_y); %"normalised" description length
        err(df,dn)=rms(rb_error');%./std(rb_y);  %normalised error 
        filename=['n',int2str(nn(dn)),'-',files{df},'-fit'];  
        load(filename);
        per(df,dn)=rms(zp-zt);%./std(zt); %normalised prediction error
        dir(df,dn)=sum(sign(zp.*zt)>0)./length(zp); %correct direction?
    end;
  end;
end;

%save answers
save answers dc_alg0 dc_alg1 dc_alg2 dc_pps pe_alg0 pe_alg1 pe_alg2 pe_pps nc mdl err per dir nn files algs


%figure time
fig1=figure;
fig2=figure;
lt={'y-','b-.','r--'};
lt2={'yo','bd','rp'};
for da=1:4,
    figure(fig1);
    subplot(4,1,da);hold on;
    dat=eval(['dc_',algs{da}]);
    for i=1:3,
        plot(dat(i,:),lt{i});
        ind=find(abs(dat(i,:))>3);
        plot(ind,dat(i,ind),'kp');
    end;hold off;
    xlabel('length');
    ylabel('deviation');
    title([algs{da},': correlation dimension (d_e=6, \tau=1, n=50)']);
    axis tight;box on;
    figure(fig2);
    subplot(4,1,da);hold on;
    dat=eval(['pe_',algs{da}]);
    for i=1:3,
        plot(dat(i,:),lt{i});
        ind=find(abs(dat(i,:))>3);
        plot(ind,dat(i,ind),'kp');
    end;hold off;
    xlabel('length');
    ylabel('deviation');
    title([algs{da},': nonlinear prediction error (d_e=6, \tau=1, n=50)']);
    axis tight;box on;
end;

figure;
subplot(311);hold on;
for i=1:3
    plot(mdl(i,:),lt{i});
end;hold off;
xlabel('length');
ylabel('normalised mdl');
subplot(312);hold on;
for i=1:3
    plot(err(i,:),lt{i});
end;hold off;
xlabel('length');
ylabel('in-sample prediction error');
subplot(313);hold on;
for i=1:3
    plot(nc(i,:),lt{i});
end;hold off;
xlabel('length');
ylabel('model size');

figure;
subplot(311);hold on;
for i=1:3
    plot(per(i,:),lt{i});
end;hold off;
xlabel('length');
ylabel('out of sample prediction error');
subplot(312);hold on;
for i=1:3
    plot(dir(i,:),lt{i});
end;hold off;
xlabel('length');
ylabel('proportion of "correct" predictions');
  
figure;
for i=1:3
    plot(dc_alg2(i,1:length(nc))',nc(i,:)',lt2{i});hold on;
end;
xlabel('significance of d_c (algorithm 2) in \sigma s');
ylabel('model size');
title('Correlation of model size and rejection of H_2');
    
    
    