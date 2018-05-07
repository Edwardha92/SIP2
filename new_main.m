clc;
clear;
% figure(1);
%root_path = 'C:\Users\Edwar\Desktop\3.Semester\SIP2\Datenbank\best_events\data';
% root_path = 'data';
root_path = 'C:\Users\bloodsurfer\Documents\1dev\SIP2\bestData\data';

[no_event, ap_event] = get_ecg(root_path);
akf = [];
ap = [];
no = [];

len = min(length(ap_event(:,1)), length(no_event(:,1)));
ap_event = ap_event(1:len,:);
no_event = no_event(1:len,:);


for event_idx = 1:length(ap_event(:,1))
    ap_ecg = ap_event(event_idx,:);    
    ap_akf = calculate_akf(ap_ecg);    
    ap = [ap ap_akf];
end

for event_idx = 1:length(no_event(:,1))
    no_ecg = no_event(event_idx,:);
    no_akf = calculate_akf(no_ecg);
    no = [no no_akf];
end

figure(1);imagesc(ap);
figure(2);imagesc(no);

% imshow(akf);

[ap_data, ap_idx] = get_window(ap);
ap_target = ones(size(ap_data,1),1)';
training_data_apnoe = [ap_data'; ap_idx'];

[no_data, no_idx] = get_window(no);
no_target = zeros(size(no_data,1),1)';
training_data_no_event = [no_data'; no_idx'];

sorted_data = [training_data_apnoe training_data_no_event];
sorted_target = [ap_target no_target];

shuffle_idx = randperm(size(sorted_data,2));

training_data = sorted_data(:,shuffle_idx);
target = sorted_target(:, shuffle_idx);
ann(training_data, target);


