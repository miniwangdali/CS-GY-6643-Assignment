clear all;
close all;
clc;

image1 = double(imread('toy_formatted2.png'));
image2 = double(imread('toy_formatted3.png'));
sigma = 1.5;
% G = fspecial('gaussian', [3, 3], sigma);
filteredImage1 = double(gaussian_filter(image1, sigma));
filteredImage2 = double(gaussian_filter(image2, sigma));
% filteredImage1 = imfilter(image1, G, 'same');
% filteredImage2 = imfilter(image2, G, 'same');

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

opticalFlowX = zeros(h, w);
opticalFlowY = zeros(h, w);
for i = 1:1:h
    for j = 1:1:w
        g = [Ex(i, j); Ey(i, j)];
        if (norm(g) == 0)
            opticalFlowX(i, j) = 0;
            opticalFlowY(i, j) = 0;
        else
            opticalFlowX(i, j) = - gradientT(i, j) / norm(g) * Ex(i, j) / norm(g);
            opticalFlowY(i, j) = - gradientT(i, j) / norm(g) * Ey(i, j) / norm(g);
        end
    end
end

figure(2);
imshow(image1, []);
hold on;
[x, y] = meshgrid(1:w, 1:h);
quiver(x, y, opticalFlowX, opticalFlowY);
hold off;

