function panorama = buildPanorama( scene, tforms )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

imageSize = size(readimage(scene, 1));

for i = 1:numel(tforms)
    [xlim(i, :), ylim(i, :)] = outputLimits(tforms(i), [1 imageSize(2)], [1 imageSize(1)]);
end

xMin = min([1; xlim(:)]);
xMax = max([imageSize(2); xlim(:)]);
yMin = min([1; ylim(:)]);
yMax = max([imageSize(1); ylim(:)]);

width = round(xMax - xMin);
height = round(yMax - yMin);

panorama = zeros([height width 3], 'like', readimage(scene, 1)); % EXPERIMENT WITH THIS

blender = vision.AlphaBlender('Operation', 'Binary Mask', 'MaskSource', 'Input Port');

xLimits = [xMin xMax];
yLimits = [yMin yMax];

panoramaView = imref2d([height width], xLimits, yLimits);

for i = 1:numel(scene.Files)
    
    I = readimage(scene, i);
    
    warpedImage = imwarp(I, tforms(i), 'OutputView', panoramaView);
    
    mask = imwarp(true(size(I, 1), size(I, 2)), tforms(i), 'OutputView', panoramaView);
    
    panorama = step(blender, panorama, warpedImage, mask);
end

end

