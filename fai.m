function N = fai(x,mu,sigma)

N = 1/(2*pi*sqrt(det(sigma)))*exp(-1/2*(x-mu)'*(inv(sigma))*(x-mu));

end