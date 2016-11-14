function HoughTransform(I, dRho, dTheta, threshold)

    img = rgb2gray(imread(I));
    edges = edge(img, 'canny');

    rho = -sqrt((size(edges,1)^2) + (size(edges,2)^2)):dRho:sqrt((size(edges, 1) ^ 2) + (size(edges, 2) ^ 2));
    theta = -90:dTheta:(90 - dTheta);

    H = zeros(length(rho), length(theta));
    [x, y] = find(edges);

    for i = 1:size(x, 1)
        for j = 1:size(theta, 2)
            theta_rad = theta(j) * (pi / 180);
            rho_temp = x(i) * cos(theta_rad) + y(i) * sin(theta_rad);
            rho_diff = abs(rho_temp - rho);
            rho_min = find(rho_diff == min(rho_diff));
            H(rho_min, j) = H(rho_min, j) + 1;
        end
    end
    local_max = imregionalmax(H);
    [rho_max, theta_max] = find(local_max);

    H = (H - threshold);
    found_rho = zeros(size(rho_max));
    found_theta = zeros(size(theta_max));
    index = 1;

    for i = 1:size(rho_max, 1)
        if (H(rho_max(i),theta_max(i)) >= 0)
            found_rho(index) = rho_max(i);
            found_theta(index) = theta_max(i);
            index = index + 1;
        end
    end

    found_rho = found_rho(any(found_rho,2),:);
    found_theta = found_theta(any(found_theta,2),:);


    subplot(1,2,1);
    imshow(imadjust(mat2gray(H)), 'XData', found_rho, 'YData', ...
                    found_theta, 'InitialMagnification', 'fit');
    title('Hough transform of image');
    xlabel('\rho'), ylabel('\theta');
    axis on, axis normal;
    colormap(hot);

    subplot(1,2,2);
    imshow(img);
    hold on;
    for i = 1:size(found_rho)
        plot_theta = theta(found_theta(i));
        plot_rho = rho(round(found_rho(i)));
        
        m = -(cosd(plot_theta) / sind(plot_theta));
        b = (plot_rho / sind(plot_theta));
        x = 1:size(edges);
        
        plot(((m * x) + b), x);
        hold on;
    end
    hold off;
    
end