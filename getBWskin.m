% Get BW Image of skin Region 
function [bw] = getBWskin(I)
I = I-30;
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
see = strel('square',7);
bw = imerode(bw,see);
sed = strel('square',4);
bw = imdilate(bw,sed);
bw = im2bw(im,0.4);
see = strel('square',7);
bw = imerode(bw,see);
sed = strel('square',9);
bw = imdilate(bw,sed);
see = strel('square',7);
bw = imerode(bw,see);
sed = strel('square',12);
bw = imdilate(bw,sed);
end
