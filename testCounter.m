cam=webcam(1);
for i=1:70
    snap=snapshot(cam);
    bw = rgb2gray(snap);
    see = strel('square',7);
    bw = imerode(bw,see);
    sed = strel('square',6);
    bw = imdilate(bw,sed);
    see = strel('square',7);
    bw = imerode(bw,see);
    sed = strel('square',9);
    imshowpair(bw,snap,'montage');
end
clear cam;