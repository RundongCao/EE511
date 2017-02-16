%This project works for integrals and intervals
clear all;
clc
%Question1
fun1 = @(x) exp(x+x.^2);
fun2 = @(x) exp(-x.^2);
fun3 = @(x,y) exp(-(x+y).^2);
%Calculate the exact integrals
Theo1 = integral(fun1,-2,2);
Theo2 = integral(fun2,-inf,inf);
Theo3 = integral2(fun3,0,1,0,1);
%Monte Carlo simulation
I1 = zeros(1,100);
I2 = zeros(1,100);
I3 = zeros(1,100);
count1 = 0;
for N1 = 100:100:10000
    count1 = count1 + 1;
    I1(count1) = monte_carlo(-2,2,N1,fun1);
end
count1 = 0;
for N2 = 100:100:10000
    count1 = count1 + 1;
    I2(count1) = monte_carlo_inf(N2,fun2);
end
count1 = 0;
for N3 = 100:100:10000
    count1 = count1 + 1;
    I3(count1) = monte_carlo2(0,1,N3,fun3);
end
%Compare estimates with the exact values
err1 = (I1-Theo1)/Theo1;
err2 = (I2-Theo2)/Theo2;
err3 = (I3-Theo3)/Theo3;
N = 100:100:10000;
figure(1);
plot(N,err1,'r',N,err2,'g',N,err3,'b')
xlabel('Number of samples');
ylabel('relative error');
title('The relative errors between estimates and exact values');

%Question2
Z1 = randn(1,10);
Z2 = randn(1,10);
Z3 = randn(1,10);
Z4 = randn(1,10);
X = Z1.^2 + Z2.^2 + Z3.^2 + Z4.^2;
X = sort(X);
FX = [1/10:1/10:1];

figure(2)
stairs(X,FX,'b','linewidth',2);
hold on
grid on
Xchi2 = 0:0.01:16;
Ychi2 = chi2cdf(Xchi2,4);
plot(Xchi2,Ychi2,'r--','linewidth',2);
hold off
legend('Emirical cdf','Theoretical cdf');
title('Distribution of Chi2(4)');
xlabel('x');
ylabel('F(x)');

lower_bound = max(abs(FX-chi2cdf(X,4)));
Theo25 = chi2inv(0.25,4);
Theo50 = chi2inv(0.5,4);
Theo90 = chi2inv(0.9,4);
relative_err = [(0.5*(X(2)+X(3))-Theo25)/Theo25,(X(5)-Theo50)/Theo50,(X(9)-Theo90)/Theo90];

%Question3
object = importdata('faithful.dat.txt');
data3 = object.data;
wt = data3(1:15,3);
wt_bar = mean(wt);
wt_s = std(wt);
t_err = (wt_s/sqrt(15))*tinv(0.95,14);% 95%confidence
sc_interval = [wt_bar-t_err,wt_bar+t_err];
%bootstrap
b_mu = zeros(1,1000);
for kk = 1:1000
    index = ceil(15*rand(1,15));
    b_mu(kk) = mean(wt(index));
end
b_mu = sort(b_mu);
bc_interval = [b_mu(25),b_mu(975)];
%Repeat using all samples
wt2 = data3(:,3);
wt2_bar = mean(wt2);
wt2_s = std(wt2);
t_err2 = (wt2_s/sqrt(272)*tinv(0.95,271));
sc_interval2t = [wt2_bar-t_err2,wt2_bar+t_err2];
% z_err2 = (wt2_s/sqrt(272)*norminv(0.95,0,1));
% sc_interval2z = [wt2_bar-z_err2,wt2_bar+z_err2];
%bootstrap
b_mu2 = zeros(1,1000);
for kk = 1:1000
    index2 = ceil(272*rand(1,272));
    b_mu2(kk) = mean(wt2(index2));
end
b_mu2 = sort(b_mu2);
bc_interval2 = [b_mu2(25),b_mu2(975)];