function [no_vec, ap_vec] = assemble_training_data(root_path)
%ASSEMBLE_TRAINING_DATA This function will return the training vectors for
%apnoe and no event from all files located at root_path. It iterates over
%all patient folders. Each folder must have a 'NO_Event' and 'Abstructive
%Apnoe' subfolder with the ecg data in a *.mat file.
%The vectors can be mixed to create a suitable training matrix for a 
%artificial neural network.

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
end