function [T_low, T_high] = FindThreshold(Mag, percentageOfNonEdge)
%FindThreshold Determines a high and low threshold for later processing
%   Takes as input the magnitude of the image gradient and the percentage
%   of non edge area in said magnitude, and returns the high and low
%   thresholds.

if max(Mag(:)) > 0
    Mag = Mag / max(Mag(:));
end

my_hist = imhist(Mag, 64);

T_high = find(cumsum(my_hist) > percentageOfNonEdge * size(Mag, 1) * size(Mag, 2), 1, 'first');
T_high = T_high / 64;
T_low = (T_high * 0.5);

end

