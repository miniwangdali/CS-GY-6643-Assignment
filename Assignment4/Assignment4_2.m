clear all;
close all;
clc;

sigma = 2.0;
image1 = double(imread('toy_formatted2.png'));
image2 = double(imread('toy_formatted3.png'));
filteredImage1 = double(gaussian_filter(image1, sigma));
filteredImage2 = double(gaussian_filter(image2, sigma));

[h, w] = size(image1);

% gradientT = image2 - image1;
% 
% Ex = zeros(h, w);
% for i = 1:1:h - 1
%     for j = 1:1:w
%         Ex(i, j) = image1(i + 1, j) - image1(i, j);
%     end
% end
% 
% Ey = zeros(h, w);
% for i = 1:1:h
%     for j = 1:1:w - 1
%         Ey(i, j) = image1(i, j + 1) - image1(i, j);
%     end
% end

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
for i = 1:1:h - 1
    for j = 1:1:w - 1
        A = [
            Ex(i, j), Ey(i, j);
            Ex(i + 1, j), Ey(i + 1, j);
            Ex(i, j + 1), Ey(i, j + 1);
            Ex(i + 1, j + 1), Ey(i + 1, j + 1);
        ];
        b = [
            gradientT(i, j);
            gradientT(i + 1, j);
            gradientT(i, j + 1);
            gradientT(i + 1, j + 1);
        ];
        opticalFlow(i, j, :) = - pinv(transpose(A) * A) * transpose(A) * b;
        if isnan(opticalFlow(i, j))
            opticalFlow(i, j) = [0, 0];
        end
    end
end

figure(2);
imshow(image1, []);
hold on;
[x, y] = meshgrid(1:w, 1:h);
quiver(x, y, opticalFlow(:, :, 1), opticalFlow(:, :, 2));
hold off;

