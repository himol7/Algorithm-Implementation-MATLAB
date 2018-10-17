%   Author: Himol Shah
%   Description: Linear Discriminant Analysis on Iris Dataset


load iris_dataset
X = irisInputs';
[L,~,~] = find(irisTargets);

Classes = unique(L)';s
k = numel(Classes);

n = zeros(k,1); %class_size
C = cell(k,1);  %class mean
M = mean(X);    %overall_mean
S = cell(k,1);  %S_i
Sw = 0;
Sb = 0;

    for j=1:k
        Xj=X(L==Classes(j),:);
        n(j)=size(Xj,1); %
        C{j}=mean(Xj);
        S{j}=0;
        for i=1:n(j)
            S{j}=S{j}+(Xj(i,:)-C{j})'*(Xj(i,:)-C{j});
        end
        Sw = Sw+S{j};
        Sb = Sb+n(j)*(C{j}-M)'*(C{j}-M);
    end

    [W, LA] = eig(Sb,Sw); 

    lambda = diag(LA);

    [lambda, SortOrder] = sort(lambda,'descend');

    W = W(:,SortOrder);

    Y = X*W;
    
    
    figure
    plot(X(1:50,1),X(1:50,2),'r.');
    hold on
    plot(X(51:100,1),X(51:100,2),'g.');
    hold on
    plot(X(101:150,1),X(101:150,2),'b.');
    
    figure
    plot(Y(1:50,1),Y(1:50,2),'r.');
    hold on
    plot(Y(51:100,1),Y(51:100,2),'g.');
    hold on
    plot(Y(101:150,1),Y(101:150,2),'b.');
    
    

