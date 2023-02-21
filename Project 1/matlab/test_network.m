%% Network defintion
layers = get_lenet();

%% Loading data
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);

% load the trained weights
load lenet.mat

%% Testing the network
% Modify the code to get the confusion matrix

matrix = zeros(10,10);
st = size(xtest,2);

for n=1:100:size(xtest,2)
    xt = xtest(:,n:n+99);
    yt = ytest(:,n:n+99);
    [output, A] = convnet_forward(params, layers, xt);
    [~, res] = max(A);

    temp = confusionchart(yt, res);
    matrix = matrix + temp.NormalizedValues;
end

disp(matrix);