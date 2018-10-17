%   Author: Himol Shah
%   Description: Streaming Linear Discriminant Analysis 

load iris_dataset;
X = irisInputs;
[L,~,~] = find(irisTargets);
class = unique(L)';
k = numel(class);

[Y, total_mean, mean_matrix, ex, Sw, K] = lda_offline(X, class, k, L);   

p = input('Enter new data points(1 X 4): ');
c = input('Enter class(1-3): ');


Xisum = ex(c)*mean_matrix(c, :) + p;
mean_matrix(c, :) = (ex(c)*mean_matrix(c, :) + p)/(ex(c) + 1);
mu = mean_matrix(c, :);
total_mean = ((sum(ex) * total_mean) + p)/(sum(ex) + 1);
ex(c) = ex(c) + 1;

Sw_on = Sw + p'*p - Xisum'*mu - mu'*Xisum + mu'*mu;

Sb_on = 0;

for i = 1:k

    XXmm = total_mean - mean_matrix(i, :);
    curSb = XXmm' * XXmm;
    Sb_on = Sb_on + ex(i)*curSb;
    
end

X = X';
X = [X; p];

K_on = inv(Sw_on) * Sb_on;
[U, sig_on] = eig(K_on); 
U = U(:, 1:2);
Y_on = X*U;


L = [L; c];

[Y_off, total_mean, mean_matrix, ex, Sw_off, Sb_off, K_off] = lda_offline(X', class, k, L);
[U, sig_off] = eig(K_off);

err = abs(Y_on - Y_off).^2;
err = sum(err(:))/numel(Y_on);
err






    
