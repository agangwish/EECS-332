function Mag = NonmaximaSuppress(Mag, Theta)
%NonmaximaSuppress Finds local maxima by suppressing non maxima
%   Takes as input the image gradient magnitude and direction, and returns
%   a matrix with nonmaxima set to zero

result = zeros(size(Mag));

for u = 2:size(Mag, 1)-1
    for v = 2:size(Mag, 2)-1
        if abs(Theta(u, v)) <= pi / 8 % Gradient runs in E/W direction
            % Check if magnitude is greater than east and west neighbors
            if Mag(u, v) > Mag(u, v+1) && Mag(u, v) > Mag(u, v-1)
                result(u, v) = Mag(u, v);
            end
        elseif Theta(u, v) > pi / 8 && Theta(u, v) <= 3 * pi / 8 % Gradient runs in NE/SW direction
            % Check if magnitude is greater than NE and SW neighbors
            if Mag(u, v) > Mag(u-1, v+1) && Mag(u, v) > Mag(u+1, v-1)
                result(u, v) = Mag(u, v);
            end
        elseif abs(Theta(u, v)) > 3 * pi / 8 && abs(Theta(u, v)) <= pi / 2% Gradient runs in N/S direction
            % Check if magnitude is greater than north and south neighbors
            if Mag(u, v) > Mag(u-1, v) && Mag(u, v) > Mag(u+1, v)
                result(u, v) = Mag(u, v);
            end
        else % Gradient runs in NW/SE direction
            % Check if magnitude is greater than NW and SE neighbors
            if Mag(u, v) > Mag(u+1, v+1) && Mag(u, v) > Mag(u-1, v-1)
                result(u, v) = Mag(u, v);
            end
        end
    end
end

Mag = result;

end
