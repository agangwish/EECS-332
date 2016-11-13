function img = ThresholdImage(I, t)
%ThresholdImage Returns an image with all values below threshold removed
%   Takes as input I and t, the image and threshold, and returns an image
%   with all values below t removed.

img = I;
img(img < t) = 0;

end

