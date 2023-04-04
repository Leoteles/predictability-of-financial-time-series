%function [yp,yi]=pls(y,de,tau,n,rad);
%
% n-point PLS (pseudo-linear surrogate) of y, embedding with de and
% tau. Randomised with radius rad.
% yp is the surrogate, yi is the indices of the embedded version of 
% y selected for the surrogate
%
% Implmenented in PLS.C
%
% MS 5/1/00

