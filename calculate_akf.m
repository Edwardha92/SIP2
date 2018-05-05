function akf_list = calculate_akf(ecg_chunk)
    akf_list = [];

    akf_count = fix(length(ecg_chunk)/121) * 121; 
    step_size = 50;
    akf_length = 512;
    
    for i = 1:step_size:length(ecg_chunk) - akf_length
        ecg = ecg_chunk(i:i+akf_length);
        akf = xcorr(ecg, ecg);
        akf_list = [akf_list akf'];
    end
   
end