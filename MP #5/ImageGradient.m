function [Mag, Theta] = ImageGradient(S)
%ImageGradient Finds image gradient of S
%   Takes Gaussian-smoothed input image S and returns its image gradient
%   magnitude and direction

Mag = zeros(size(S));
Theta = zeros(size(S));

for u = 1:size(S, 1) - 2
    for v = 1:size(S, 2) - 2
        Ix = (S(u, v+2) - S(u, v)) + 2*(S(u+1, v+2)-S(u+1, v)) + (S(u+2, v+2)-S(u+2,v));
        Iy = (S(u, v) - S(u+2, v)) + 2*(S(u, v+1)-S(u+2, v+1)) + (S(u, v+2)-S(u+2,v+2));
        
        Mag(u, v) = sqrt(Ix^2 + Iy^2);
        Theta(u, v) = atan(Iy / Ix);
    end
end


end

