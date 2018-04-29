function [no_events_ecg, ap_events_ecg] = get_ecg(root_path)

    data_path = dir(root_path);
    data_content = [data_path(:).isdir];
    folders = {data_path(data_content).name}';
    folders(ismember(folders,{'.', '..'})) = [];
    
    no_events_ecg = [];
    ap_events_ecg = [];
    
    
    for folder_idx = 1:3% length(folders)
       tmp_path = strcat(root_path, '\', folders{folder_idx});
       events_path = dir(tmp_path);
       event_content = [events_path(:).isdir];
       
       single_event_path = {events_path(event_content).name};
       single_event_path(ismember(single_event_path,{'.', '..'})) = [];
       events_full_path = strcat(tmp_path, '\', single_event_path);
       
       sprintf('file %d of %d (%s)', folder_idx, length(folders), events_full_path{1})
       
       
       for event_type_idx = 1:length(events_full_path)
           event_files = dir(strcat(events_full_path{event_type_idx}, '\*.mat'));
           tmp_events = [];
           
           for file_idx = 1:length(event_files)
               file = load(strcat(event_files(file_idx).folder,'\', event_files(file_idx).name));
               data = file.data.ecg;
               tmp_events = [tmp_events; data(1:6513)]; %#ok<AGROW>
           end
           
           if strfind(events_full_path{event_type_idx}, 'NO_EVENT')
               no_events_ecg = [no_events_ecg; tmp_events]; %#ok<AGROW>
           else
               ap_events_ecg = [ap_events_ecg; tmp_events]; %#ok<AGROW>
           end
       end
    end
    
    
end