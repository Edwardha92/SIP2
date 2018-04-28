function akf_fenster=fenster(akf_list)
    size_akf=size(akf_list);
    ii=fix(size_akf(1)/121)*121;
    for i =1:121:ii
        akf_fenster=new_akf(ii/2+39:ii/2+142,i:i+120);
        imshow(sliding_window);
        imagesc(sliding_window);
        
    end
end 