% Alex Gangwish
% EECS 332 MP #5
% Canny Edge Detector

% GAUSSIAN SMOOTHING PARAMETERS%%%%%%%%
N = 6;
Sigma = 3;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
joy1 = imread('joy1.bmp');
joy1_smooth = GaussSmoothing('hpw.png', N, Sigma);
lena = imread('lena.bmp');
lena_smooth = GaussSmoothing('lena.bmp', N, Sigma);
pointer1 = imread('pointer1.bmp');
pointer1_smooth = GaussSmoothing('pointer1.bmp', N, Sigma);
test1 = imread('test1.bmp');
test1_smooth = GaussSmoothing('test1.bmp', N, Sigma);

figure;
subplot(2,2,1); imshow(joy1); title('joy1.bmp');
subplot(2,2,2); imshow(lena); title('lena.bmp');
subplot(2,2,3); imshow(pointer1); title('pointer1.bmp');
subplot(2,2,4); imshow(test1); title('test1.bmp');

figure;
subplot(2,2,1); imshow(joy1_smooth); title('joy1.bmp with smoothing');
subplot(2,2,2); imshow(lena_smooth); title('lena.bmp with smoothing');
subplot(2,2,3); imshow(pointer1_smooth); title('pointer1.bmp with smoothing');
subplot(2,2,4); imshow(test1_smooth); title('test1.bmp with smoothing');

% IMAGE GRADIENT %%%%%%%%%%%%%%%%%%%%%%%%%
[joy_mag, joy_theta] = ImageGradient(joy1_smooth);
[lena_mag, lena_theta] = ImageGradient(lena_smooth);
[pointer_mag, pointer_theta] = ImageGradient(pointer1_smooth);
[test_mag, test_theta] = ImageGradient(test1_smooth);

figure;
subplot(2,2,1); imshow(joy_mag); title('joy1.bmp gradient magnitude');
subplot(2,2,2); imshow(lena_mag); title('lena.bmp gradient magnitude');
subplot(2,2,3); imshow(pointer_mag); title('pointer1.bmp gradient magnitude');
subplot(2,2,4); imshow(test_mag); title('test1.bmp gradient magnitude');

% THRESHOLDS %%%%%%%%%%%%%%%%%%%%%%%%%%%
percentageOfNonEdge = .75;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[joy_t_low, joy_t_high] = FindThreshold(joy_mag, percentageOfNonEdge);
[lena_t_low, lena_t_high] = FindThreshold(lena_mag, percentageOfNonEdge);
[pointer_t_low, pointer_t_high] = FindThreshold(pointer_mag, percentageOfNonEdge);
[test_t_low, test_t_high] = FindThreshold(test_mag, percentageOfNonEdge);

% SUPPRESSING NONMAXIMA %%%%%%%%%%%%%%%%
joy_s = NonmaximaSuppress(joy_mag, joy_theta);
lena_s = NonmaximaSuppress(lena_mag, lena_theta);
pointer_s = NonmaximaSuppress(pointer_mag, pointer_theta);
test_s = NonmaximaSuppress(test_mag, test_theta);

figure;
subplot(2,2,1); imshow(joy_s); title('joy1.bmp NMS');
subplot(2,2,2); imshow(lena_s); title('lena.bmp NMS');
subplot(2,2,3); imshow(pointer_s); title('pointer1.bmp NMS');
subplot(2,2,4); imshow(test_s); title('test1.bmp NMS');

% PRINT WITH THRESHOLDS %%%%%%%%%%%%%%%%%
joy_low = ThresholdImage(joy_s, joy_t_low);
joy_high = ThresholdImage(joy_s, joy_t_high);
lena_low = ThresholdImage(lena_s, lena_t_low);
lena_high = ThresholdImage(lena_s, lena_t_high);
pointer_low = ThresholdImage(pointer_s, pointer_t_low);
pointer_high = ThresholdImage(pointer_s, pointer_t_high);
test_low = ThresholdImage(test_s, test_t_low);
test_high = ThresholdImage(test_s, test_t_high);

figure;
subplot(2,2,1); imshow(joy_low); title('joy1.bmp low threshold');
subplot(2,2,2); imshow(lena_low); title('lena.bmp low threshold');
subplot(2,2,3); imshow(pointer_low); title('pointer1.bmp low threshold');
subplot(2,2,4); imshow(test_low); title('test1.bmp low threshold');

figure;
subplot(2,2,1); imshow(joy_high); title('joy1.bmp high threshold');
subplot(2,2,2); imshow(lena_high); title('lena.bmp high threshold');
subplot(2,2,3); imshow(pointer_high); title('pointer1.bmp high threshold');
subplot(2,2,4); imshow(test_high); title('test1.bmp high threshold');

% EDGE LINKING %%%%%%%%%%%%%%%%%%%%%%%%%%
joy_e = EdgeLinking(joy_s, joy_t_low, joy_t_high);
lena_e = EdgeLinking(lena_s, lena_t_low, lena_t_high);
pointer_e = EdgeLinking(pointer_s, pointer_t_low, pointer_t_high);
test_e = EdgeLinking(test_s, test_t_low, test_t_high);

figure;
subplot(2,2,1); imshow(joy_e); title('joy1.bmp edge linking');
subplot(2,2,2); imshow(lena_e); title('lena.bmp edge linking');
subplot(2,2,3); imshow(pointer_e); title('pointer1.bmp edge linking');
subplot(2,2,4); imshow(test_e); title('test1.bmp edge linking');

% COMPARISON %%%%%%%%%%%%%%%%%%%%%%%%%%%%

lena = rgb2gray(lena);
figure;
subplot(2,2,1); imshow(lena_e); title('MY EDGE DETECTOR');
subplot(2,2,2); imshow(edge(lena, 'sobel')); title('SOBEL');
subplot(2,2,3); imshow(edge(lena, 'roberts')); title('ROBERTS');
subplot(2,2,4); imshow(edge(lena, 'zerocross')); title('ZEROCROSS');

figure;
imshow(lena_e); title('lena.bmp Sigma = 0.5');
