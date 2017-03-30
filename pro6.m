tic;
%This project works for continuous sampling
clear all;
clc
%Box Muller method
M1 = 1; % Mean of X
M2 = 2; % Mean of Y
V1 = 4; % Variance of X
V2 = 9; % Variance of Y
count = 1000000;
u1 = rand(count,1);
u2 = rand(count,1);
% Geberate X and Y that are N(0,1) random variables and independent
X = sqrt( - 2*log(u1)).*cos(2*pi*u2 ); 
Y = sqrt( - 2*log(u1)).*sin(2*pi*u2 );
% Scale them to a particular mean and variance 
x = sqrt(V1)*X + M1; % x~ N(M1,V1)
y = sqrt(V2)*Y + M2; % y~ N(M2,V2)
toc;

A = x + y;
C = cov(x,y);
sample_mean = mean(A);
sample_var = std(A).^2;
xn = -10:0.1:16;
yn = 2*count*normpdf(xn,M1+M2,sqrt(V1+V2));
figure(1);
hist(A);
hold on
plot(xn,yn);
xlabel('Samples');
ylabel('Frequency');
title('Histogram for A and theoretical normal pdf');


