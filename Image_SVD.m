%   Author: Himol Shah
%   Description: Singular Value Decomposition and Regeneration of an Image

    i = imread('image.jpg');
    A = im2double(rgb2gray(i));
    
    name = 'image_gray.jpeg';
    folder = 'source_folder';
    
    imwrite(A,fullfile(folder,name));
    
    tic;    %   starting clock
    B = A * A';
    [U,D] = eig(B); %   Calculating Eigen Values and Eigen Vectors
    
    sig = zeros(1080,840); %appending to sigma matrix
    sig = [sqrtm(D) sig];
       
    C = U * sig;
    V = (pinv(C) * A)'; %psuedo inverse
    
    comp = [];
    
    for i = 1:1080
        if(sig(i,i) < 5)    %   Retaining Eigen Values less than a threshold
            comp = [comp  i];
        end
    end
    
    U(:,comp) = [];
    V(:,comp) = [];
    sig(:,comp) = [];
    sig(comp,:) = [];
 
    img = U * sig * V'; %   Regenerating the image
    toc     %   Stopping time
    name = 'image_fin.jpeg';
    imshow(img);
    imwrite(img,fullfile(folder,name));