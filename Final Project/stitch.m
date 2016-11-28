function img_out =  stitch( imageA, imageB, ratio, reprojThresh, showMatches )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[kpsA, featuresA] = detectAndDescribe(imageA);
[kpsB, featuresB] = detectAndDescribe(imageB);

[matches, H, status, check] = matchKeypoints(kpsA, kpsB, featuresA, featuresB, ratio, reprojThresh);

if check == false
    error('Not enough matched keypoints to create a panorama');
end

result = imwarp(imageA, H);

img_out = [result, imageB];

if showMatches == true
    vis = drawMatches(imageA, imageB, kpsA, kpsB, matches, status); 
end

return img_out;

end

