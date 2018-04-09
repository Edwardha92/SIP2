input = [0 0 1 0 0 0 0 0 0 0 0];
output = core(input);

figure(1);
scatter(1:size(input,2),input, 'x'); hold on;
scatter(1:size(output,2),output);