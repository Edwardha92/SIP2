noEvent = dir('N:\SIP2_SS18\Software\03_event_database\best_events\data\data1\NO_EVENT');
apEvent = dir('N:\SIP2_SS18\Software\03_event_database\best_events\data\data1\Obstructive Apnea');
% dataPath = dataPath(3:end);

noEvent = noEvent(3:end);
apEvent = apEvent(3:end);

% for patient = size(dataPath)
%     
% end

eventList = struct('eventType',{1,2},'data',[[]]);

noEvLength = size(noEvent);
for i = 1:noEvLength(1)
    tmp = load(fullfile(noEvent(i).folder, noEvent(i).name));
    eventList(i).data = tmp.data.akf;
    eventList(i).eventType = 1;
end

apEvLength = size(apEvent);
for i = 1:apEvLength(1)
    tmp = load(fullfile(apEvent(i).folder, apEvent(i).name));
    eventList(i+noEvLength(1)).data = tmp.data.akf;
    eventList(i+noEvLength(1)).eventType = 2;
end

out1 = randperm(noEvLength(1) + apEvLength(1));


for i = 1:size(out1)
    jnk(i) = eventList(out1(i));    
end
