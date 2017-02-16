function I = monte_carlo2(a,b,n,fun)
%This function works for monte carlo simulation on multi-var case
t1 = rand(1,n);
x = a + (b-a)*t1;
t2 = rand(1,n);
y = a + (b-a)*t2;
s = sum(fun(x,y));
I = s*(b-a)/n;
end