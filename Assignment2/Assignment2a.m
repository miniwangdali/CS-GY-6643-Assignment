clear all;
clc;
close all;

n = 8;

leftImage = imread('left.jpg');
rightImage = imread('right.jpg');

figure(1);
set(gcf, 'position',[300, 200, 640, 720]);
imagesc(leftImage);
% Specify a set of corresponding pixel landmark pairs in the left and right camera views.
% [u, v] = textread('uvLeft.txt','%f,%f');
% uvLeft = [u, v];
uvLeft = [];
hold on;
for i = 1:1:n
    [u, v] = ginput(1);
    plot(u, v, 'g.', 'MarkerSize', 12);
    uvLeft = [
        uvLeft;
        u, v;
    ];
end
hold off;

figure(2);
set(gcf, 'position',[940, 200, 640, 720]);
imagesc(rightImage);
% [u, v] = textread('uvRight.txt','%f,%f');
% uvRight = [u, v];
uvRight = [];
hold on;
for i = 1:1:n
    [u, v] = ginput(1);
    plot(u, v, 'g.', 'MarkerSize', 12);
    uvRight = [
        uvRight;
        u, v;
    ];
end
hold off;

% Calculate the F-matrix using instructions as discussed in the slides.
P = [];
for i = 1:1:n
    uL = uvLeft(i, 1);
    vL = uvLeft(i, 2);
    uR = uvRight(i, 1);
    vR = uvRight(i, 2);
    P = [
        P;
        uL * uR, uL * vR, uL, vL * uR, vL * vR, vL, uR, vR
    ];
end
f = inv(P) * (-[1;1;1;1;1;1;1;1]);
F = [
    f(1), f(2), f(3);
    f(4), f(5), f(6);
    f(7), f(8), 1
];

% Choose a point in the left image and calculate the epipolar line in the right image. Display the point and the line as overlays in your images.
% Do the same for a point in the right image and epipolar line in the left image.
figure(1);
hold on;
leftPoint = ginput(1);
plot(leftPoint(1), leftPoint(2), '.', 'MarkerSize', 20, 'Color', [0.95, 0.26, 0.21]);
hold off;
l = [leftPoint(1), leftPoint(2), 1] * F;
L = l;
clear l;

x = 0: 3120;
y = (- x * L(1) - L(3)) / L(2);
figure(2);
hold on;
plot(x, y, '-', 'LineWidth', 1.0, 'Color', [0.95, 0.26, 0.21]);
clear x y;
% for i = 1:1:n
%     l = [uvLeft(i, 1), uvLeft(i, 2), 1] * F;
%     L = l / norm([l(1), l(2)]);
%     x = 0: 3120;
%     y = (- x * L(1) - L(3)) / L(2);
%     plot(x, y, 'g-', 'LineWidth', 1.0);
%     clear x y;
%     clear l;
% end
hold off;

figure(2);
rightPoint = ginput(1);
hold on;
plot(rightPoint(1), rightPoint(2), '.', 'MarkerSize', 20, 'Color', [0.13, 0.59, 0.95]);
hold off;
l = F * [rightPoint(1); rightPoint(2); 1];
L = l;
clear l;

x = 0: 3120;
y = (- x * L(1) - L(3)) / L(2);
figure(1);
hold on;
plot(x, y, '-', 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);
clear x y;
% for i = 1:1:n
%     l = F * [uvRight(i, 1); uvRight(i, 2); 1];
%     L = l / norm([l(1), l(2)]);
%     x = 0: 3120;
%     y = (- x * L(1) - L(3)) / L(2);
%     plot(x, y, 'g-', 'LineWidth', 1.0);
%     clear x y;
%     clear l;
% end
hold off;



% Calculate the position of the epipole of the left camera
[u, d] = eigs(F' * F);
uu = u(:, 1);
uu = uu / uu(3)
