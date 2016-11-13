% Alex Gangwish
% EECS 332 MP #2
% Morphological Operators

function img_out = MorphologicalOperators(img_in, method, SE)
% Wrapper function for morphological functions
%   Used to call the various different morphological operators in this file
if ~exist('SE', 'var')
    SE = ' ';
end

switch method
    case 'e'  
        img_out = Erosion(img_in, SE);
    case 'd'
        img_out = Dilation(img_in, SE);
    case 'o'
        img_out = Opening(img_in, SE);
    case 'c'
        img_out = Closing(img_in, SE);
    case 'b'
        img_out = Boundary(img_in, SE);
end
end

function img_out = Erosion(img_in, SE)
% Erosion morphological operator for a binary image
%   Takes as input img_in, a binary image; and SE, the structuring element
%   by which the image is to be adjusted; Returns img_out, the erosion
%   adjusted image.

% Read in the image
if isa(img_in, 'char')
    bitmap = imread(img_in);
    img_out = bitmap;
else
    bitmap = img_in;
    img_out = img_in;
end

if ~exist('SE', 'var')
    SE = ' ';
end

% Iterate over pixels
for u = 1:size(bitmap, 1)          
    for v = 1:size(bitmap, 2)
        if bitmap(u, v) == 1
            switch SE
                case 'c'
                    for i = -1:2:1
                        if bitmap(u + i, v) == 0 || bitmap(u, v + i) == 0
                            img_out(u, v) = 0;
                            break;
                        end
                    end
                case 'l'
                    for i = -2:2
                        if bitmap(u + i, v) == 0 || bitmap (u, v + i) == 0 || bitmap(u + i, v + i) == 0 || bitmap(u + i, v - i) == 0
                            img_out(u, v) = 0;
                            break;
                        end
                    end
                otherwise
                    for i = -1:2:1
                        if bitmap(u + i, v) == 0 || bitmap(u, v + i) == 0 || bitmap(u + i, v + i) == 0 || bitmap (u + i, v - i) == 0
                            img_out(u, v) = 0;
                            break;
                        end
                    end
            end
        end
    end
end
end


function img_out = Dilation(img_in, SE)
% Erosion morphological operator for a binary image
%   Takes as input img_in, a binary image; and SE, the structuring element
%   by which the image is to be adjusted; Returns img_out, the dilation
%   adjusted image.

% Read in image
if isa(img_in, 'char')
    bitmap = imread(img_in);
    img_out = bitmap;
else
    bitmap = img_in;
    img_out = img_in;
end

if ~exist('SE', 'var')
    SE = ' ';
end

% Iterate over pixels
for u = 3:size(bitmap, 1) - 2          
    for v = 3:size(bitmap, 2) - 2
        if bitmap(u, v) == 0
            switch SE
                case 'c'
                    for i = -1:2:1
                        if bitmap(u + i, v) == 1 || bitmap(u, v + i) == 1
                            img_out(u, v) = 1;
                            break;
                        end
                    end
                case 'l'
                    for i = -2:2
                        if bitmap(u + i, v) == 1 || bitmap (u, v + i) == 1 || bitmap(u + i, v + i) == 1 || bitmap(u + i, v - i) == 1
                            img_out(u, v) = 1;
                            break;
                        end
                    end
                otherwise
                    for i = -1:2:1
                        if bitmap(u + i, v) == 1 || bitmap(u, v + i) == 1 || bitmap(u + i, v + i) == 1 || bitmap (u + i, v - i) == 1
                            img_out(u, v) = 1;
                            break;
                        end
                    end
            end
        end
    end
end
end

function img_out = Opening(img_in, SE)
% Opening morphological operator for a binary image
%   Takes as input img_in, a binary image, and SE, the structuring element
%   by which the image is to be rescaled. Returns img_out, the opening
%   adjusted image.

% Read in image
if isa(img_in, 'char')
    bitmap = imread(img_in);
    img_out = bitmap;
else
    img_out = img_in;
end

if ~exist('SE', 'var')
    SE = ' ';
end

% Opening operations
img_out = Erosion(img_out, SE);
img_out = Dilation(img_out, SE);

end

function img_out = Closing(img_in, SE)
% Opening morphological operator for a binary image
%   Takes as input img_in, a binary image, and SE, the structuring element
%   by which the image is to be rescaled. Returns img_out, the opening
%   adjusted image.

% Read in image
if isa(img_in, 'char')
    bitmap = imread(img_in);
    img_out = bitmap;
else
    img_out = img_in;
end

if ~exist('SE', 'var')
    SE = ' ';
end

% Closing Operations
img_out = Dilation(img_out, SE);
img_out = Erosion(img_out, SE);

end

function img_out = Boundary(img_in, SE)
% This function attempts to find the foreground boundary of a binary image
%   Takes as input img_in, the image to evaluate, and SE, the structural
%   element by which to adjust the image. Returns img_out, the boundary
%   representation of the image

% Read in image
if isa(img_in, 'char')
    bitmap = imread(img_in);
    img_out = bitmap;
else
    bitmap = img_in;
    img_out = img_in;
end

if ~exist('SE', 'var')
    SE = ' ';
end

% Boundary operation
img_out = bitmap - Erosion(bitmap, SE);

end
