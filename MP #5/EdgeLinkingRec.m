function result = EdgeLinkingRec(Mag, T_low, T_high, u, v)
global Mag_high;
global visited;
result = 0;

for i = u-1:u+1
    for j = v-1:v+1
        if i < 1 || j < 1 || i > size(Mag, 1) || j > size(Mag, 2) || ...
                (i == u && j == v) || visited (i, j) == 1
            continue;
        else
            if Mag(i, j) > T_high
                visited(i, j) = 1;
                Mag_high(i, j) = Mag(i, j);
                result = 1;
                return;
            elseif Mag(i, j) > T_low
                visited(i, j) = 1;
                result = EdgeLinkingRec(Mag, T_low, T_high, i, j);
                if result == 1
                    Mag_high(i, j) = Mag(i, j);
                    return;
                end
            end
        end
    end
end

end