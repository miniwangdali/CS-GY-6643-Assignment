[u, v] = textread('imageUVData.txt', '%u,%u');
imageUV = [u, v];
[x, y, z] = textread('Coordinates3DData.txt', '%u,%u,%u');
worldXYZ = [x, y, z];
patternImageMatrix = imread('pattern.jpg');
% grayImageMatrix = rgb2gray(patternImageMatrix);
set(gcf, 'position',[0, 0, 1920,1080]);
h = image(patternImageMatrix);
% colormap(gray);
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
pMatrix = zeros(320, 12);
for i = 1:1:160
    uI = 2 * i - 1;
    vI = i;
    pMatrix(uI, 1) = worldXYZ(i, 1);
    pMatrix(uI, 2) = worldXYZ(i, 2);
    pMatrix(uI, 3) = worldXYZ(i, 3);
    pMatrix(uI, 4) = 1;
    pMatrix(uI, 9) = - imageUV(i, 1) * worldXYZ(i, 1);
    pMatrix(uI, 10) = - imageUV(i, 1) * worldXYZ(i, 2);
    pMatrix(uI, 11) = - imageUV(i, 1) * worldXYZ(i, 3);
    pMatrix(uI, 12) = - imageUV(i, 1);
    
    pMatrix(vI, 5) = worldXYZ(i, 1);
    pMatrix(vI, 6) = worldXYZ(i, 2);
    pMatrix(vI, 7) = worldXYZ(i, 3);
    pMatrix(vI, 8) = 1;
    pMatrix(vI, 9) = - imageUV(i, 2) * worldXYZ(i, 1);
    pMatrix(vI, 10) = - imageUV(i, 2) * worldXYZ(i, 2);
    pMatrix(vI, 11) = - imageUV(i, 2) * worldXYZ(i, 3);
    pMatrix(vI, 12) = - imageUV(i, 2);
end
[U, S, V] = svd(pMatrix);
[min_val, min_index] = min(diag(S(1:12, 1:12)));
mMatrix = V(1:12, min_index);
mMatrix = reshape(mMatrix, 3, 4);
% epsilon = 1;
syms a31 a32 a33;
eqn1 = mMatrix(3, 1) == (a31^2 + a32^2 + a33^2) * a31;
eqn2 = mMatrix(3, 2) == (a31^2 + a32^2 + a33^2) * a32;
eqn3 = mMatrix(3, 3) == (a31^2 + a32^2 + a33^2) * a33;
[a31, a32, a33] = solve(eqn1, eqn2, eqn3, a31, a32, a33, 'Real', 1);
a3 = double([a31, a32, a33]);
rou = norm(a3);
a2 = mMatrix(2, 1:3) / rou;
a1 = mMatrix(1, 1:3) / rou;
u0 = rou^2 * dot(a1, a3);
v0 = rou^2 * dot(a2, a3);
cosTheta = - (dot(cross(a1, a3), cross(a2, a3)) / (norm(cross(a1, a3)) * norm(cross(a2, a3))));
theta = rad2deg(acos(cosTheta));
sinTheta = sin(theta);
alpha = rou^2 * norm(cross(a1, a3)) * sinTheta;
beta = rou^2 * norm(cross(a2, a3)) * sinTheta;
r3 = rou * a3;
r1 = cross(a2, a3) / norm(cross(a2, a3));
r2 = cross(a3, a1);
tZ = mMatrix(3, 4);
tY = (mMatrix(2, 4) - v0 * tZ) / beta * sinTheta;
tX = (mMatrix(1, 4) - u0 * tZ + alpha * cot(theta) * tY) / alpha;
rotationMatrix = [r1; r2; r3];
dispMatrix = [tX; tY; tZ];
intrinsicMatrix = [alpha, -alpha * cot(theta), u0, 0; 0, beta / sinTheta, v0, 0; 0, 0, 1, 0];
extrinsicMatrix = [rotationMatrix, dispMatrix; 0, 0, 0, 1];
focal = 3.79;
reconstructMatrix = zeros(160, 3);
for i = 1:1:160
    reconstructMatrix(i,:) = 1 / focal * intrinsicMatrix * extrinsicMatrix * [worldXYZ(i,:)';1];
end
% epsilon = -1;


