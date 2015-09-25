cam=webcam(1);
for i=1:50
    snap=snapshot(cam);
    I=snap;
    %bw = getBWskin(I);
   % I = I-30;
   I(:,:,1) = imadjust(I(:,:,1));
   I(:,:,2) = imadjust(I(:,:,2));
   I(:,:,3) = imadjust(I(:,:,3));
   %I = imresize(I,0.5);
   I=double(I);
   [hue,s,v]=rgb2hsv(I);
   
   cb =  0.148* I(:,:,1) - 0.291* I(:,:,2) + 0.439 * I(:,:,3) + 128;
   cr =  0.439 * I(:,:,1) - 0.368 * I(:,:,2) -0.071 * I(:,:,3) + 128;
   [w h]=size(I(:,:,1));
   
   for i=1:w
       for j=1:h
           if  143<=cr(i,j) && cr(i,j)<=170 && 140<=cb(i,j) && cb(i,j)<=190 && 0.01<=hue(i,j) && hue(i,j)<=0.1
               segment(i,j)=1;
           else
               segment(i,j)=0;
           end
       end
   end
   
   % imshow(segment);
   im(:,:,1)=I(:,:,1).*segment;
   im(:,:,2)=I(:,:,2).*segment;
   im(:,:,3)=I(:,:,3).*segment;
   %imshow(uint8(im));
   
   bw = im2bw(im,0.4);
   bw = imerode(bw,strel('square',7));
   bw = imdilate(bw,strel('square',7));
   bw = imerode(bw,strel('square',7));
   bw = imdilate(bw,strel('square',9));
   bw = imerode(bw,strel('square',7));
   bw = imdilate(bw,strel('rectangle',[15 12]));
   %bw = imerode(bw,strel('disk',7));
   %bw = imdilate(bw,strel('disk',5));
   b = bwboundaries(bw,'noholes');
   if length(b) ~= 0
       maxBoundary = b{1};
       for j = 1:length(b)
           if length(b{j}) > length(maxBoundary)
               maxBoundary = b{j};
           end
       end
       plot(-maxBoundary(:,2),-maxBoundary(:,1), 'r', 'LineWidth', 2);
   end
end
clear cam
