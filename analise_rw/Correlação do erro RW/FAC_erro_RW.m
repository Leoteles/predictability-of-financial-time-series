close all;
clear all;
clc;

load 'gbpusd';

serie = gbpusd;

prev_rw = serie(1:end-1);
prev_d = serie(2:end);

log_serie = log(serie);
prev_rw_log = log_serie(1:end-1);
prev_d_log = log_serie(2:end);


figure;
plot(prev_d,'-b');
hold on;
plot(prev_rw,'-r');
hold off;

figure;
plot(prev_d_log,'-b');
hold on;
plot(prev_rw_log,'-r');
hold off;

E_rw = (prev_d-prev_rw);
AE_rw = abs(E_rw);
E_rw_log = (prev_d_log-prev_rw_log);
AE_rw_log = abs(E_rw_log);

figure;
autocorr(price2ret(serie));
title('FAC retorno serie');

figure;
autocorr(E_rw);
title('FAC erro');

figure;
autocorr(E_rw_log);
title('FAC erro log(serie)');

figure;
autocorr(AE_rw);
title('FAC AE');

figure;
autocorr(AE_rw_log);
title('FAC AE log(serie)');
