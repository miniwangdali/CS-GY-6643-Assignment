function resultFrames = drawHands(results, size, frames)
    resultFrames = [];
    for i = 1:1:size - 1
        result = results(i).points;
        resultF = results(i + 1).points;
        delta = zeros(20, 3);
        for j = 1:1:20
            dx = resultF(j, 1) - result(j, 1);
            dy = resultF(j, 2) - result(j, 2);
            dz = resultF(j, 3) - result(j, 3);
            delta(j, 1) = dx / frames;
            delta(j, 2) = dy / frames;
            delta(j, 3) = dz / frames;
        end

        for j = 1:1:frames
            link1 = [
                result(1,:) + delta(1, :) * j;
                result(2,:) + delta(2, :) * j;
                result(3,:) + delta(3, :) * j;
                result(20,:) + delta(20, :) * j;
            ];
            link2 = [
                result(4,:) + delta(4, :) * j;
                result(5,:) + delta(5, :) * j;
                result(6,:) + delta(6, :) * j;
                result(7,:) + delta(7, :) * j;
                result(20,:) + delta(20, :) * j;
            ];
            link3 = [
                result(8,:) + delta(8, :) * j;
                result(9,:) + delta(9, :) * j;
                result(10,:) + delta(10, :) * j;
                result(11,:) + delta(11, :) * j;
                result(20,:) + delta(20, :) * j;
            ];
            link4 = [
                result(12,:) + delta(12, :) * j;
                result(13,:) + delta(13, :) * j;
                result(14,:) + delta(14, :) * j;
                result(15,:) + delta(15, :) * j;
                result(20,:) + delta(20, :) * j;
            ];
            link5 = [
                result(16,:) + delta(16, :) * j;
                result(17,:) + delta(17, :) * j;
                result(18,:) + delta(18, :) * j;
                result(19,:) + delta(19, :) * j;
                result(20,:) + delta(20, :) * j;
            ];
            h1 = drawSkeleton(link1, 3, 2);
            h2 = drawSkeleton(link2, 3, 2);
            h3 = drawSkeleton(link3, 3, 2);
            h4 = drawSkeleton(link4, 3, 2);
            h5 = drawSkeleton(link5, 3, 2);
            axis([-80 80 -10 150 -10 150]);
            F(j) = getframe;
            delete([h1, h2, h3, h4, h5]);
        end
        resultFrames = [resultFrames, F];
    end
    