% Alex Gangwish
% EECS 332 MP #4
% 10/18/2016

g1 = rgb2hsv(imread('gun_cropped.bmp'));
g2 = rgb2hsv(imread('gun_cropped1.bmp'));
g3 = rgb2hsv(imread('gun_cropped2.bmp'));
j1 = rgb2hsv(imread('joy_cropped.bmp'));
j2 = rgb2hsv(imread('joy_cropped1.bmp'));
j3 = rgb2hsv(imread('joy_cropped2.bmp'));
p1 = rgb2hsv(imread('pointer_cropped.bmp'));
p2 = rgb2hsv(imread('pointer_cropped1.bmp'));
p3 = rgb2hsv(imread('pointer_cropped2.bmp'));


my_histogram = zeros(101, 101);
pixels = 0;

for u = 1:size(g1, 1)
    for v = 1:size(g1, 2)
        h_new = round(g1(u, v, 1) * 100) + 1;
        s_new = round(g1(u, v, 2) * 100) + 1;
        my_histogram(h_new, s_new) = my_histogram(h_new, s_new) + 1;
        pixels = pixels + 1;
    end
end

for u = 1:size(g2, 1)
    for v = 1:size(g2, 2)
        h_new = round(g2(u, v, 1) * 100) + 1;
        s_new = round(g2(u, v, 2) * 100) + 1;
        my_histogram(h_new, s_new) = my_histogram(h_new, s_new) + 1;
        pixels = pixels + 1;
    end
end

for u = 1:size(g3, 1)
    for v = 1:size(g3, 2)
        h_new = round(g3(u, v, 1) * 100) + 1;
        s_new = round(g3(u, v, 2) * 100) + 1;
        my_histogram(h_new, s_new) = my_histogram(h_new, s_new) + 1;
        pixels = pixels + 1;
    end
end

for u = 1:size(j1, 1)
    for v = 1:size(j1, 2)
        h_new = round(j1(u, v, 1) * 100) + 1;
        s_new = round(j1(u, v, 2) * 100) + 1;
        my_histogram(h_new, s_new) = my_histogram(h_new, s_new) + 1;
        pixels = pixels + 1;
    end
end

for u = 1:size(j2, 1)
    for v = 1:size(j2, 2)
        h_new = round(j2(u, v, 1) * 100) + 1;
        s_new = round(j2(u, v, 2) * 100) + 1;
        my_histogram(h_new, s_new) = my_histogram(h_new, s_new) + 1;
        pixels = pixels + 1;
    end
end

for u = 1:size(j3, 1)
    for v = 1:size(j3, 2)
        h_new = round(j3(u, v, 1) * 100) + 1;
        s_new = round(j3(u, v, 2) * 100) + 1;
        my_histogram(h_new, s_new) = my_histogram(h_new, s_new) + 1;
        pixels = pixels + 1;
    end
end

for u = 1:size(p1, 1)
    for v = 1:size(p1, 2)
        h_new = round(p1(u, v, 1) * 100) + 1;
        s_new = round(p1(u, v, 2) * 100) + 1;
        my_histogram(h_new, s_new) = my_histogram(h_new, s_new) + 1;
        pixels = pixels + 1;
    end
end

for u = 1:size(p2, 1)
    for v = 1:size(p2, 2)
        h_new = round(p2(u, v, 1) * 100) + 1;
        s_new = round(p2(u, v, 2) * 100) + 1;
        my_histogram(h_new, s_new) = my_histogram(h_new, s_new) + 1;
        pixels = pixels + 1;
    end
end

for u = 1:size(p3, 1)
    for v = 1:size(p3, 2)
        h_new = round(p3(u, v, 1) * 100) + 1;
        s_new = round(p3(u, v, 2) * 100) + 1;
        my_histogram(h_new, s_new) = my_histogram(h_new, s_new) + 1;
        pixels = pixels + 1;
    end
end

my_histogram = my_histogram ./ pixels;
x = 0:100;
figure;
bar3(my_histogram);
title('Training Histogram'); xlabel('Hue'); ylabel('Saturation');

gun_test = rgb2hsv(imread('gun1.bmp'));
joy_test = rgb2hsv(imread('joy1.bmp'));
pointer_test = rgb2hsv(imread('pointer1.bmp'));

threshold = 0.00025;

for u = 1:size(gun_test, 1)
    for v = 1:size(gun_test, 2)
        h_new = round(gun_test(u, v, 1) * 100) + 1;
        s_new = round(gun_test(u, v, 2) * 100) + 1;
        
        if (my_histogram(h_new, s_new) < threshold)
            gun_test(u, v, :) = 0;
        end
    end
end
figure;
imshow(hsv2rgb(gun_test));

for u = 1:size(joy_test, 1)
    for v = 1:size(joy_test, 2)
        h_new = round(joy_test(u, v, 1) * 100) + 1;
        s_new = round(joy_test(u, v, 2) * 100) + 1;
        
        if (my_histogram(h_new, s_new) < threshold)
            joy_test(u, v, :) = 0;
        end
    end
end
figure;
imshow(hsv2rgb(joy_test));

for u = 1:size(pointer_test, 1)
    for v = 1:size(pointer_test, 2)
        h_new = round(pointer_test(u, v, 1) * 100) + 1;
        s_new = round(pointer_test(u, v, 2) * 100) + 1;
        
        if (my_histogram(h_new, s_new) < threshold)
            pointer_test(u, v, :) = 0;
        end
    end
end
figure;
imshow(hsv2rgb(pointer_test));
