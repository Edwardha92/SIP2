function akf_list = calculate_akf(ecg_chunk)
    akf_list = [];

    step_size = 50;
    akf_length = 511;
    
    for i = 1:step_size:length(ecg_chunk) - akf_length
        ecg = ecg_chunk(i:i+akf_length);
        
        ecg = ecg .* blackman(size(ecg,2), 'symmetric')';
        
        akf = xcorr(ecg, ecg);
        akf_list = [akf_list akf'];
    end
   
end