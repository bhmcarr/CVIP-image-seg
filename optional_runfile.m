% Homework 2 Runfile


% animal image
I = imread('images/zebra.jpg');

% background image
B = imread('images/bg3.jpg');

% number of clusters
k = 2;

% change this value if the resulting image uses the wrong segment
% (change this value to the determined foreground vector)
fg_vec = [2];

% perform the segmentation
[idx] = segmentImg(I, k);

% create our new image
newImg = transferImg(fg_vec, idx, I, B);

% write image to disk
imwrite(newImg,'segZebra.jpg');

% display the image
imshow(newImg);