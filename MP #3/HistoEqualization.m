% Alex Gangwish
% EECS 332 MP #3
% 10/13/2016

function img_out = HistoEqualization(img_in)
% Function that applies histogram equalization to an image
%   Takes as input img_in, a 24-bit bitmap image; returns img_out, a
%   representation of the original image with histogram equalization
%   applied to it.

img_in = rgb2gray(imread(img_in, 'bmp'));
img_out = img_in;
numPixels = size(img_out, 1) * size(img_out, 2);
my_histogram = zeros(256, 1);

for u = 0:255
    my_histogram(u+1, 1) = sum(img_out(:) == u);
end

my_histogram_norm = my_histogram ./ numPixels;

x = 0:255;
figure;
bar(x, my_histogram);
title('Histogram of input image');
xlabel('values'); ylabel('# pixels');
figure;
bar(x, my_histogram_norm);
title('Normalized histogram of input image');
xlabel('values'); ylabel('# pixels');

my_cdf = my_histogram_norm;

acc = 0;
for u = 1:256
    acc = acc + my_histogram_norm(u);
    my_cdf(u, 1) = floor(acc * 255);
end

figure;
bar(x, my_cdf);
title('Cumulative Distribution Function');

for u = 1:size(img_out, 1)
    for v = 1:size(img_out, 2)
        img_out(u, v) = my_cdf(img_in(u, v)+1, 1);
    end
end

my_output_histogram = my_histogram;
for u = 0:255
    my_output_histogram(u+1, 1) = sum(img_out(:) == u);
end

figure;
bar(x, my_output_histogram);
title('Histogram after equalization');

my_output_histogram_norm = my_output_histogram ./ numPixels;
acc = 0;
my_output_cdf = my_output_histogram;
for u = 1:256
    acc = acc + my_output_histogram_norm(u);
    my_output_cdf(u, 1) = floor(acc * 255);
end

figure;
bar(x, my_output_cdf);
title('Cumulative distribution function after equalization');

figure;
imshow(img_out);

end
