clear all;

root_path ='C:\Users\Edwar\Desktop\3.Semester\SIP2\Datenbank\best_events';
root_path = 'C:\Users\bloodsurfer\Documents\1dev\SIP2\bestData\data';
[no_event, ap_event] = get_ecg(root_path);
ecg_step_size = 50;
ecg_length = 511;

proc = ECGProcessing;
clas = NeuralNetwork;
proc.show_images = 0;

input_vector = [];

min_length = min(size(no_event), size(ap_event));

for j = 1:size(ap_event,1)
    single_data = ap_event(j,:);
    
    for i = 1 : ecg_step_size : size(single_data,2) - ecg_length % mod(size(single_data,2), ecg_step_size)
        data_chunk = single_data(i: i + ecg_length);
        dat = proc.generate_input_vector(data_chunk);
        if size(dat) ~= 0
           clas.classify(dat) 
        end
        input_vector = [input_vector dat];
    %     sprintf('Iteration: %d of 150', i)
    %     imagesc(proc.histogram);
    end
end
plot(input_vector);


