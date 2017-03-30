clear all;
clc
%Question3
N = 100;
input = [zeros(1,N-10) 1 zeros(1,N+10)];%initial distribution
%Transition matrix
P = zeros(2*N+1,2*N+1);
for i = 1:2*N+1
    for j = 1:2*N+1
        P(i,j) = nchoosek(2*N,j-1)*(((i-1)/(2*N)).^(j-1))*(1-(i-1)/(2*N)).^(2*N-j+1);
    end
end
n = 10000;%number of time steps to take
output = zeros(n+1,2*N+1);%clear out any old values
t = 0:n;%time indices
output(1,:)=input;

for i = 1:n
    output(i+1,:) = output(i,:)*P;
    LIT = abs(output(i+1,:)-output(i,:));
    if all(LIT == 1)%tolerance check
        break;
    end
end

figure(3);
plot(output(100,:),'*');
xlabel('state sequence');
ylabel('state frequency');
title('Figure for output state distribution');
