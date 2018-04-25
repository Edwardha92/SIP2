function akf_list = calculate_akf(ecg_chunk)
    show_images = true;
    akf_list = [];

    akf_count = fix(length(ecg_chunk)/121) * 121;
    step_size = 50;
    akf_length = 512;
    
    for i = 1:step_size:length(ecg_chunk) - akf_length
        ecg = ecg_chunk(i:i+akf_length);
        akf = xcorr(ecg, ecg);
        akf_list = [akf_list akf'];
    end
    
%     imshow(akf_list);
%     imagesc(akf_list);
    
%     singleData = ecg_chunk; % load(strcat(dataFiles(fileIdx).folder, '\', dataFiles(fileIdx).name));
%     x=size(singleData);
%     y=fix(x/141)*141;
% 
%     for ecg_index=1:141:y(2)
%         ecg_fenster = singleData(ecg_index:ecg_index+141);
%         akf_fenster=xcorr(ecg_fenster,ecg_fenster);
%         akf_list = [akf_list akf_fenster'];
%     end
%     
%     size_akf=size(akf_list);
%     ii=fix(size_akf(1)/121)*121;
%     for i =1:121:ii
%         sliding_window=akf_list(:,i:i+120);
%         imshow(sliding_window);
%         imagesc(sliding_window);
%     end
    1+2;
end