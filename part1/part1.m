% CSE 473/573 Programming Assignment 1, starter Matlab code
% Adapted from A. Efros
% (http://graphics.cs.cmu.edu/courses/15-463/2010_fall/hw/proj1/)
% and R. Fergus
% http://cs.nyu.edu/~fergus/teaching/vision/assign1.pdf
clear all; close all; clc;
% name of the input file
imname = 'part1_6.jpg';

% read in the image
fullim = imread(imname);

% convert to double matrix 
fullim = im2double(fullim);

% compute the height of each part (just 1/3 of total)
height = floor(size(fullim,1)/3);
% separate color channels
B = fullim(1:height,:);
G = fullim(height+1:height*2,:);
R = fullim(height*2+1:height*3,:);
% Perform edge detection over all images i.e. B,G,R
eB = edge(B,'canny');
eG = edge(G,'canny');
eR = edge(R,'canny');
%--------------------------------------------END
% Align the images
% Functions that might be useful to you for aligning the images include: 
% "circshift", "sum"
% Finding the least SSD and then finding the displacement points
% between eG and eB--------------------------BEGIN
min = inf;
for i=-20:20

    for j=-20:20
        cG = circshift(eG,[i j] );
        s = sum(sum((eB-cG).^2));
        if s <= min
            min = s;
            i1 = i;
            j1 = j;
        end
    
    end
end
%--------------------------------------------END
% Perform the displacement here: ---- BEGIN
Gs = circshift(eG,[i1 j1]);
G1 = circshift(G,[i1 j1]);
% ----------------------------------- END

% Finding the least SSD and then finding the displacement points
% between Gs and eR--------------------------BEGIN
min1 = inf;
for i=-20:20
    for j=-20:20
        cR = circshift(eR,[i j]);
        s1 = sum(sum((Gs-cR).^2));
        if s1 <= min1
            min1 = s1;
            i2 = i;
            j2 = j;
        end
    
    end
end
%--------------------------------------------END

% Perform the displacement here: ---- BEGIN
R1 = circshift(R,[i2 j2]);
% ----------------------------------- END

% open figure
%% figure(1);
% create a color image (3D array)
% ... use the "cat" command
f = cat(3,R1,G1,B);
% show the resulting image
% ... use the "imshow" command
imshow(f);
% save result image
imwrite(colorim,['result-' imname]);

