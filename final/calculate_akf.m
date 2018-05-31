function akf = calculate_akf(ecg_chunk)
    ecg = ecg_chunk .* blackman(size(ecg_chunk,2), 'symmetric')';
    akf = xcorr(ecg, ecg);
end