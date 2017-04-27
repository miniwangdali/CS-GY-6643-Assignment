clear all;
close all;
clc;

fig = figure(1);
axis tight;
axis off;
camlight('headlight');
lighting flat;
shading interp;
set(gca,'nextplot','replacechildren');
F(120) = struct('cdata',[],'colormap',[]);
% v = VideoWriter('test.mp4');
% open(v);
for i = 1:1:120
    points = [
        0, 0, 0 + i;
        10 + i, 10, 10;
        20, 30 + i, 40
    ];
	h = drawSkeleton(points, 3, 2);
    F(i) = getframe;
%     writeVideo(v, F(i));
    delete(h);
end
% close(v);
movie(F, 10, 24);
