mLength = 28;
offsetX = 10;
offsetY = 9;
offsetZ = 0;
fid = fopen('Coordinates3DData.txt', 'wt');
for z = 10:-1:1
    for x = 8:-1:1
        fprintf(fid, '%d,', x * mLength + offsetX);
        fprintf(fid, '%d,', 0);
        fprintf(fid, '%d\n', z * mLength + offsetZ);
    end
    for y = 1:1:8
        fprintf(fid, '%d,', 0);
        fprintf(fid, '%d,', y * mLength + offsetY);
        fprintf(fid, '%d\n', z * mLength + offsetZ);
    end
end
fclose(fid);