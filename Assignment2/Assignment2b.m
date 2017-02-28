clear all;
clc;
close all;

leftImage = imread('left2.jpg');
rightImage = imread('right2.jpg');

figure(1);
set(gcf, 'position',[300, 200, 640, 720]);
imagesc(leftImage);
% Specify a set of corresponding pixel landmark pairs in the left and right camera views.
uvLeft = [];
hold on;
for i = 1:1:7
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
uvRight = [];
hold on;
for i = 1:1:7
    [u, v] = ginput(1);
    plot(u, v, 'g.', 'MarkerSize', 12);
    uvRight = [
        uvRight;
        u, v;
    ];
end
hold off;

f = 3.79;
B = 100;
density = 1 / 900;
u0 = 1560;
v0 = 2080;
coordinate = [];
for i = 1:1:7
    u1 = uvLeft(i, 1);
    v1 = uvLeft(i, 2);
    u2 = uvRight(i, 1);
    v2 = uvRight(i, 2);
    Z = f * B / ((u1 - u2) * density);
    X = (u1 - u0) / f * Z;
    Y = (v1 - v0) / f * Z;
    coordinate = [
        coordinate;
        X, Y, Z
    ];
end
figure(3)
hold on;
for i = 1:1:7
    plot3(coordinate(i, 1), coordinate(i, 2), coordinate(i, 3), '.', 'MarkerSize', 12, 'Color', [0.13, 0.59, 0.95]);
end
line([coordinate(1,1),coordinate(2,1)],[coordinate(1,2),coordinate(2,2)],[coordinate(1,3),coordinate(2,3)], 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);
line([coordinate(2,1),coordinate(3,1)],[coordinate(2,2),coordinate(3,2)],[coordinate(2,3),coordinate(3,3)], 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);
line([coordinate(3,1),coordinate(4,1)],[coordinate(3,2),coordinate(4,2)],[coordinate(3,3),coordinate(4,3)], 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);
line([coordinate(4,1),coordinate(1,1)],[coordinate(4,2),coordinate(1,2)],[coordinate(4,3),coordinate(1,3)], 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);
line([coordinate(5,1),coordinate(6,1)],[coordinate(5,2),coordinate(6,2)],[coordinate(5,3),coordinate(6,3)], 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);
line([coordinate(6,1),coordinate(7,1)],[coordinate(6,2),coordinate(7,2)],[coordinate(6,3),coordinate(7,3)], 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);

line([coordinate(1,1),coordinate(5,1)],[coordinate(1,2),coordinate(5,2)],[coordinate(1,3),coordinate(5,3)], 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);
line([coordinate(2,1),coordinate(6,1)],[coordinate(2,2),coordinate(6,2)],[coordinate(2,3),coordinate(6,3)], 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);
line([coordinate(3,1),coordinate(7,1)],[coordinate(3,2),coordinate(7,2)],[coordinate(3,3),coordinate(7,3)], 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);

% 69 * 69 * 80
