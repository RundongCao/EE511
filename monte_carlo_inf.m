function I = monte_carlo_inf(n,fun)
%This function works for monte carlo simulation on inf case
s = 0;
for i = 1:n
    y1 = rand();
    y2 = rand();
    s = s + (fun(1-1/y1))/(y1.^2) + (fun(1/y2-1))/(y2.^2);
end
I = s/n;
end