%This project works for sampling
clear all;
clc

%Question1
sample1 = 5*rand(1,1000)-3;%simulate sampling uniformly on the interval [-3,2]

figure(1);
hist(sample1)
title('Histogram of the outcomes for uniform sample');
xlabel('Sample value');
ylabel('Frequency');

sample_mean = mean(sample1);
sample_var = std(sample1).^2;
mean1 = zeros(1,1000);
var1 = zeros(1,1000);
for kk = 1:1000
    sample = 5*rand(1,1000)-3;
    mean1(kk) = mean(sample);
    var1(kk) = std(sample).^2;
end
mean1 = sort(mean1);
var1 = sort(var1);
interval_mean = [mean1(25),mean1(975)];% 95% confidence level
interval_var = [var1(25),var1(975)];

figure(2);
hist(mean1);
title('Histogram of sample mean for 1000 resamples');
xlabel('sample mean');
ylabel('Frequency');

figure(3);
hist(var1);
title('Histogram of sample variance for 1000 resamples');
xlabel('sample var');
ylabel('Frequency');

%Question2
X = rand(1,1000);%X(k)
Xnew = [0,X(1:999)];%X(k+1)
Cov_X = cov(X,Xnew);
%Compute a new sequence Y
Y = X - 2*[0,X(1:999)] + 0.5*[0,0,X(1:998)] - [0,0,0,X(1:997)];
Cov_XY = cov(X,Y);

%Question3
Out = floor(10*rand(1,1000));%sample with replacement from 0,1,2...9
[num,centers] = hist(Out);
figure(4);
bar(0:9,num)
title('Histogram of the outcomes');
xlabel('Sample value');
ylabel('Frequency');

num_theo = ones(1,10)*1000/10;%uniform distribution
ChisquaredTest = sum((num-num_theo).^2./num_theo);
ChisquaredThreshold_95 = chi2inv(0.95,9);
%Alternate distribution
ChisquaredTest2 = sum(([num(2:end),0]-num_theo).^2./num_theo);


