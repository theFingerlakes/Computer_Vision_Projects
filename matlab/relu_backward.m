function [input_od] = relu_backward(output, input, layer)

% Replace the following line with your implementation.

in_data = input.data;
in_size = size(in_data);
input_od = zeros(in_size);
od = output.diff;

input_od(in_data > 0) = 1;
input_od = input_od .* od;

end
