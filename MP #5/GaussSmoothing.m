function S = GaussSmoothing( I, N, Sigma )
%GaussSmoothing Uses a Gaussian filter to smooth a grayscale image
%   Creates a Gaussian mask based on the inputs N and sigma, and convolutes
%   the image I with said mask

    I = im2double(rgb2gray(imread(I)));
    Gmask = fspecial('gaussian', [N,N], Sigma); 
    S = conv2(I, Gmask, 'same');

end

