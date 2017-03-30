%This project works for Markov chains and discrete events
clear all;
clc
%Question1
Ts = 0;
t = 0;
T = 100;
i = 1;
lamda = 19;
%Non-homogenous Poisson process for arrivals
while(Ts(i)<T)
    while(t<T)
        u1 = rand();
        t = t - 1/lamda*log(u1);
        u2 = rand();
        if(mod(t,10)<5)
            lam_t = 4 + 3*mod(t,10);
        else
            lam_t = 19 - 3*(mod(t,10)-5);
        end
        if (u2<=lam_t/lamda)
            Ts(i+1) = t;
            i = i + 1;
            break;
        end
    end
end
Ts(i) = [];
count1 = i - 1;
%Inverse transform method for services
Ser = zeros(1,count1);
for kk = 1:count1
    x = rand();
    i = 1;
    F = 1 - exp(-(60/25)*i);%Exp distribution
    while(x>=F)
        i = i + 1;
        F = 1 - exp(-25*i);
    end
    Ser(kk) = i;
end
Ser = Ser/60;%translate from minutes to hours
%Caclulate times for break
arrivals = [Ts(2:end)-Ts(1:end-1),100-Ts(end)];
bk = 0;%Times for break
delay = 0;
for kk = 1:count1
    dis = arrivals(kk) - Ser(kk) + delay;
    wt = 0.3*rand();
    if(dis > 0)
        bk = bk + ceil(dis/wt);
    else
        delay = dis;
    end
end

    
