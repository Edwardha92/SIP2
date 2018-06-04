function akf = calculate_akf(ecg_chunk)
%CALCULATE_AKF multiplies the time based ecg_chunk and calculates its
%auto-correlation which is returned.

    ecg = ecg_chunk .* blackman(size(ecg_chunk,2), 'symmetric')';
    akf = xcorr(ecg, ecg);
end