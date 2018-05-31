function [cropped_list] = crop_list(akf_list)
    half_idx = size(akf_list,1) / 2;
    cropped_list = akf_list(half_idx + 39:half_idx + 142,:);
end

