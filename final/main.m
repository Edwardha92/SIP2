net = load('bestNet100.mat');

ecg = ones(512,1)';
akf_list = [];
[input , akf_list] = generate_input_vector(ecg, akf_list);

if size(input) ~= 0
    o = net.bestNet100(input); 
end