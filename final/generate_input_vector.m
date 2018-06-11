%Review: Edward 10.06.2018
function [input_vector, akf_list] = generate_input_vector(ecg_chunk, akf_list)
% GENERATE_INPUT_VECTOR  This function will generate a feature vector based
% on a ecg vector of 512 elements and the akf_list.
%
% This method requires a ecg vector of 512 elements and a (empty) akf_list.
% The ecg vector will be processed and appended to the akf_list. This list
% is a ringbuffer containing maximum 121 elements. When the list is full
% the max values and the corresponding indeces will be extracted from the
% second maximum of the lower half of the akf_list. 
%
% Review: Stanislav 10.06.2018
% Review: Alexnadros 10.06.2018

    list_length = 121;
    ecg_length = 512; 
    
    input_vector = [];
    if size(ecg_chunk,2) ~= ecg_length
        return;
    end

    akf = calculate_akf(ecg_chunk);

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
    downsample_rate = 10;
        
    cropped_list = crop_list(akf_list);
    
    [max_val, max_idx] = max(cropped_list);

    values = downsample(max_val, downsample_rate);
    indeces = double(downsample(max_idx, downsample_rate));
end