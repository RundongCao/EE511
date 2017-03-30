clear all;
clc
%Question2
r1 = 0.75;
r2 = 0.25;
flag = 0;
buffer1 = zeros(1,9);
buffer2 = zeros(1,9);
for p = 0.1:0.1:0.9
    Input1 = zeros(1,1000);
    Input2 = zeros(1,1000);
    for t = 1:1000
        if (rand()<p)
            Input1(t) = 1;
        end
        if (rand()<p)
            Input2(t) = 1;
        end
        if (rand()<r1)
            Input1(t) = 0;
        end
        if (rand()<r2)
            Input2(t) = 0;
        end
    end
    flag = flag + 1;
    buffer1(flag) = mean(Input1);
    buffer2(flag) = mean(Input2);
end
efficy = 1-(buffer1+buffer2)/2;
figure(1);
plot(0.1:0.1:0.9,buffer1,'--',0.1:0.1:0.9,buffer2)
xlabel('arrival probability');
ylabel('Nunmber of packets');
title('number of packets as a function of p');

p = 0.5;
efficy2 = zeros(1,1000);
buffer11 = zeros(1,1000);
buffer22 = zeros(1,1000);
packets = zeros(1,1000);
for kk = 1:1000
    Input1 = zeros(1,1000);
    Input2 = zeros(1,1000);
    for t = 1:1000
        if (rand()<p)
            Input1(t) = 1;
        end
        if (rand()<p)
            Input2(t) = 1;
        end
        if (rand()<r1)
            Input1(t) = 0;
        end
        if (rand()<r2)
            Input2(t) = 0;
        end
    end
    buffer11(kk) = mean(Input1);
    buffer22(kk) = mean(Input2);
    packets(kk) = 2-(buffer11(kk)+buffer22(kk));
    efficy2(kk) = packets(kk)/2;
end
efficy2 = sort(efficy2);
confidence_interval = [efficy2(25),efficy2(975)];
figure(2);
hist(packets);
xlabel('number of packets processed');
ylabel('Frequency');
title('distribution of number of packets processed');
