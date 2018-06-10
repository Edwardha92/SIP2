%
% Review: Stas 10.06.2018

sprintf('Start testing...');
flag = test_ecg();
flag = flag & test_calculate_akf()
flag = flag & test_crop_list();

if flag
   sprintf('All tests completed successfully.') 
end


function flag = test_calculate_akf()
    input = [1 0 0  1 0 0 1 0 0 1 0 0 1];
    flag = false;
    output = calculate_akf(input);

    if size(output(output > 0.001),2) == 5
        sprintf('akf calculating passed.')
        flag = true;
    else
        sprintf('akf calculating FAILED.')
    end

end


function flag = test_crop_list()
    flag = true;    
    xDim = 121;
    yDim = 1023;

    half = floor(yDim / 2);
    offset = 39;
    length = 142;

    test_akf_list = zeros(yDim, xDim);

    test_akf_list(half + offset:half+ length,:) = 1;
    cropped_reference = test_akf_list(half + offset:half+ length,:);

    cropped_list = crop_list(test_akf_list);

    if isequal(cropped_reference, cropped_list)
       sprintf('cropping passed.')
       flag = true;
    else
        sprintf('cropping failed.')
    end
end


function [flag, apnoe, noevent] = test_ecg()
    root_path = 'testData';
    no_path = '\dat\NO_EVENT\';
    ap_path = '\dat\Obstructive Apnea\';

    if ~exist(strcat(root_path, no_path),'dir')
       mkdir(strcat(root_path, no_path)); 
    end
    
    if ~exist(strcat(root_path, ap_path),'dir')
       mkdir(strcat(root_path, ap_path)); 
    end
    
    data = {};
    data.ecg = generate_ecg();

    save(strcat(root_path, ap_path, 'ap.mat'), 'data'); 
    save(strcat(root_path, no_path, 'no.mat'), 'data');

    [apnoe, noevent] = get_ecg(root_path);

    ap_flag = false;
    no_flag = false;
    
    if apnoe == data.ecg
        sprintf('Apnoe data is correctly loaded.')
        ap_flag = true;
    else
        sprintf('Apnoe data NOT loaded correctly.')
    end

    if noevent == data.ecg
        sprintf('NoEvent data is loaded correctly.')
        no_flag = true;
    else
        sprintf('NoEvent data NOT loaded correctly.')
    end
    
    flag = ap_flag == true && no_flag == true;
end


function [ecg] = generate_ecg()
    length = 6513;
    ecg = rand(length,1)';
end