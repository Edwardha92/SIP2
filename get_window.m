function [data, index] = get_window(akf_list)
    size_akf=size(akf_list);
    akf_window = [];
    
    %filter_coeff = get_filter_coeff();
    
    data = [];
    index = [];
    
    for i =1:121:size_akf(2) - 121
        tmp = akf_list(size_akf(1)/2 + 39:size_akf(1) / 2 + 142, i:i + 120);
        akf_window = [akf_window tmp];
        %imshow(akf_fenster);hold on;
        %imagesc(akf_window);
        
        [dat, idx] = process(tmp);
        data = [data; dat];
        index = [index; idx]; 
    end
end 

function [downsampled_data, downsampled_idx] = process(akf_window)
    max_values = [];
    max_idx = [];
    for i = 1:size(akf_window,1)
        [mx, mxidx] = max(akf_window(i,:));
%          = [max_idx find(akf_window(:,i) == mx)];
        max_values = [max_values mx];
        max_idx = [max_idx mxidx];
    end
       
    
    downsampled_data = [max_values(1) downsample(max_values, 9, 4)];
    downsampled_idx = [max_idx(1) downsample(max_idx, 9, 4)];
    
    
    
%     mmax = max(max_values);
%     nm = zeros(size(akf_window));
%     for i = 1:length(max_values)
%         max_values(i) = max_values(i) / mmax;
%         nm(max_idx(i), i) = 10;
%     end
%         
%     new_max = filter(filter_coeff, [1], max_values);
%     subplot(2,1,1);plot(max_values);
%     subplot(2,1,2);plot(new_max);
%     
%     %% Training here %%%
%     ann(max_idx, max_values);
%     
%     
%     
%     sampled_data = [];
%     len = fix(length(new_max)/13);
%     for i = 1:len:length(new_max) - len
%         sampled_data = [sampled_data new_max(i)];
%     end
end

function coeff = get_filter_coeff()
    Fs    = 20;     % Sampling Frequency

    N     = 10;     % Order
    Fpass = 5;      % Passband Frequency
    Fstop = 10;     % Stopband Frequency
    Wpass = 10;     % Passband Weight
    Wstop = 10;     % Stopband Weight
    dens  = 20;     % Density Factor

    coeff  = firpm(N, [0 Fpass Fstop Fs/2]/(Fs/2), [1 1 0 0], [Wpass Wstop], {dens});
    Hd = dfilt.dffir(coeff);
end