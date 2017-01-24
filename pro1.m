%This project works for coin flips
clear all;
clc

%Question 1
coin_result1 = rand(1,50);%Simulate tossing a fair coin
coin_result1(coin_result1 >= 0.5) = 1;%Heads
coin_result1(coin_result1 < 0.5) = 0;%Tails
num_heads1 = sum(coin_result1);

run1 = stat_run(coin_result1);
longest_run = max(run1);
x1 = [0,1];
y1 = [1-num_heads1/50,num_heads1/50];
figure(1);
bar(x1,y1,0.5)
title('Bernoulli Outcomes for Qustion1');
%hist(coin_result1, [0,1]);

exp1 = zeros(1,20);
for kk = 1:20
    numheads = coin_flip();
    exp1(kk) = numheads;
end
figure(2);
bar(exp1,0.5)
title('The number of heads for repeating 20 times');

exp2 = zeros(1,100);
for kk = 1:100
    numheads = coin_flip();
    exp2(kk) = numheads;
end
figure(3);
bar(exp2,0.5)
title('The number of heads for repeating 100 times');

exp3 = zeros(1,200);
for kk = 1:200
    numheads = coin_flip();
    exp3(kk) = numheads;
end
figure(4);
bar(exp3,0.5)
title('The number of heads for repeating 200 times');

exp4 = zeros(1,1000);
for kk = 1:1000
    numheads = coin_flip();
    exp4(kk) = numheads;
end
figure(5);
bar(exp4,0.5)
title('The number of heads for repeating 1000 times');

%Question 2
coin_result2 = rand(1,200) >= 0.2;%Biased coin where P[Head]=0.8
num_heads2 = sum(coin_result2);
run2 = stat_run(coin_result2);
longest_run2 = max(run2);
figure(6);
x2 = [0,1];
y2 = [1-num_heads2/200,num_heads2/200];
bar(x2,y2,0.5)
title('Bernoulli Outcomes for Qustion2');

%Question 3
coin_result3 = rand(1,100) > 0.5;
run3 = stat_run(coin_result3);
run3(run3==0)=[];
figure(7);
hist(run3,1:max(run3))
title('The Heads Run Length for tossing a fair coin 100 times');
xlabel('Run Length');
ylabel('Frequency');

%Question 4
x = input('Type a specified positive number of heads:\n');
num_heads4 = 0;
num_tosses = 0;
while(num_heads4 < x)
    if(rand() > 0.5)
        num_heads4 = num_heads4 + 1;
    end
    num_tosses = num_tosses + 1;
end
disp('Number of tosses until reaching a user-specified positive number of heads')
disp(num_tosses)
