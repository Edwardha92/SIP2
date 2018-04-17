clc;
clear;

rootPath = 'C:\Users\Edwar\Desktop\3.Semester\SIP2\Datenbank\best_events\data';

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
       events{end+1} = readEvents(eventFolderName, fullPath); %#ok<SAGROW>
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
        %plot(singleData.data.ecg);
        x=size(singleData.data.ecg);
        y=fix(x/500)*500;
        
       for ecg_index=1:500:y(2)


         ecg_fenster=singleData.data.ecg(ecg_index:ecg_index+500);
         akf_fenster=xcorr(ecg_fenster,ecg_fenster);
         %plot(akf_fenster);
         new_akf = [new_akf;akf_fenster]; %#ok<AGROW>
 
       end
      %%new_akf ist cell array
      %celldisp(new_akf);
      %cellplot(new_akf);
      %new_akf=cell2mat(new_akf);
      %plot(new_akf);
      imshow(new_akf');
    end
    
    
   end 