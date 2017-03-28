clear all;
clc;
close all;
% FRANKOTCHELLAPPA switch
FRANKOTCHELLAPPA = 0;
% FRANKOTCHELLAPPA = 1;
% Read images
image1 = double(imread('im1.png'));
image2 = double(imread('im2.png'));
image3 = double(imread('im3.png'));
image4 = double(imread('im4.png'));
greyImage1 = image1 / 255;
greyImage2 = image2 / 255;
greyImage3 = image3 / 255;
greyImage4 = image4 / 255;
% Initial light source position
S = [
    0, 0, 1;
    -0.2, 0, 1;
    0.2, 0, 1;
    0, -0.2, 1
];
width = 100;
height = 100;
albedo = zeros(height, width, 1);
N = zeros(height, width, 3);
p = zeros(height, width, 1);
q = zeros(height, width, 1);
z = zeros(height, width, 1);
% Infering albedo and normal
for i = 1:1:height
    for j = 1:1:width
        I = [
            greyImage1(i, j);
            greyImage2(i, j);
            greyImage3(i, j);
            greyImage4(i, j);
        ];
        g = linsolve(S, I);
        albedo(i, j) = norm(g);
        N(i, j, :) = g / albedo(i, j);
        p(i, j) = N(i, j, 1) / N(i, j, 3);
        q(i, j) = N(i, j, 2) / N(i, j, 3);
    end
end
% Integration
if FRANKOTCHELLAPPA
    z = frankotchellappa(p, q);
else
    z(1, 1) = 0;
    for i = 2:1:height
        z(i, 1) = z(i - 1, 1) + q(i, 1);
    end
    for i = 1:1:height
        for j = 2:1:width
            z(i, j) = z(i, j - 1) + p(i ,j);
        end
    end
end

[x, y] = meshgrid(1:height, 1:width);
figure(1);
mesh(x, y, z);
title('Figure 1: Wireframe');
figure(2);
surf(x, y, z, 'EdgeColor', 'none');
title('Figure 2: Shaded Image');
camlight('headlight');
lighting phong;
figure(3);
quiver3(x, y, z, N(:,:,1), N(:,:,2), N(:,:,3));
title('Figure 3: Normal');
figure(4);
quiver(x, y, p, q);
title('Figure 4: Needle Map');
figure(5);
imshow(z, [-255, 0]);
% imshow(z, [0, 255]);
title('Figure 5: Depth Map');
figure(6)
imshow(albedo);
title('Figure 6: Albedo Map');
figure(7);
[U, V, W] = surfnorm(x, y, z);
quiver3(x, y, z, U, V, W);

