clear all;

root_path = 'D:/1dev/SIP2/dat1';
[no_event, ap_event] = get_ecg(root_path);
ecg_step_size = 50;
ecg_length = 511;

proc = ECGProcessing;
proc.show_images = 1;

input_vector = [];

for j = 1:size(ap_event,1)
    single_data = ap_event(j,:);
    
    for i = 1 : ecg_step_size : size(single_data,2) - ecg_length % mod(size(single_data,2), ecg_step_size)
        data_chunk = single_data(i: i + ecg_length);
        dat = proc.generate_input_vector(data_chunk);
        input_vector = [input_vector dat];
    %     sprintf('Iteration: %d of 150', i)
    %     imagesc(proc.histogram);
    end
end
plot(input_vector);


% clc;
% clear;
% % figure(1);
% %root_path = 'C:\Users\Edwar\Desktop\3.Semester\SIP2\Datenbank\best_events\data';
% % root_path = 'data';
% root_path = 'D:/1dev/SIP2/data';
% 
% [no_event, ap_event] = get_ecg(root_path);
% 
% ap = [];
% no = [];
% 
% len = min(length(ap_event(:,1)), length(no_event(:,1)));
% ap_event = ap_event(1:len,:);
% no_event = no_event(1:len,:);
% 
% 
% for event_idx = 1:length(ap_event(:,1))
%     ap_ecg = ap_event(event_idx,:);
%     ap_akf = calculate_akf(ap_ecg);
%     ap = [ap ap_akf];
%     if mod(event_idx, 100) == 0
%        sprintf('Apnoe event processed: %f', (100 / len) * event_idx)
%     end
% end
% 
% for event_idx = 1:length(no_event(:,1))
%     no_ecg = no_event(event_idx,:);
%     no_akf = calculate_akf(no_ecg);
%     no = [no no_akf];
%     if mod(event_idx, 100) == 0
%        sprintf('No event processed: %f', (100 / len) * event_idx)
%     end
% end
% 
% figure(1);imagesc(ap);
% figure(2);imagesc(no);
% 
% % imshow(akf);
% 
% [ap_data, ap_idx] = get_window(ap);
% ap_target = ones(size(ap_data,1),1)';
% training_data_apnoe = [ap_data'; ap_idx'];
% 
% [no_data, no_idx] = get_window(no);
% no_target = zeros(size(no_data,1),1)';
% training_data_no_event = [no_data'; no_idx'];
% 
% sorted_data = [training_data_apnoe training_data_no_event];
% sorted_target = [ap_target no_target];
% 
% shuffle_idx = randperm(size(sorted_data,2));
% 
% training_data = sorted_data(:,shuffle_idx);
% target = sorted_target(:,shuffle_idx);
% 
% training_data = training_data/norm(training_data);
% 
% nnstart;
% 
% % ann(training_data, target);
% 
% %process_akf(akf_window);
% 
