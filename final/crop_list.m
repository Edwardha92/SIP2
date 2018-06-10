%Review: Edward 10.06.2018
function [cropped_list] = crop_list(akf_list)
%CROP_LIST will extract a window of the first sidelobe peak from the list.
%
% The extraction is made in the lower half of the horizontally symmetric
% akf list. To only extract the desired peak an offset of 39 values from
% the half downwards is added.
%
%
% Review: Stanislav 10.06.2018

    half_idx = floor(size(akf_list,1) / 2) + 39;
    cropped_list = akf_list(half_idx:half_idx + 103,:);
end

