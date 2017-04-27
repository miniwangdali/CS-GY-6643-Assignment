clear all;
results = [];
video = VideoReader('hand_horizontal.mov');
f = 0;
while hasFrame(video)
    frame = readFrame(video);
    if rem(f, 30) == 0
        r = struct('points', positions(frame));
        results = [results, r];
    end
    f = f + 1;
end

close all;
fig = figure(2);
view(30, 15);
axis equal;
axis off;
camlight('headlight');
lighting flat;
shading interp;
set(gca, 'nextplot', 'replacechildren');
resultFrames = drawHands(results, 7, 30);
v = VideoWriter('test');
open(v);
writeVideo(v, resultFrames);
close(v);
movie(resultFrames, 10, 30);
