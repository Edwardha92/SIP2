clear all;

root_path ='C:\Users\Edwar\Desktop\3.Semester\SIP2\Datenbank\best_events';
% root_path = 'C:\Users\bloodsurfer\Documents\1dev\SIP2\bestData\data';
root_path = 'D:\1dev\SIP2\dat1';
[no_event, ap_event] = get_ecg(root_path);
ecg_step_size = 50;
ecg_length = 511;

proc = ECGProcessing;
proc.data_type = 1;
proc.show_images = 1;

clas = NeuralNetwork;

nn_threshold = 0;


input_vector = [];

min_length = min(size(no_event), size(ap_event));



for j = 1:size(ap_event,1)
    single_data = ap_event(j,:);
    
    for i = 1 : ecg_step_size : size(single_data,2) - ecg_length % mod(size(single_data,2), ecg_step_size)
        data_chunk = single_data(i: i + ecg_length);
        dat = proc.generate_input_vector(data_chunk);
        if size(dat) ~= 0
           if clas.classify(dat) < nn_threshold 
              proc.n_no = proc.n_no + 1;
           else
              proc.n_ap = proc.n_ap + 1;
           end
           
        end
        input_vector = [input_vector dat];
    %     sprintf('Iteration: %d of 150', i)
    %     imagesc(proc.histogram);
    end
end
plot(input_vector);


