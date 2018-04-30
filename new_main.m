clc;
clear;
figure(1);
%root_path = 'C:\Users\Edwar\Desktop\3.Semester\SIP2\Datenbank\best_events\data';
% root_path = 'data';
root_path = 'C:\Users\bloodsurfer\Documents\1dev\SIP2\bestData';

[no_event, ap_event] = get_ecg(root_path);

akf = [];

for event_idx = 1:10% length(ap_event(:,1))


    ap_ecg = ap_event(event_idx,:);
    no_ecg = no_event(event_idx,:);
    jnk = calculate_akf(ap_ecg);
    
    akf = [akf jnk];


%     subplot(2,1,1); plot(ecg); hold on; 
%     subplot(2,1,2); plot(akf); hold on;
end

% imshow(akf);

akf_window = get_window(akf);
process_akf(akf_window);

