function [input_vector, akf_list] = generate_input_vector(ecg_chunk, akf_list)
%GENERATE_INPUT_VECTOR  This 
%
%
%
%
    list_length = 121;
    akf_length = 512; 
    
    input_vector = [];
    if size(ecg_chunk,2) ~= akf_length
        info('expected ecg chunk length is 512. The provided data has %d values instead.', size(ecg_chunk,2));
        return;
    end

    ecg = ecg_chunk .* blackman(size(ecg_chunk,2), 'symmetric')';
    akf = xcorr(ecg, ecg);

    if size(akf_list,2) < list_length
       akf_list = [akf_list akf'];
       return;
    end

    % Generate ringbuffer for the list
    akf_list = [akf_list(:,2:end) akf'];

    [values, indeces] = process_list(akf_list);

    input_vector = [values indeces]';
%     warning ('on','all');
end

function [values, indeces] = process_list(akf_list)
    % PROCESS_LIST Extract and smooth max values and corresponding indeces.
    %   [VALUES, INDECES] = PROCESS_LIST(AKF_LIST)

%     filter_coeff = get_filter_coeff();
    
%     show_images = false;
    downsample_rate = 10;
    
    half_idx = size(akf_list,1) / 2;
    cropped_list = akf_list(half_idx + 39:half_idx + 142,:);
    [max_val, max_idx] = max(cropped_list);
        
%     filtered_index = int64(ceil(filtfilt(filter_coeff, [1], idx)));
%     filtered_index(filtered_index == 0) = 1;
%     filtered_index = int64(ceil(filtfilt(1/6 * [1 1 1 1 1 1], [1], idx))); % experimental derived values
%     filtered_max = val(:,filtered_index);

    filtered_idx = max_idx;
    filtered_max_val = max_val;


    values = downsample(filtered_max_val, downsample_rate);
    indeces = double(downsample(filtered_idx, downsample_rate));
    
%     values = [values filtered_max_val(end)];
%     indeces = [indeces filtered_idx(end)];
    
%     if show_images == true
% %         hit_rate = 0;
% %         if obj.data_type == 0
% %             hit_rate = obj.n_no / (obj.n_ap + obj.n_no)
% %         else
% %             hit_rate = obj.n_ap / (obj.n_ap + obj.n_no)
% %         end
% %         figHdl = figure(obj.figure_handle); hold on;
% %         set(figHdl, 'Name', sprintf('Hitrate: %f', hit_rate));
%         subplot(2,2,3); imagesc(akf_list); title('AKF list'); %ylim([-hist_half_idx hist_half_idx]);
%         subplot(2,2,4); imagesc(cropped_list); title('AKF window'); hold on; scatter(1:length(max_idx),max_idx, 'gx'); scatter(1:downsample_rate:size(filtered_idx,2), indeces, 'r','filled');
% 
%         subplot(2,2,2); plot(1:length(max_idx), max_idx); title('Indeces'); set(gca, 'YDir', 'Reverse'); 
%         hdl_values = subplot(2,2,1); cla(hdl_values); plot(1:length(max_val), max_val); title('Values');  
%         set(gca, 'YDir', 'Reverse');
%         drawnow;
%     end
end
        
                
function coeff = get_filter_coeff()
    Fs    = 20; %8 Hz     % Sampling Frequency

    N     = 10;     % Order
    Fpass = 5;      % Passband Frequency
    Fstop = 10;     % Stopband Frequency
    Wpass = 10;     % Passband Weight
    Wstop = 10;     % Stopband Weight
    dens  = 20;     % Density Factor

    coeff  = firpm(N, [0 Fpass Fstop Fs/2]/(Fs/2), [1 1 0 0], [Wpass Wstop], {dens});
%     Hd = dfilt.dffir(coeff);
end