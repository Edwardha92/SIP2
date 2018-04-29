function akf_fenster=fenster(akf_list )
    size_akf=size(akf_list);
    
    for i =1:121:size_akf(2) - 121
        
        akf_fenster=akf_list(size_akf(1)/2 + 39:size_akf(1) / 2 + 142, i:i + 120);
        %imshow(akf_fenster);hold on;
        imagesc(akf_fenster);
    end
end 