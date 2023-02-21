function [output] = inner_product_forward(input, layer, param)

d = size(input.data, 1);
k = size(input.data, 2); % batch size
n = size(param.w, 2);

% Replace the following line with your implementation.
output.data = zeros([n, k]);

output.height = input.height;
output.width = input.width;
output.batch_size = k;
output.channel = input.channel;

in_d = input.data;
out_d = zeros([n, k]);
pw = param.w;
pb = param.b;


for i = 1:k
    out_d(:,i) = (in_d(:,i).' * pw + pb)';
end

output.data = out_d;


end
