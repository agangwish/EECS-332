function E = EdgeLinking(Mag, T_low, T_high)

global Mag_high;
global visited;
Mag_high = Mag;
Mag_high(Mag_high < T_high) = 0;
Mag(Mag < T_low) = 0;
visited = zeros(size(Mag));

for u = 1:size(Mag, 1)
    for v = 1:size(Mag, 2)
        if Mag(u, v) ~= 0
            EdgeLinkingRec(Mag, T_low, T_high, u, v);
        end
    end
end

E = Mag_high;
end