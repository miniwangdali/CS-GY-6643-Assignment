clear all;
clc;
close all;

leftImage = imread('1.jpg');
rightImage = imread('2.jpg');

figure(1);
set(gcf, 'position',[300, 200, 640, 720]);
imagesc(leftImage);
% Specify a set of corresponding pixel landmark pairs in the left and right camera views.
uvLeft = [];
hold on;
for i = 1:1:20
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
for i = 1:1:20
    [u, v] = ginput(1);
    plot(u, v, 'g.', 'MarkerSize', 12);
    uvRight = [
        uvRight;
        u, v;
    ];
end
hold off;

f = 28;
B = 30;
density = 0.84;
u0 = 1560;
v0 = 2080;
coordinate = [];
for i = 1:1:20
    u1 = uvLeft(i, 1);
    v1 = uvLeft(i, 2);
    u2 = uvRight(i, 1);
    v2 = uvRight(i, 2);
    Z = f * B / (abs(u1 - u2) * density);
    X = (u1 - u0) / f * Z;
    Y = (v1 - v0) / f * Z;
    coordinate = [
        coordinate;
        X, Y, Z
    ];
end
figure(3)
hold on;
for i = 1:1:20
    plot3(coordinate(i, 1), coordinate(i, 2), coordinate(i, 3), '.', 'MarkerSize', 12, 'Color', [0.13, 0.59, 0.95]);
end
line([coordinate(1,1),coordinate(2,1)],[coordinate(1,2),coordinate(2,2)],[coordinate(1,3),coordinate(2,3)], 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);
line([coordinate(2,1),coordinate(3,1)],[coordinate(2,2),coordinate(3,2)],[coordinate(2,3),coordinate(3,3)], 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);
line([coordinate(3,1),coordinate(20,1)],[coordinate(3,2),coordinate(20,2)],[coordinate(3,3),coordinate(20,3)], 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);

line([coordinate(4,1),coordinate(5,1)],[coordinate(4,2),coordinate(5,2)],[coordinate(4,3),coordinate(5,3)], 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);
line([coordinate(5,1),coordinate(6,1)],[coordinate(5,2),coordinate(6,2)],[coordinate(5,3),coordinate(6,3)], 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);
line([coordinate(6,1),coordinate(7,1)],[coordinate(6,2),coordinate(7,2)],[coordinate(6,3),coordinate(7,3)], 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);
line([coordinate(7,1),coordinate(20,1)],[coordinate(7,2),coordinate(20,2)],[coordinate(7,3),coordinate(20,3)], 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);

line([coordinate(8,1),coordinate(9,1)],[coordinate(8,2),coordinate(9,2)],[coordinate(8,3),coordinate(9,3)], 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);
line([coordinate(9,1),coordinate(10,1)],[coordinate(9,2),coordinate(10,2)],[coordinate(9,3),coordinate(10,3)], 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);
line([coordinate(10,1),coordinate(11,1)],[coordinate(10,2),coordinate(11,2)],[coordinate(10,3),coordinate(11,3)], 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);
line([coordinate(11,1),coordinate(20,1)],[coordinate(11,2),coordinate(20,2)],[coordinate(11,3),coordinate(20,3)], 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);

line([coordinate(12,1),coordinate(13,1)],[coordinate(12,2),coordinate(13,2)],[coordinate(12,3),coordinate(13,3)], 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);
line([coordinate(13,1),coordinate(14,1)],[coordinate(13,2),coordinate(14,2)],[coordinate(13,3),coordinate(14,3)], 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);
line([coordinate(14,1),coordinate(15,1)],[coordinate(14,2),coordinate(15,2)],[coordinate(14,3),coordinate(15,3)], 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);
line([coordinate(15,1),coordinate(20,1)],[coordinate(15,2),coordinate(20,2)],[coordinate(15,3),coordinate(20,3)], 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);

line([coordinate(16,1),coordinate(17,1)],[coordinate(16,2),coordinate(17,2)],[coordinate(16,3),coordinate(17,3)], 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);
line([coordinate(17,1),coordinate(18,1)],[coordinate(17,2),coordinate(18,2)],[coordinate(17,3),coordinate(18,3)], 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);
line([coordinate(18,1),coordinate(19,1)],[coordinate(18,2),coordinate(19,2)],[coordinate(18,3),coordinate(19,3)], 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);
line([coordinate(19,1),coordinate(20,1)],[coordinate(19,2),coordinate(20,2)],[coordinate(19,3),coordinate(20,3)], 'LineWidth', 1.0, 'Color', [0.13, 0.59, 0.95]);
