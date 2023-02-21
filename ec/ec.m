%% Network defintion
addpath('../matlab/');
layers = get_lenet();

%% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);

% load the trained weights
load lenet.mat

path1 = sprintf('../images/image1.JPG');
path2 = sprintf('../images/image2.JPG');
path3 = sprintf('../images/image3.png');
path4 = sprintf('../images/image4.jpg');

% change path for different image
% convert input images to grayscale images
img = rgb2gray(imread(path4));

% classify each pixel as foreground or background pixel
level = graythresh(img);
BW = imbinarize(img,level);
BW = 1 - BW;

% connect disconnected area in each character
se = strel('disk',2);
BW = imclose(BW,se);

% find connected components
conc = bwconncomp(BW,6);

% find the centroid of each character
% and place a bounding box around each character
figure;
s = regionprops(conc, {'BoundingBox', 'Centroid'});
cens = cat(1, s.Centroid);
bbox = cat(1, s.BoundingBox);
imshow(img)
hold on
n = size(bbox,1);
c1 = cens(:,1);
c2 = cens(:,2);
plot(c1, c2,'b*')

for i = 1:n
    a = cens(i,1);
    b = cens(i,2);
    num = num2str(i);
    text(a, b, num, 'Color', 'r')
end

for j = 1:n
    bb = bbox(j,:);
    rectangle('Position', bb, 'EdgeColor', 'b')
end
hold off

% pad each bounding box and resize it to 28 * 28
crop = 28;
test = zeros(crop*crop, 100);
for k = 1:n
    temp1 = imcrop(BW, bbox(k,:));
    temp2 = imresize(temp1,[crop,crop]);
    test(:,k) = reshape(temp2',[],1);
end

% pass padded bounding box through the network
[~, P] = convnet_forward(params, layers, test);
[~, res] = max(P);
disp(P(:,1:n))
disp(res(1:n)-1)



