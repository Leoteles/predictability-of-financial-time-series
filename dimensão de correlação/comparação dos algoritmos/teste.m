close all;
clear all;
clc;

x = randn(100,1);

for i = 1:10000;
    y(i) = x(randi(length(x)));
end


[mean(x) var(x)]

[mean(y) var(y)]

subplot(2,1,1);
hist(x);

subplot(2,1,2);
hist(y);