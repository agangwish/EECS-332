function [ matchedPoints1, features1, matchedPoints2, features2 ] = matchKeypoints(I1, I2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

img1 = rgb2gray(imread(I1));
img2 = rgb2gray(imread(I2));

points1 = detectHarrisFeatures(img1);
points2 = detectHarrisFeatures(img2);

[features1,valid_points1] = extractFeatures(img1, points1);
[features2,valid_points2] = extractFeatures(img2, points2);

indexPairs = matchFeatures(features1, features2);

matchedPoints1 = valid_points1(indexPairs(:,1),:);
matchedPoints2 = valid_points2(indexPairs(:,2),:);

figure; showMatchedFeatures(img1,img2,matchedPoints1,matchedPoints2, 'montage');

end

