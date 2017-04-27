function handle = drawSkeleton(points, pointsRadius, barRadius)
    handle = [];
    size = numel(points) / 3;
    hold on;
    axis equal;
    % point sphere
    [x, y, z] = sphere(36);
    for i = 1:1:size
        h = surf(pointsRadius * x + points(i, 1), pointsRadius * y + points(i, 2), pointsRadius * z + points(i, 3), 'EdgeColor', 'none');
        handle = [handle, h];
    end

    % bar between points
    for i = 1:1:size - 1
        [x, y, z] = cylinder2P(barRadius, 36, 4, points(i, :), points(i + 1, :));
        h = surf(x, y, z, 'EdgeColor', 'none');
        handle = [handle, h];
    end
    hold off;