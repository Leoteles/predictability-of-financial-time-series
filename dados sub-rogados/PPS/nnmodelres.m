cd ~/calculations/money

nn=[100:100:1000 2000:1000:10000];
files={'gold','djia','yen'};
algs={'alg0','alg1','alg2','pps'};

%get all the stuff
load answers
for dn=1:length(nn),
  for df=1:3,
    if 0,
    for da=1:4,
      %surrogate stuff  
      filename=['n',int2str(nn(dn)),'-',files{df},'-',algs{da}];
      load(filename);
      eval(['dc_',algs{da},'(df,dn)=sig;']);
      eval(['pe_',algs{da},'(df,dn)=(pe-mean(perr))./std(perr);']);
    end;
    end;
    
    if nn(dn)<6000,
        %modelling stuff
        filename=['n',int2str(nn(dn)),'-',files{df},'-nnmodel'];
        load(filename); 
        nc(df,dn)=length(rb_basis); %size of model
        mdl(df,dn)=rb_descr_length./length(rb_y); %"normalised" description length
        err(df,dn)=rms(rb_error');%./std(rb_y);  %normalised error 
        filename=['n',int2str(nn(dn)),'-',files{df},'-nnfit'];  
        load(filename);
        per(df,dn)=rms(zp-zt);%./std(zt); %normalised prediction error
        dir(df,dn)=sum(sign(zp.*zt)>0)./length(zp); %correct direction?
    end;
  end;
end;

%figure 5
figure;
%load answers
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
