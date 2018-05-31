root_path = 'D:\1dev\SIP2\final\data';

[get_flag, apnoe, noevent] = test_ecg(root_path);

if get_flag
   sprintf('ECG loading successfull') 
end
% 
% [input_flag, input_vector] = test_input_vector();
% 
% if input_flag
%    sprintf('Generating input vector successfull') 
% end

% 
% function [flag, input_vector] = test_input_vector()
%     akf_list = zeros(1023,121);
%     akf_length = 511;
%     akf_step = 50;
% 
%     akf_list(520,:) = 1;
%     
%     apnoe = zeros(1,512);
%     
%     apnoe(1,512 - 20) = 1;
%     
%     ap_wind = apnoe .* blackman(size(apnoe,2), 'symmetric')';
%     cor = xcorr(ap_wind, ap_wind);
%     
%     for i = 1:akf_step:size(apnoe,2)-akf_length
%         [input_vector, akf_list] = generate_input_vector(apnoe(i:i+akf_length), akf_list);
%     end
% end

function [flag, apnoe, noevent] = test_ecg(root_path)
    no_path = '\dat\NO_EVENT\';
    ap_path = '\dat\Obstructive Apnea\';

    data = {};
    data.ecg = generate_ecg();

    save(strcat(root_path, ap_path, 'ap.mat'), 'data'); 
    save(strcat(root_path, no_path, 'no.mat'), 'data');

    [apnoe, noevent] = get_ecg(root_path);

    ap_flag = false;
    no_flag = false;
    
    if apnoe == data.ecg
        sprintf('Apnoe data is correctly loaded');
        ap_flag = true;
    end

    if noevent == data.ecg
        sprintf('NoEvent data is correctly loaded');
        no_flag = true;
    end
    
    flag = ap_flag == true && no_flag == true;
end

function [ecg] = generate_ecg()
    length = 6513;
    ecg = rand(length,1)';
end