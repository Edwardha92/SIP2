classdef ECGProcessing < handle
    
    
    properties (Constant)
        histogram_length = 121;
        akf_length = 512;
        figure_handle = 24571;
    end
    
    
    
    properties (SetAccess = private, GetAccess = public)
        histogram = [];
        filter_coeff = [];
    end
    
    
    
    properties (SetAccess = public)
       show_images = true; 
    end
    
    
    
    methods
        function obj = set.histogram(obj, histogram)
            obj.histogram = histogram;
        end
        
        
        function obj = set.show_images(obj, value)
              obj.show_images = value;
        end
        
        
        function obj = ECGProcessing()
            obj.filter_coeff = obj.get_filter_coeff();
        end
        
        
        function input_vector = generate_input_vector(obj, ecg_chunk)
            input_vector = [];
            if size(ecg_chunk,2) ~= obj.akf_length
                error('expected ecg chunk length is 512. The provided data has %d values instead.', size(ecg_chunk,2));
                return;
            end
            
            ecg = ecg_chunk .* hamming(size(ecg_chunk,2), 'symmetric')';
%             ecg = ecg_chunk;
            akf = xcorr(ecg, ecg);
            
            if size(obj.histogram,2) < obj.histogram_length
               obj.histogram = [obj.histogram akf'];
               return;
            end
            
            % Generate ringbuffer for the histogram
            obj.histogram = [obj.histogram(:,2:end) akf'];
            
            [values, indeces] = obj.process_histogram(obj.histogram);
            
            dat = [values(1) downsample(values, 10, 4)];
            idx = [indeces(1) downsample(indeces, 10, 4)];
            
            input_vector = [dat idx]';
        end
        
    end
    
    
    
    methods (Access = protected)
        function [values, indeces] = process_histogram(obj, histogram)
            hist_half_idx = size(histogram,1) / 2;
            tmp_hist = histogram(hist_half_idx + 39:hist_half_idx + 142,:);
            [val, idx] = max(tmp_hist);
            
            if obj.show_images == true
                figure(obj.figure_handle); hold on;
                subplot(2,2,3); imagesc(histogram); title('Histogram'); %ylim([-hist_half_idx hist_half_idx]);
                subplot(2,2,4); imagesc(tmp_hist); hold on; scatter(1:length(idx),idx, 'r'); title('Histogram window');
                
                subplot(2,2,2); plot(1:length(idx), idx); title('Indeces'); set(gca, 'YDir', 'Reverse');
                hdl_values = subplot(2,2,1); cla(hdl_values); plot(1:length(val), val); title('Values');set(gca, 'YDir', 'Reverse');          
                drawnow;
            end
            

            %%%%%%%%%%%%%%%%%%%%%%%
            % Filter indeces here %
            %%%%%%%%%%%%%%%%%%%%%%%

%             subplot(2,1,1); plot(idx); subplot(2,1,2); plot(val);            
%             filtered_index = int64(filtfilt(obj.filter_coeff, [1], idx));
%             filtered_max = val(filtered_index, 1:size(val,2));
%             subplot(2,1,1); plot(filtered_index); subplot(2,1,2); plot(filtered_max); 
            

            values = val;
            indeces = idx;
        end
        
                
        function coeff = get_filter_coeff(obj)
            Fs    = 20; %8 Hz     % Sampling Frequency

            N     = 10;     % Order
            Fpass = 5;      % Passband Frequency
            Fstop = 10;     % Stopband Frequency
            Wpass = 10;     % Passband Weight
            Wstop = 10;     % Stopband Weight
            dens  = 20;     % Density Factor

            coeff  = firpm(N, [0 Fpass Fstop Fs/2]/(Fs/2), [1 1 0 0], [Wpass Wstop], {dens});
            Hd = dfilt.dffir(coeff);
        end
    end
end

