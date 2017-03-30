%Question3
clear all;clc;

alpha = 0.5;
beta = 0.75;
gamma = 1;
delta = 0;
length = 10000;
varargin = [1,length];
x1 = -1000000:1000:1000000;

X1 = stblrnd(alpha,beta,gamma,delta,varargin);
p1 = length*stblpdf(x1,alpha,beta,gamma,delta,varargin);

x2 = -10000:100:10000;
alpha = 1;
X2 = stblrnd(alpha,beta,gamma,delta,varargin);
p2 = length*stblpdf(x2,alpha,beta,gamma,delta,varargin);

x3 = -15:0.1:15;
alpha = 1.8;
X3 = stblrnd(alpha,beta,gamma,delta,varargin);
p3 = length*stblpdf(x3,alpha,beta,gamma,delta,varargin);

x4 = -10:0.1:10;
alpha = 2.0;
X4 = stblrnd(alpha,beta,gamma,delta,varargin);
p4 = length*stblpdf(x4,alpha,beta,gamma,delta,varargin);

figure(1);
subplot(2,2,1);
hist(X1);
hold on 
plot(x1,p1);
xlabel('sample value');
ylabel('Frequency');
title('alpha stable pdfs for a=0.5');

subplot(2,2,2);
hist(X2);
hold on 
plot(x2,p2);
xlabel('sample value');
ylabel('Frequency');
title('alpha stable pdfs for a=1');

subplot(2,2,3);
hist(X3);
hold on
plot(x3,p3);
xlabel('sample value');
ylabel('Frequency');
title('alpha stable pdfs for a=1.8');

subplot(2,2,4);
hist(X4);
hold on
plot(x4,p4);
xlabel('sample value');
ylabel('Frequency');
title('alpha stable pdfs for a=2.0');

%time series plot
t = 1:length;
figure(2);
subplot(2,2,1);
plot(t,X1);
xlabel('Samples');
ylabel('Sample value');
title('time series plot for a=0.5');
subplot(2,2,2);
plot(t,X2);
xlabel('Samples');
ylabel('Sample value');
title('time series plot for a=1');
subplot(2,2,3);
plot(t,X3);
xlabel('Samples');
ylabel('Sample value');
title('time series plot for a=1.8');
subplot(2,2,4);
plot(t,X4);
xlabel('Samples');
ylabel('Sample value');
title('time series plot for a=2.0');
