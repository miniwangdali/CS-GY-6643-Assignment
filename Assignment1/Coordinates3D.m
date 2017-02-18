mHeight = 28.3;
mWidth = 27.7;
offsetX = 10;
offsetY = 9;
offsetZ = 0;
fid = fopen('Coordinates3DData.txt', 'wt');
for z = 9:-1:0
    for x = 7:-1:0
        fprintf(fid, '%f,', x * mWidth + offsetX);
        fprintf(fid, '%f,', 0);
        fprintf(fid, '%f\n', z * mHeight + offsetZ);
    end
    for y = 0:1:7
        fprintf(fid, '%f,', 0);
        fprintf(fid, '%f,', y * mWidth + offsetY);
        fprintf(fid, '%f\n', z * mHeight + offsetZ);
    end
end
fclose(fid);