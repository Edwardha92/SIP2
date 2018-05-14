classdef ECGProcessing < handle
    %ECGPROCESSING This class creates and administrates the histogram data.
    %
    % Based on ecg data from the time domain of 512 values, ECGPROCESSING 
    % generates a histogram of the length of HISTOGRAM_LENGT (default =121)
    % values. This results in a histogram with the dimension of 1023x121.
    %
    % INPUT_VECTOR = GENERATE_INPUT_VECTOR(ECG_CHUNK) this is the main
    % entry point to this class. It will fill a ringbuffer for the
    % histogram data and extract a feature vector of 26 elements. If the 
    % ringbuffer is NOT FILLED, IT WILL RETURN [].
    %
    % The histogram is generated by appending the output for the
    % autocorrelated ecg_data. Before calculating the akf thoug, a hamming
    % window is applied though.
    %
    % The feature extraction is done by cutting a window of 104x121 from
    % the bottom half (plus offset of 39) of the histogram. Max intensities
    % and the corresponding indeces form the raw data. Before downsampling
    % both vectors a lowpass filter is applied to smooth the index outlier
    % and a new max intensities vector is generated.
    %
    % Now both the intensity and index vectors are downsampled by the
    % factor 10 resulting in each 1x13 value vector. The return value is
    % composed by concating both intensity and index vectors resulting in a
    % 1x26 feature vector.
    % 
    % The SHOW_IMAGE property enables a live display for
    % max_intensities, max_values, the histogram and the window with the
    % processed indeces.
    
    properties (Constant)
        histogram_length = 121;
        akf_length = 512;
        figure_handle = 42;
        downsample_rate = 10;
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
            warning ('off','all');
            input_vector = [];
            if size(ecg_chunk,2) ~= obj.akf_length
                info('expected ecg chunk length is 512. The provided data has %d values instead.', size(ecg_chunk,2));
                return;
            end
            
            
            
            ecg = ecg_chunk .* blackman(size(ecg_chunk,2), 'symmetric')';
%             ecg = ecg_chunk;
            akf = xcorr(ecg, ecg);
            
            if size(obj.histogram,2) < obj.histogram_length
               obj.histogram = [obj.histogram akf'];
               return;
            end
            
            % Generate ringbuffer for the histogram
            obj.histogram = [obj.histogram(:,2:end) akf'];
            
            [values, indeces] = obj.process_histogram(obj.histogram);
            
            dat = [downsample(values, obj.downsample_rate)];
            idx = [downsample(indeces, obj.downsample_rate)];
            
            input_vector = [dat idx]';
            warning ('on','all');
        end
        
        function clear_all(obj)
            obj.histogram = []; 
        end
        
    end
    
    
    
    methods (Access = protected)
        
        function [values, indeces] = process_histogram(obj, histogram)
            % PROCESS_HISTOGRAM
            %   [VALUES, INDECES] = PROCESS_HISTOGRAM(HISTOGRAM)
            
            
            
            hist_half_idx = size(histogram,1) / 2;
            tmp_hist = histogram(hist_half_idx + 39:hist_half_idx + 142,:);
            [val, idx] = max(tmp_hist);

%             subplot(2,1,1); plot(idx); subplot(2,1,2); plot(val);            
            filtered_index = int64(filtfilt(obj.filter_coeff, [1], idx));
            filtered_max = val(:,filtered_index);
%             subplot(2,1,1); plot(filtered_index); subplot(2,1,2); plot(filtered_max); 
            

            values = val;
            indeces = idx;
            
            val = filtered_max;
            idx = filtered_index;
            
            if obj.show_images == true
                figure(obj.figure_handle); hold on;
                subplot(2,2,3); imagesc(histogram); title('Histogram'); %ylim([-hist_half_idx hist_half_idx]);
                subplot(2,2,4); imagesc(tmp_hist); title('Histogram window'); hold on; scatter(1:length(idx),idx, 'r'); 

                subplot(2,2,2); plot(1:length(idx), idx); title('Indeces'); set(gca, 'YDir', 'Reverse');
                hdl_values = subplot(2,2,1); cla(hdl_values); plot(1:length(val), val); title('Values'); 
                set(gca, 'YDir', 'Reverse');
                drawnow;
            end
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

