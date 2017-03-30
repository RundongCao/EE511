%Gamma sampling
clear all;clc

% Sample code to find the maximum ratio c
pdfX = @(x) 32/(945*sqrt(pi)) .* x.^(4.5) .* exp(-x); % one-line function handle for f
pdfY = @(y) 1/5.5 * exp(-y/5.5); % one-line function handle for g
t = 0:0.01:8;
ratio = pdfX(t)./pdfY(t);
c = max(ratio); % find the maximum ratio

% figure % visualize the distributions
% plot(t,pdfX(t),'b-.');
% hold on
% plot(t,pdfY(t),'r');
% plot(t,c * pdfY(t),'r--','linewidth',2);
% legend('pdf of Gamma(3/2,1)', 'pdf of Exponential(3/2)', 'c \cdot pdf of Exponential(3/2)')
% hold off
count1 = 1000;
count2 = 100;
check = 0;
i = 0;
X = zeros(1,count2);
while(i <= count1)
    u1 = rand();
    u2 = rand();
    Y = -5.5*log(u1);
    check = check + 1;
    if(u2 <= (0.0743/sqrt(pi))*(Y.^4.5)*exp(-9*Y/11))
        i = i + 1;
        X(i) = Y;
        if(i>=count2)
            break;
        end
    end
end
accept_rate = i/check;

figure(1);
hist(X);
hold on
xn = 0:0.1:16;
yn = count2*pdfX(xn);
plot(xn,yn);
xlabel('Samples');
ylabel('Frequency');
title('Histogram for A and theoretical normal pdf');
