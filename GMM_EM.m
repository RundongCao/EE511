function [mu_out1,mu_out2,sigma_out1,sigma_out2,w_out] = GMM_EM (X,mu_try1,mu_try2,sigma_try1,sigma_try2,w_try)
%This function works for estimating GMM parameters by EM method
iter = size(X,2);

L0 = 0;
for i = 1:iter
    L0 = L0 + log((w_try(1)*fai(X(:,i),mu_try1,sigma_try1)+w_try(2)*fai(X(:,i),mu_try2,sigma_try2)));  
end
L0 = L0/iter;
r1 = zeros(1,iter);
r2 = zeros(1,iter);
threshold = 0.001;
for t = 1:100
    n = [0,0];
    for i = 1:iter
        r1(i) = (w_try(1)*fai(X(:,i),mu_try1,sigma_try1)/(w_try(1)*fai(X(:,i),mu_try1,sigma_try1)+w_try(2)*fai(X(:,i),mu_try2,sigma_try2)));
        n(1) = n(1) + r1(i);
    end
    for i = 1:iter
        r2(i) = (w_try(2)*fai(X(:,i),mu_try2,sigma_try2)/(w_try(1)*fai(X(:,i),mu_try1,sigma_try1)+w_try(2)*fai(X(:,i),mu_try2,sigma_try2)));
        n(2) = n(2) + r2(i);
    end
    
    w_try = n/iter;
    mu_try1 = 1/n(1)*(X*r1');
    mu_try2 = 1/n(2)*(X*r2');
    
    sigma_try1 = zeros(2,2);
    for i = 1:iter
        sigma_try1 = sigma_try1 + r1(i)*(X(:,i)-mu_try1)*(X(:,i)-mu_try1)';
    end
    sigma_try1 = sigma_try1/n(1);
    
    sigma_try2 = zeros(2,2);
    for i = 1:iter
        sigma_try2 = sigma_try2 + r2(i)*(X(:,i)-mu_try2)*(X(:,i)-mu_try2)';
    end
    sigma_try2 = sigma_try2/n(2);
    
    L1 = 0;
    for i = 1:iter
        L1 = L1 + log((w_try(1)*fai(X(:,i),mu_try1,sigma_try1)+w_try(2)*fai(X(:,i),mu_try2,sigma_try2)));  
    end
    if (abs(L1 - L0) <= threshold)
        break;
    end
    L0 = L1;
end
mu_out1 = mu_try1;
mu_out2 = mu_try2;
sigma_out1 = sigma_try1;
sigma_out2 = sigma_try2;
w_out = w_try;