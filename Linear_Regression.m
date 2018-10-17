%   Author: Himol Shah
%   Description: First, Linear Regression is performed on a given data set.
%   Later, a single new point of coordinated is added and Linear Regression
%   is performed using certain elements(matrices) of the previous calculation. 

%   Entire calculation for LR is not repeated again.

%   Algorithm is memory efficient as only some matrices are retained for
%   further calculations.


%Performing Linear Regression on given data
x = [2,5,7,9,8,3,1,1,8,9,15,15];
x = x';
p = x;
x = [x ones(length(x),1)];
y = [3,3,5,10,9,7,4,3,5,6,10,20];
y = y';

%   Linear Regression
b = x' * x;
b1 = inv(x' * x);
b2 = x' * y;
beta = b1 * b2;

scatter(p, y)
hold on;
plot(x, beta(1)*x + beta(2))
beta


% Adding new point

yn = [20];
xn = [15 1];
 
z = xn' * xn;   %   Calculating new z using existing xn
r = xn' * yn;   %   Calculating new r using existing yn
 
%   All matrix multiplications are not repeated again.
b = b + z;
b1 = inv(b);
b2 = b2 + r;
beta = b1 * b2;
 
scatter(p, y)
plot(xn, beta(1)*xn + beta(2))
beta

