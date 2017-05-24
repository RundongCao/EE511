%This project works for Markov Chain Monte Carlo
clear all;
clc
% %Q1(a)
% g1 = @(x)exp(sum(5*abs(x-5)));
% N = 1000; X1 = g1(rand(2,N)); % Simple MC
% disp([mean(X1) std(X1)/sqrt(N)])
% 
% K = 10; Nij = N/K^2; % Stratified
% for i = 1:K
%     for j = 1:K
%         XS1 = g1([i-1+rand(1,Nij);j-1+rand(1,Nij)]/K);
%         XSb1(i,j) = mean(XS1); SS1(i,j) = var(XS1);
%     end
% end, SST1 = mean(mean(SS1/N));
% disp([mean(mean(XSb1)) 2*sqrt(SST1) ])
% %Importance
% U = rand(2,N);
% e = exp(1); X2 = log(1+(e-1)*U);
% T1 = (e-1).^2*exp(sum(5*abs(X2-5))-sum(X2));
% disp( [mean(T1) std(T1)/sqrt(N)])
% 
% %Q1(b)
% g2 = @(x)4*cos(pi + sum(5*x));
% N = 1000; X11 = g2(2*rand(2,N)-1); % Simple MC
% disp([mean(X11) std(X11)/sqrt(N)])
% 
% K = 10; Nij = N/K^2; % Stratified
% for i = 1:K
%     for j = 1:K
%         XS2 = g2(2*[i-1 + rand(1,Nij);j-1 + rand(1,Nij)]/K - 1);
%         XSb2(i,j) = mean(XS2); SS2(i,j) = var(XS2);
%     end
% end, SST2 = mean(mean(SS2/N));
% disp([mean(mean(XSb2)) 2*sqrt(SST2) ])
% %Importance
% U = rand(2,N);
% e = exp(2); X12 = -1 + log(1+(e-1)*U);
% T2 = ((e-1)/exp(1)).^2*cos(pi + sum(5*X12)).*exp(-sum(X12));
% disp( [mean(T2) std(T2)/sqrt(N)])

%Question2
% N = 10000;
% n = 3;
% c = 15;
% X = ones(1,n);
% for m = 1:N %Gibbs Sample
%     i = ceil(n*rand);
%     S = sum(X) - X(i);
%     X(i) = max(c-S,0) - log(rand)/i;
%     H(m) = S + i*X(i);
% end
% gibs = [mean(H) std(H)/sqrt(N)];
% %MC
% N = 10000000;
% XR = -diag(1./(1:n))*log(rand(n,N));
% S = sum(XR);
% H = S.*(S>15)/mean(S>15);
% MC = ([mean(H) std(H)/sqrt(N)]);

%Q(b)
% N2 = 10000;
% n2 = 3;
% c2 = 1;
% X2 = ones(1,n2);
% for m2 = 1:N2 %Gibbs Sample
%     i2 = ceil(n2*rand);
%     S2 = sum(X2) - X2(i2);
%     X2(i2) = min(c2-S2,0) - log(rand)/i2;
%     H2(m2) = S2 + i2*X2(i2);
% end
% gibs2 = [mean(H2) std(H2)/sqrt(N2)];
% %MC
% N2 = 10000000;
% XR2 = -diag(1./(1:n2))*log(rand(n2,N2));
% S2 = sum(XR2);
% H2 = S2.*(S2<1)/mean(S2<1);
% MC2 = ([mean(H2) std(H2)/sqrt(N2)]);

