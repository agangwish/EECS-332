function tforms = registerImagePairs( scene )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

I = readimage(scene, 1);
imageSize = size(I);

img = rgb2gray(I);
points = detectSURFFeatures(img); % EXPERIMENT WITH HARRIS FEATURES
[features, points] = extractFeatures(img, points);

numImages = numel(scene.Files);
tforms(numImages) = projective2d(eye(3)); % EXPERIMENT WITH AFFINE TRANSFORM

for n = 2:numImages
    
    pointsPrev = points;
    featuresPrev = features;
    
    img = rgb2gray(readimage(scene, n));
    points = detectSURFFeatures(img);
    [features, points] = extractFeatures(img, points);
    
    indexPairs = matchFeatures(features, featuresPrev, 'Unique', true, 'MaxRatio', 0.6); % EXPERIMENT WITH THIS
    matchedPoints = points(indexPairs(:, 1), :);
    matchedPointsPrev = pointsPrev(indexPairs(:, 2), :);
    
    tforms(n) = estimateGeometricTransform(matchedPoints, matchedPointsPrev, 'projective', ...
        'Confidence', 99.9, 'MaxNumTrials', 2000);
    
    tforms(n).T = tforms(n-1).T * tforms(n).T;
    
    figure;
    subplot(2, 1, 1);
    title(['Matching points for images ', num2str(n-1), ' and ', num2str(n)]);
    imshow([readimage(scene, n-1), readimage(scene, n)]);
    subplot(2, 1, 2);
    showMatchedFeatures(readimage(scene, n-1), readimage(scene, n), matchedPointsPrev, matchedPoints, 'montage');
    
end 

% CHANGE WARPING TO FOCUS ON CENTER IMAGE
for i = 1:numel(tforms)
    [xlim(i,:), ylim(i,:)] = outputLimits(tforms(i), [1 imageSize(2)], [1 imageSize(1)]);
end

avgXLim = mean(xlim, 2);

[~, idx] = sort(avgXLim);

centerIdx = floor((numel(tforms)+1)/2);

centerImageIdx = idx(centerIdx);

Tinv = invert(tforms(centerImageIdx));

for i = 1:numel(tforms)
    tforms(i).T = Tinv.T * tforms(i).T;
end

end

