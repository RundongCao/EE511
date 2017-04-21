%This project works for expectation maximization
clear all;
clc
%Question1
mu = [1;2;3];
sigma = [3,-1,1;-1,5,3;1,3,4];
iter = 1000;
X = zeros(3,iter);
A = chol(sigma);

for i = 1:iter
    X(:,i) = A * randn(1,3)' + mu;
end
figure(1);
subplot(1,3,1);
hist(X(1,:));
subplot(1,3,2);
hist(X(2,:));
subplot(1,3,3);
hist(X(3,:));

%Question2
iter2 = 1000;
X2 = zeros(1,iter2);
for i = 1:iter2
    check = rand();
    if (check <= 0.4)%N(-1,1)
        X2(i) = randn() - 1;
    else%N(1,1)
        X2(i) = randn() + 1;
    end
end
mu2 = [-1;1];
sigma2 = 1;
p2 = [0.4,0.6];
x22 = -5:0.1:5;
y22 = p2(1)*normpdf(x22,mu2(1),sigma2)+p2(2)*normpdf(x22,mu2(2),sigma2);
y22 = iter2*y22;

figure(2);
hist(X2);
hold on
plot(x22,y22);

%Question3
iter = 300;
mu_in1 = [-5,5];
mu_in2 = [5,5];
sigma_in1 = [3,0;0,1];
sigma_in2 = [1,-2;-2,6];
w_in = [0.5,0.5];
obj = gmdistribution([mu_in1;mu_in2],cat(3,sigma_in1,sigma_in2),w_in);
X = random(obj,iter);
X = X';

w_try = [0.5,0.5];
sigma_try1 = [1,0;0,1];
sigma_try2 = [1,0;0,1];
mu_try1 = [-5;5];
mu_try2 = [5;5];
tic;
[mu_out1,mu_out2,sigma_out1,sigma_out2,w_out] = GMM_EM (X,mu_try1,mu_try2,sigma_try1,sigma_try2,w_try);
toc;

%Question4
object = importdata('faithful.dat.txt');
data4 = object.data;
X4 = data4(:,2:3);
[y,C] = kmeans(X4,2);
%Scatter Plot of the Data
figure(3);
subplot(1,2,1);
plot(X4(:,1),X4(:,2),'o');
title('Data Points without Labels');
xlabel('eruptions');
ylabel('waiting');
subplot(1,2,2);
plot(X4(y==1,1),X4(y==1,2),'^');
hold on
plot(X4(y==2,1),X4(y==2,2),'+');
plot(C(1,1),C(1,2), 'r^','LineWidth',2);
plot(C(2,1),C(2,2), 'r+','LineWidth',2);
title('Data Points with Labels by K-means Clustering');
legend('Points of cluster 1','Points of cluster 2')
xlabel('eruptions');
ylabel('waiting');

w_try = [0.5,0.5];
sigma_try1 = [1,0;0,1];
sigma_try2 = [1,0;0,1];
mu_try1 = [C(1);C(3)];
mu_try2 = [C(2);C(4)];
tic;
[mu_out1,mu_out2,sigma_out1,sigma_out2,w_out] = GMM_EM (X4',mu_try1,mu_try2,sigma_try1,sigma_try2,w_try);
toc;
mu_final = [mu_out1';mu_out2'];
sigma_final = cat(3,sigma_out1,sigma_out2);
obj_final = gmdistribution(mu_final,sigma_final,w_out);
%2D Projection
figure(4)
ezcontourf(@(x,y) pdf(obj_final,[x y]),[1.5 5.5],[40 100]);
hold on
plot(X4(y==1,1),X4(y==1,2),'^');
plot(X4(y==2,1),X4(y==2,2),'+');
title('2D contour plot overlaid with dataset');
xlabel('eruptions');
ylabel('waiting');
%View PDF Surface
figure(5)
ezsurf(@(x,y)pdf(obj_final,[x y]),[1.5 5.5],[40 100]);
title('3D pdf surface');
xlabel('eruptions');
ylabel('waiting');
zlabel('Frequency');