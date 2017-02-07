%This project works for samples and statistics
clear all;
clc
%Question1
chips = [ones(1,6),zeros(1,119)];%1 represents defective, 0 represents good
num1 = 1000;
prob1 = zeros(1,100);
for exp1 = 1:100
    count = 0;
    for kk = 1:num1
        test1 = chips(randsample(size(chips,2),5));%without replacement
        if(sum(test1) > 0)
            count = count+1;
        end   
    end
    prob1(exp1) = count/num1;
end

prob11 = 0;
bad = 6;
while(prob11 < 0.95)
    count = 0;
    for kk = 1:num1
        test11 = chips(randsample(size(chips,2),bad));
        if(sum(test11) > 0)
            count = count+1;
        end
    end
    prob11 = count/num1;
    if(prob11 < 0.95)
        bad = bad + 1;
    end
end

%Theoretical probability for hypergeometric
prob12 = zeros(1,120);
for n1 = 1:120
    prob12(n1) = 1 - hygepdf(0,125,6,n1);
end
figure(1);
plot(1:120,prob12);
xlabel('test number');
ylabel('reject probability');
title('Theoretical probability for hypergeometric');
grid on

%Question2
lambda = 120;
N = 10000;
p = lambda/N;
arrivals = zeros(1,1000);
for kk = 1:1000
    u = rand(N,1);
    BernoulliTrials = u<p;
    arrivals(kk) = sum(BernoulliTrials);
end
X2 = 80:160;
[nelement,centers] = hist(arrivals,X2);
pmf_P = poisspdf(X2,lambda);
figure(2);
plotyy(X2,nelement,X2,pmf_P,'bar','plot');
title('Number of arrivals for BernoulliTrials');
xlabel('number of arrivals');
ylabel('frequency');

x_arrival = rand(1,1000);
for kk = 1:1000
    i = 0;
    p2 = exp(-lambda);
    F = p2;
    while(x_arrival(kk)>= F)
        p2 = lambda*p2/(i+1);
        F = F + p2;
        i = i + 1;
    end
    x_arrival(kk) = i;
end
[nelement2,centers] = hist(x_arrival,X2);
figure(3);
plotyy(X2,nelement2,X2,pmf_P,'bar','plot');
title('Number of arrivals for Possion random samples');
xlabel('number of arrivals');
ylabel('frequency');

%Question3
N1 = zeros(1,100);
for count1 = 1:100
    sum1 = 0;
    while(sum1 <= 4)
        N1(count1) = N1(count1) + 1;
        sum1 = sum1 + rand();
    end
end
EN1 = mean(N1);
figure(4);
hist(N1);
title('100 samples for N');
xlabel('N');
ylabel('Frequency');

N2 = zeros(1,1000);
for count2 = 1:1000
    sum2 = 0;
    while(sum2 <= 4)
        N2(count2) = N2(count2) + 1;
        sum2 = sum2 + rand();
    end
end
EN2 = mean(N2);
figure(5);
hist(N2);
title('1000 samples for N');
xlabel('N');
ylabel('Frequency');

N3 = zeros(1,10000);
for count3 = 1:10000
    sum3 = 0;
    while(sum3 <= 4)
        N3(count3) = N3(count3) + 1;
        sum3 = sum3 + rand();
    end
end
EN3 = mean(N3);
figure(6);
hist(N3);
title('10000 samples for N');
xlabel('N');
ylabel('Frequency');

%Question 4
temp4 = 0;
for j = 1:60
    temp4 = temp4 + 1/j;
end
p4 = 1/(temp4);%Calculate the constant p

X_seq = rand(1,1000);
for kk = 1:1000
    j = 1;
    F = p4/j;
    while(X_seq(kk)>= F)
        j = j + 1;
        F = F + p4/j;
    end
    X_seq(kk) = j;
end
figure(7);
hist(X_seq,1:60);
title('Histogram for sequence Xk');
xlabel('Xk');
ylabel('Frequency');

N60 = zeros(1,1000);
for kk = 1:1000
    count4 = 0;
    j2 = 1;
    while(j2~=60)
        j2 = 1;
        F = p4/j2;
        X_K = rand();
        count4 = count4 + 1;
        while(X_K >= F)
            j2 = j2 + 1;
            F = F + p4/j2;
        end
        if j2==60
            N60(kk) = count4;
        end
    end
end
EN60 = mean(N60);
VarN60 = std(N60).^2;
figure(8);
hist(N60,[1:20:(max(N60)+20)]);
title('Histogram for N60');
xlabel('Samples N60');
ylabel('Frequency');

%Question5
p5 = [0.06,0.06,0.06,0.06,0.06,0.15,0.13,0.14,0.15,0.13];
q5 = 0.05;
c = max(p5)/q5;
N5 = 10000;
out5 = zeros(1,N5);
count5 = zeros(1,N5);
for i = 1:N5
    k = 0;
    while(1)
        k = k + 1;
        j = 1 + floor(20*rand());
        if (j <= 10)
            if (c*rand()) < p5(j)/q5
                out5(i) = j;
                count5(i) = k;%count the number of (accepted+rejected)
                break
            end
        end
    end
end
E_theo = sum(p5.*[1:10]);
E_sample = mean(out5);
Var_theo = sum(p5.*([1:10].^2))-E_theo.^2;
Var_sample = std(out5).^2;
efficiency = 10000/sum(count5);

figure(9);
X5 = 1:10;
[bar5] = hist(out5,1:10);
bar(X5,bar5,'g');
hold on
plot(X5,p5.*N,'r');
title('Histogram for samples and target distribution');
xlabel('random variable');
ylabel('Frequency');
