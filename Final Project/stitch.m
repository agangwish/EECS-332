function stitch( dir )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

photoDir = fullfile('C:\Users\agang\OneDrive\Documents\MATLAB\EECS-332\Final Project', dir);
scene = imageDatastore(photoDir);

montage(scene.Files);
title('Images to be stitched');

% REGISTER IMAGE PAIRS
tforms = registerImagePairs(scene);

% CREATE PANORAMA
panorama = buildPanorama(scene, tforms);

figure;
imshow(panorama);
title('Final Panorama');

end

