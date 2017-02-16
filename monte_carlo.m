function I = monte_carlo(a,b,n,fun)
%This function works for monte carlo simulation
t = rand(1,n);
x = a + (b-a)*t;
s = sum(fun(x));
I = s*(b-a)/n;
end