function akf_fenster=fenster(new_akf)
    size_akf=size(new_akf);
    ii=fix(size_akf(1)/121)*121;
    for i =1:121:ii
        sliding_window=new_akf(ii/2+39:ii/2+142,i:i+120);
        imshow(sliding_window);
        imagesc(sliding_window);
        
    end
end 