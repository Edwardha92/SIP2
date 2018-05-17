root_path = 'D:\1dev\SIP2\bestData';

ecg_step_size = 50;
ecg_chunk_length = 511;

[no, ap] = get_ecg(root_path);

no_vec = [];
ap_vec = [];

akf_list = [];

for j = 1:size(ap,1)
    full_ecg = ap(j,:);
     for i = 1 : ecg_step_size : size(full_ecg,2) - ecg_chunk_length % mod(size(single_data,2), ecg_step_size)
        ecg_dat = full_ecg(i: i + ecg_chunk_length);
        [in_vec, akf_list] = generate_input_vector(ecg_dat, akf_list);
        
        if size(in_vec) ~= 0
           ap_vec = [ap_vec in_vec]; 
        end
     end
end

for j = 1:size(no,1)
    full_ecg = no(j,:);
     for i = 1 : ecg_step_size : size(full_ecg,2) - ecg_chunk_length % mod(size(single_data,2), ecg_step_size)
        ecg_dat = full_ecg(i: i + ecg_chunk_length);
        [in_vec, akf_list] = generate_input_vector(ecg_dat, akf_list);
        
        if size(in_vec) ~= 0
           no_vec = [no_vec in_vec]; 
        end
     end
end