clc;
clear;
figure(1);
%root_path = 'C:\Users\Edwar\Desktop\3.Semester\SIP2\Datenbank\best_events\data';
root_path = 'data';

[no_event, ap_event] = get_ecg(root_path);

akf = [];

for event_idx = 1:10% length(ap_event(:,1))


    ecg = ap_event(event_idx,:);
    akf = [akf calculate_akf(ecg)];


%     subplot(2,1,1); plot(ecg); hold on; 
%     subplot(2,1,2); plot(akf); hold on;
end

% imshow(akf);

akf_window = get_window(akf);
process_akf(akf_window);

