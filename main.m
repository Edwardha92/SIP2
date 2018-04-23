clc;
clear;

rootPath = 'C:\Users\Edwar\Desktop\3.Semester\SIP2\Datenbank\best_events\data';
%rootPath = 'bestData/data';


dataDir = dir(rootPath);%%List folder contents
dataDirVect = [dataDir(:).isdir]; %# returns logical vector
patientFolders = {dataDir(dataDirVect).name}';
patientFolders(ismember(patientFolders,{'.','..'})) = [];%%Delet the empty felds

global event;
event = struct('eventType', '', 'ecg', [], 'path', '');
events = {};

for patIdx = 1:length(patientFolders)
    patientSubFolders = dir(strcat(rootPath, '\' ,patientFolders{patIdx}));%to see the contents of the PatientFolder
    subidx = [patientSubFolders(:).isdir];% returns logical vector
    patFolderNames = {patientSubFolders(subidx).name}';
    patFolderPath = {patientSubFolders(subidx).folder}';
    patFolderNames(ismember(patFolderNames,{'.','..'})) = [];
    
    for sub = 1:length(patFolderNames)
       eventFolderName = patFolderNames{sub};
       fullPath = strcat(patFolderPath{1},'\',eventFolderName,'\');%Concatenate strings horizontally
       events{end+1} = readEvents(eventFolderName, fullPath); 
    end
end

function event = readEvents(path, fullpath)
    
    if (nargin ~= 1) %Number of function input arguments
        event.path = fullpath;
    end
    if (strcmp(path,'NO_EVENT'))%Compare strings
        event.eventType = 'NO';
    end
    if (strcmp(path,'Obstructive Apnea'))
        event.eventType = 'APNAE';
    end
    
    dataFiles = dir(strcat(fullpath, '*.mat'));
    %event.ecg = {};
     
    new_akf=[];
    for fileIdx = 1:length(dataFiles)
        singleData = load(strcat(dataFiles(fileIdx).folder, '\', dataFiles(fileIdx).name));
        x=size(singleData.data.ecg);
        y=fix(x/140)*140;
        
       for ecg_index=1:140:y(2)
         ecg_fenster=singleData.data.ecg(ecg_index:ecg_index+140);
         akf_fenster=xcorr(ecg_fenster,ecg_fenster);
         new_akf = [new_akf akf_fenster'];
         
       end
%        plot(singleData.data.ecg);
%        plot(new_akf);
        if strcmp(event.eventType,'APNAE')
%            imshow(new_akf);
        end
    end
%    plot(new_akf);
%    imshow(new_akf);
    size_akf=size(new_akf);
    ii=fix(size_akf(2)/121)*121;
    for i =1:121:ii
        sliding_window=new_akf(140:281,i:i+120);
        imshow(sliding_window);
        imagesc(sliding_window);
    end
end   
    