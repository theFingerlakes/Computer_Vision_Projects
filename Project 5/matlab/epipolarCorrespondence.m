function [pts2] = epipolarCorrespondence(im1, im2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
%
im1 = double(im1);
im2 = double(im2);
[~,w,~] = size(im1);
window_size = 5;
[N,] = size(pts1);
pts2 = [];
for n = 1:N
    x = pts1(n,1);
    y = pts1(n,2);
    window1 = im1(y-window_size:y+window_size, x-window_size:x+window_size,:);
    l = F * [x,y,1]';
    pts = [];
    euclidean_distance = [];

    for dx = 1+window_size:w-window_size
        dy = round((-l(3) - l(1)*dx)/l(2));
        window2 = im2(dy-window_size:dy+window_size, dx-window_size:dx+window_size,:);
        pts = [pts; dx, dy];
        euclidean_distance = [euclidean_distance; norm(window1(:) - window2(:))];
    end
    pts2 = [pts2; pts(find(euclidean_distance==min(euclidean_distance),1),:)];
end