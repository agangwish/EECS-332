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
    my_rho = zeros(size(rho_max));
    my_theta = zeros(size(theta_max));
    index = 1;

    for i = 1:size(rho_max, 1)
        if (H(rho_max(i),theta_max(i)) >= 0)
            my_rho(index) = rho_max(i);
            my_theta(index) = theta_max(i);
            index = index + 1;
        end
    end

    my_rho = my_rho(my_rho ~= 0);
    my_theta = my_theta(my_theta ~= 0);

    subplot(1,3,1);
    imshow(img);
    title('Original Image');
    subplot(1,3,2);
    imshow(imadjust(mat2gray(H)), 'XData', my_rho, 'YData', my_theta, 'InitialMagnification', 'fit');
    title('Hough Transform'), xlabel('\rho'), ylabel('\theta');
    hold on, colormap(gca, hot), hold off;

    subplot(1,3,3);
    imshow(img);
    title('Lines');
    hold on;
    
    m_array = zeros(size(my_rho));
    b_array = zeros(size(my_rho));
    
    for i = 1:size(my_rho)
        
        x = 1:size(img);    
        m = -(cosd(theta(my_theta(i))) / sind(theta(my_theta(i))));
        m_array(i) = m;
        b = (rho(round(my_rho(i))) / sind(theta(my_theta(i))));
        b_array(i) = b;
        y = (m * x) + b;
        
        plot(y, x);
    end
    
    for i = 1:size(m_array) - 1
        for j = 2:size(m_array)
            m1 = m_array(i);
            m2 = m_array(j);
            b1 = b_array(i);
            b2 = b_array(j);
            x_temp = (b2 - b1) / (m1 - m2);
            y_temp = (m2*b1 - m1*b2) / (m2 - m1);
            if x_temp < size(img, 1) && y_temp < size(img, 2)
                plot(y_temp, x_temp, '*');
            end
        end
    end
    hold off;
    
    figure;
    imshow(img);
    hold on;
    for i = 1:size(my_rho)
        
        x = 1:size(img);    
        m = -(cosd(theta(my_theta(i))) / sind(theta(my_theta(i))));
        m_array(i) = m;
        b = (rho(round(my_rho(i))) / sind(theta(my_theta(i))));
        b_array(i) = b;
        y = (m * x) + b;
        
        plot(y, x);
    end
    for i = 1:size(m_array) - 1
        for j = 2:size(m_array)
            m1 = m_array(i);
            m2 = m_array(j);
            b1 = b_array(i);
            b2 = b_array(j);
            x_temp = (b2 - b1) / (m1 - m2);
            y_temp = (m2*b1 - m1*b2) / (m2 - m1);
            if x_temp < size(img, 1) && y_temp < size(img, 2)
                plot(y_temp, x_temp, '*');
            end
        end
    end
    hold off;
    
end