    
A = imread('/Users/Alex/Desktop/01/Obstructive Apnea/event_f01_t03626_Obstructive Apnea_begin_pic.png');
% B = imread('/Users/Alex/Desktop/01/Obstructive Apnea/event_f01_t07420_Obstructive Apnea_begin_pic.png');
% C = imread('/Users/Alex/Desktop/01/NO_EVENT/event_f01_t00996_NO_EVENT_begin_pic.png');
% D = imread('/Users/Alex/Desktop/01/NO_EVENT/event_f01_t01300_NO_EVENT_begin_pic.png');
% A=im2double(A);
% B=im2double(B);
% C=im2double(C);
% D=im2double(D);
% figure(1); imshow(A); hold on;
% [Wert,Index]=max(A);
% [Wert_B,Index_B]=max(B);
% [Wert_C,Index_C]=max(C);
% [Wert_D,Index_D]=max(D);
% 
% Wert_13=downsample(Wert,10);%,4);
% Index_13=downsample(Index,10);%,4);
% 
% Wert_13_B=downsample(Wert_B,10);%,4);
% Index_13_B=downsample(Index_B,10);%,4);
% 
% Wert_13_C=downsample(Wert_C,10);%,4);
% Index_13_C=downsample(Index_C,10);%,4);
% 
% Wert_13_D=downsample(Wert_D,10);%,4);
% Index_13_D=downsample(Index_D,10);%,4);
% %subplot(3,2,1);
% Data_ABCD= [Wert_13 Index_13; Wert_13_B Index_13_B; Wert_13_C Index_13_C; Wert_13_D Index_13_D];
% Data_ABCD = Data_ABCD';
% 
% T= [1.0 1.0 0.0 0.0];
%plot(Index); hold on;
set(gca, 'YDir', 'Reverse');
% subplot(3,2,2);
scatter([1:121/13:121],Index_13);
set(gca, 'YDir', 'Reverse');
%set(gca, 'YDir', 'Reverse');


% scatter(Index_13, Wert_13, 'r');

Data_all = [Wert Index];
Data = [Wert_13 Index_13];

end
% f1 = figure;
% figure(f1);
%plot(Wert_13);

f2 = figure;
figure(f2);
plot(Index_13); 
hold on; 
plot(Wert_13);
T_1 = 1;

T = [1];%,1,1,1,1,1,1,1,1,1,1,1,1;1,1,1,1,1,1,1,1,1,1,1,1,1];

Data = Data';

for i=1:5
   Data = [Data Data];
end

T_rand = randi([0,1], 1,32);

nnstart;