%Question3
% d = 2;
% x1 = linspace(-500,500); % Generate a row vector of 100 linearly equally spaced points between -512 and 512
% x2 = linspace(-500,500); % Generate a row vector of 100 linearly equally spaced points between -512 and 512
% [X1,X2] = meshgrid(x1,x2);  % Obtain 100x100 pairs of points in matrix form from vectors x and y
% Z = 418.9829*d - (X1.*sin(sqrt(abs(X1))) + X2.*sin(sqrt(abs(X2))));% Compute f(x,y) in matrix form
% 
% figure(1)
% contour(X1,X2,Z); % Plot a contour plot
% colorbar;
% 
% figure(2)
% mesh(X1,X2,Z); % Plot a mesh plot
% colorbar;
% xlim([-500 500]);
% ylim([-500 500]);
% 
% d = 2;
% fx = @(x1,x2)418.9829*d - (x1.*sin(sqrt(abs(x1))) + x2.*sin(sqrt(abs(x2))));
% %min_result = zeros(1,1000);
% %for repeat = 1:1000
%     X = [0,0];%Starting Point
%     N = 1000;
%     T0 = 100;
%     T = T0;
%     count = 0;
%     for t = 1:N
%         X_new = X + 100*randn(1,2);
%         if ((X_new(1) < -500)||(X_new(2) < -500)||(X_new(1) > 500)||(X_new(2) > 500))
%             continue;
%         end
%         delta = fx(X_new(1),X_new(2))-fx(X(1),X(2));
%         alpha = exp(-delta/T);
%         if (delta < 0)
%             X = X_new;
%             count = count + 1;
%             Path(count,:) = X;
%         else
%             if (rand < alpha)
%                 X = X_new;
%                 count = count + 1;
%                 Path(count,:) = X;
%             end
%         end
%         %T = T0/log(t+1);%log
%         T = T0*exp(-0.01*sqrt(t)).^t;%exp
%         %T = T0 - (T0/N)*t;%poly
%     end
%     min_result = fx(X(1),X(2));
%     accept_rate = count/N;
% %end
% %hist(min_result)

%Question4
name = importdata('E:\USC_class\EE511\pro8\uscap_name.txt');
city = importdata('E:\USC_class\EE511\pro8\uscap_xy.txt');
n = size(city,1);
flag = 0;
for i = 1:n
    if(strcmp(name(i),'Juneau, Alaska')||strcmp(name(i),'Honolulu, Hawaii'))
        city(i+flag,:) = [];
        flag = flag - 1;
    end
end
n = size(city,1);

distance = pdist2(city, city);
% Parameters
num_iter = 1000; % number of iterations
c = 200;
% Initial path p
p = 1:n;
% Initial length of p
len = 0;
for a1 = 1:n-1
    len = len + distance(p(a1),p(a1+1));
end
len = len + distance(p(n),p(1));

% Save the paths and lengths
pathHistory = zeros(num_iter,n);
lenHistory = zeros(1,n);

% Plotting intial path
figure(1)
plot(city(:,1), city(:,2), 'ro');
%xlim([0 5]);
%ylim([1 6]);
hold on
line(city([p(:); p(1)],1), city([p(:); p(1)],2));
title('Initial path');
hold off

count = 0;

while(count<num_iter)
    count = count + 1;
    % Create path p2 by randomly swap two cities
    swap_index = randsample(n,2);
    p2 = p;
    temp = p2(swap_index(1));
    p2(swap_index(1)) = p2(swap_index(2));
    p2(swap_index(2)) = temp;
    % Cost of p2
    len2 = 0;
    for a1 = 1:n-1
        len2 = len2 + distance(p2(a1),p2(a1+1));
    end
    len2 = len2 + distance(p2(n),p2(1));

    q = (1+count)^((len - len2)/c);
    
    if len2 - len <= 0
        p = p2;
        len = len2;
    else
        if rand <= q
            p = p2;
            len = len2;
        end
    end
    pathHistory(count,:) = p;
    lenHistory(count) = len;
end

figure(2)
plot(1:num_iter, lenHistory, 'linewidth',2);
title('Length of path in each iteration')

figure(3)
plot(city(:,1), city(:,2), 'ro');
%xlim([0 5]);
%ylim([1 6]);
hold on
line(city([p(:); p(1)],1), city([p(:); p(1)],2));
title('Final path of TSP using simulated annealing');
hold off
