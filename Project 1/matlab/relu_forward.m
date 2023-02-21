function [output] = relu_forward(input)
output.height = input.height;
output.width = input.width;
output.channel = input.channel;
output.batch_size = input.batch_size;

% Replace the following line with your implementation.
input_data = input.data;
input_size = size(input_data);

output.data = zeros(input_size);
input_gre = input_data(input_data>0);

output.data(input_data>0) = input_gre;

end
