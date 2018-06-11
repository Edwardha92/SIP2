%
%
% Review: Stas 10.06.2018
% Review: Alexandros 11.06.2018

ecg = ones(512,1)';
akf_list = ones(1023,121);
[input , akf_list] = generate_input_vector(ecg, akf_list);

if size(input) ~= 0
    o = classify(input);
else
    o = classify(ones(1,26));
end