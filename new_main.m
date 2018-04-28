clc;
clear;
figure(1);
%root_path = 'C:\Users\Edwar\Desktop\3.Semester\SIP2\Datenbank\best_events\data';
root_path = 'data';

[no_event, ap_event] = get_ecg(root_path);

akf = [];

for event_idx = 1:length(ap_event(:,1))


    ecg = ap_event(event_idx,:);
    akf = [akf calculate_akf(ecg)];
    
%     subplot(2,1,1); plot(ecg); hold on; 
%     subplot(2,1,2); plot(akf); hold on;
end

imagesc(akf);
% imshow(akf);
% 
% dataDir = dir(rootPath);%%List folder contents
% dataDirVect = [dataDir(:).isdir]; %# returns logical vector
% patientFolders = {dataDir(dataDirVect).name}';
% patientFolders(ismember(patientFolders,{'.','..'})) = [];%%Delet the empty felds
% 
% global event;
% event = struct('eventType', '', 'ecg', [], 'path', '');
% events = {};
% 
% for patIdx = 1:length(patientFolders)
%     patientSubFolders = dir(strcat(rootPath, '\' ,patientFolders{patIdx}));%to see the contents of the PatientFolder
%     subidx = [patientSubFolders(:).isdir];% returns logical vector
%     patFolderNames = {patientSubFolders(subidx).name}';
%     patFolderPath = {patientSubFolders(subidx).folder}';
%     patFolderNames(ismember(patFolderNames,{'.','..'})) = [];
%     
%     for sub = 1:length(patFolderNames)
%        eventFolderName = patFolderNames{sub};
%        fullPath = strcat(patFolderPath{1},'\',eventFolderName,'\');%Concatenate strings horizontally
%        events{end+1} = readEvents(eventFolderName, fullPath); 
%     end
% end
% 
% function event = readEvents(path, fullpath)
%     
%     if (nargin ~= 1) %Number of function input arguments
%         event.path = fullpath;
%     end
%     if (strcmp(path,'NO_EVENT'))%Compare strings
%         event.eventType = 'NO';
%     end
%     if (strcmp(path,'Obstructive Apnea'))
%         event.eventType = 'APNAE';
%     end
%     
%     dataFiles = dir(strcat(fullpath, '*.mat'));
%     
%     for fileIdx = 1:length(dataFiles)
%         singleData = load(strcat(dataFiles(fileIdx).folder, '\', dataFiles(fileIdx).name));
%         calculate_akf(singleData.data.ecg);
%     end
%     
% end   
%     