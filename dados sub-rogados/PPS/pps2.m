
% function [yp,yi]=pps(y,de,tau,n,rad);
%                 =pps(y,emb,[],n,rad);
%
% n-point PPS (pseudo-periodic surrogate) of y, embedding with de and
% tau. Randomised with radius rad.
% yp is the surrogate, yi is the indices of the embedded version of 
% y selected for the surrogate
% emb is a (vector embedding strategy.
% emb=[0:tau:(de-1)*tau] is equivalent to providing de and tau
%
% Implmenented in PPS.C
%
% MS 5/1/00




