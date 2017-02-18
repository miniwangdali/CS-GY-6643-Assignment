clear all;
clc;
close all;
[u, v] = textread('imageUVData.txt', '%f,%f');
imageUV = [u, v];
[x, y, z] = textread('Coordinates3DData.txt', '%f,%f,%f');
worldXYZ = [x, y, z];
figure(1);
patternImageMatrix = imread('pattern.jpg');
set(gcf, 'position',[0, 0, 1920,1080]);
h = image(patternImageMatrix);
hold on;
for i = 1:1:length(imageUV)
    plot(imageUV(i, 1), imageUV(i, 2), 'o','MarkerSize', 3, 'Color',[1.0, 0.0, 0.0]);
end
% 1568, 2863
plot(1568, 2863, 'o', 'MarkerSize', 3, 'Color',[0.4, 0.8, 1.0]);
line([1568, 1523], [2863, 2871], 'Color',[0.4, 0.8, 1.0]);
text(1533, 2881, 'x','Color',[0.4, 0.8, 1.0]);
line([1568, 1607], [2863, 2868], 'Color',[0.4, 0.8, 1.0]);
text(1617, 2878, 'y','Color',[0.4, 0.8, 1.0]);
line([1568, 1565], [2863, 2703], 'Color',[0.4, 0.8, 1.0]);
text(1575, 2713, 'z','Color',[0.4, 0.8, 1.0]);
saveas(h, 'preview.jpg');

n = length(imageUV);
P = [];
for i = 1:1:n
    P = [
        P;
        worldXYZ(i, :),1,0,0,0,0,- imageUV(i, 1) * worldXYZ(i, :), - imageUV(i, 1);
        0,0,0,0,worldXYZ(i, :),1,- imageUV(i, 2) * worldXYZ(i, :), - imageUV(i, 2)
        ];
end
[U, S, V] = svd(P);
[min_val, min_index] = min(diag(S(1:12, 1:12)));
m = V(1:12, min_index);
M = [m(1),m(2),m(3),m(4);
     m(5),m(6),m(7),m(8);
     m(9),m(10),m(11),m(12)]

a1 = [m(1),m(2),m(3)];
a2 = [m(5),m(6),m(7)];
a3 = [m(9),m(10),m(11)];

rou = -1 / norm(a3)
u0 = rou * rou * dot(a1, a3)
v0 = rou * rou * dot(a2, a3)
theta = acos(- (dot(cross(a1, a3), cross(a2, a3)) / (norm(cross(a1, a3)) * norm(cross(a2, a3)))))
alpha = rou * rou * norm(cross(a1, a3)) * sin(theta)
beta = rou * rou * norm(cross(a2, a3)) * sin(theta)

r3 = rou * a3;
r1 = 1 / norm(cross(a2, a3)) * cross(a2, a3);
r2 = cross(r3, r1);
tZ = M(3, 4);
tY = (M(2, 4) - v0 * tZ) / (beta / sin(theta));
tX = (M(1, 4) - u0 * tZ + alpha * cot(theta) * tY) / alpha;
R = [r1; r2; r3]
T = rou * [tX; tY; tZ]
intrinsicMatrix = [alpha, -alpha * cot(theta), u0, 0; 0, beta / sin(theta), v0, 0; 0, 0, 1, 0]
extrinsicMatrix = [R(1, :), T(1); R(2, :), T(2); R(3, :), T(3); 0, 0, 0, 1]
reconstructMatrix = zeros(n, 2);
fid = fopen('reconstructUV.txt', 'wt');
for i = 1:1:n
    P1 = transpose([worldXYZ(i, :),1]);
    reconstructMatrix(i, 1) = M(1, :) * P1 / (M(3, :) * P1);
    reconstructMatrix(i, 2) = M(2, :) * P1 / (M(3, :) * P1);
    fprintf(fid, '%f,', reconstructMatrix(i, 1));
    fprintf(fid, '%f\n', reconstructMatrix(i, 2));
end
fclose(fid);



