clear all;
close all;
clc;

sigma = 2.0;
image1 = double(imread('toy_formatted2.png'));
image2 = double(imread('toy_formatted3.png'));
filteredImage1 = double(gaussian_filter(image1, sigma));
filteredImage2 = double(gaussian_filter(image2, sigma));

[h, w] = size(image1);
gradientT = filteredImage2 - filteredImage1;

Ex = zeros(h, w);
for i = 1:1:h - 1
    for j = 1:1:w
        Ex(i, j) = filteredImage1(i + 1, j) - filteredImage1(i, j);
    end
end

Ey = zeros(h, w);
for i = 1:1:h
    for j = 1:1:w - 1
        Ey(i, j) = filteredImage1(i, j + 1) - filteredImage1(i, j);
    end
end

figure(1);
subplot(2, 3, 2);
imshow(image1, []);
title('Figure 1: Original Image 1');
subplot(2, 3, 4);
imshow(gradientT, []);
title('Figure 2: Time Gradient');
subplot(2, 3, 5);
imshow(Ex, []);
title('Figure 3: X Spatial Gradient');
subplot(2, 3, 6);
imshow(Ey, []);
title('Figure 4: Y Spatial Gradient');

opticalFlow = zeros(h, w, 2);
u = zeros(h, w);
v = zeros(h, w);
lamda = 10;
n0 = 20;
for k = 1:1:n0 
    for i = 2:1:h - 1
        for j = 2:1:w - 1
            uAverage = 1 / 4 * (u(i - 1, j) + u(i + 1, j) + u(i, j - 1) + u(i, j + 1));
            vAverage = 1 / 4 * (v(i - 1, j) + v(i + 1, j) + v(i, j - 1) + v(i, j + 1));
            alpha = (Ex(i, j) * uAverage + Ey(i, j) * vAverage + gradientT(i, j)) / (1 + lamda * (Ex(i, j) * Ex(i, j) + Ey(i, j) * Ey(i, j))) * lamda;
            if isnan(alpha)
                u(i, j) = 0;
                v(i, j) = 0;
            else
                u(i, j) = uAverage - alpha * Ex(i, j);
                v(i, j) = vAverage - alpha * Ey(i, j);
            end
        end
    end
end

figure(2);
imshow(image1, []);
hold on;
[x, y] = meshgrid(1:w, 1:h);
quiver(x, y, u, v);
hold off;

