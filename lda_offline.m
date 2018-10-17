%   Author: Himol Shah
%   Description: Linear Discriminant Analysis Function


function [Y, total_mean, mean_matrix, ex, Sw, Sb, K] = lda_offline(X, class, k, L)

mt = mean(X');
[N, M] = size(X);

Sw = 0;
Sw_n = 0;
Sb = 0;
Sb_n = 0;

ex = zeros(k,1);
mean_mat = zeros(k,N);

X = X';
for i = 1:k
    
    Xi = X(L == class(i), :);
    [ex(i), m] = size(Xi);
    mean_mat(i, :) = mean(Xi);
    XXm = bsxfun(@minus, Xi, mean_mat(i, :));
    curSw = XXm' * XXm;
    Sw = Sw + curSw;
    
    XXmm = mt - mean_mat(i, :);
    curSb = XXmm' * XXmm;
    Sb = Sb + ex(i)*curSb;
    
end

K = inv(Sw) * Sb;
[U, sig] = eig(K); 
U = U(:, 1:2);
Y = X*U;
total_mean = mt;
mean_matrix = mean_mat;



