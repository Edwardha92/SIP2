A = imread('/Users/Alex/Desktop/01/Obstructive Apnea/event_f01_t03626_Obstructive Apnea_begin_pic.png');

[Wert,Index]=max(A);

Wert_13=downsample(Wert,9,4);
Index_13=downsample(Index,9,4);

Data_all = [Wert;Index];
Data = [Wert_13; Index_13];

% f1 = figure;
% figure(f1);
%plot(Wert_13);

f2 = figure;
figure(f2);
plot(Index_13); 
hold on; 
plot(Wert_13);

