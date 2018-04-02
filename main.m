clc;
clear all;

dataDir = dir('data');
dataDirVect = [dataDir(:).isdir]; %# returns logical vector
patientFolders = {dataDir(dataDirVect).name}';
patientFolders(ismember(patientFolders,{'.','..'})) = [];

global event;
event = struct('eventType', '', 'ecg', [], 'path', '');
events = {};

for patIdx = 1:length(patientFolders)
    patientSubFolders = dir(strcat('data/', patientFolders{patIdx}));
    subidx = [patientSubFolders(:).isdir];
    patFolderNames = {patientSubFolders(subidx).name}';
    patFolderPath = {patientSubFolders(subidx).folder}';
    patFolderNames(ismember(patFolderNames,{'.','..'})) = [];
    
    for sub = 1:length(patFolderNames)
       eventFolderName = patFolderNames{sub};
       fullPath = strcat(patFolderPath{1},'\',eventFolderName,'\');
       events{end+1} = readEvents(eventFolderName, fullPath);
    end
end

function event = readEvents(path, fullpath)
    
    if (nargin ~= 1)
        event.path = fullpath;
    end
    if (strcmp(path,'NO_EVENT'))
        event.eventType = 'NO';
    end
    if (strcmp(path,'Obstructive Apnea'))
        event.eventType = 'APNAE';
    end
    
    dataFiles = dir(strcat(fullpath, '*.mat'));
    event.ecg = {};
    for fileIdx = 1:length(dataFiles)
        singleData = load(strcat(dataFiles(fileIdx).folder, '\', dataFiles(fileIdx).name));
        event.ecg{end+1} = singleData.data.akf_t
    end
    
end

