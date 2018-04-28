<<<<<<< HEAD
function akf_fenster=fenster(akf_list )
    size_akf=size(akf_list);
    ii=fix(size_akf(1)/121)*121;
    for i =1:121:ii
        akf_fenster=akf_list(ii/2+39:ii/2+142,i:i+120);
        imshow(akf_fenster);hold on;
        imagesc(akf_fenster);
        %akf_fenster=upsample(akf_fenster,13);
        %plot (akf_fenster);
        %imshow(akf_fenster);
=======
function akf_fenster=fenster(akf_list)
    size_akf=size(akf_list);
    ii=fix(size_akf(1)/121)*121;
    for i =1:121:ii
        akf_fenster=new_akf(ii/2+39:ii/2+142,i:i+120);
        imshow(sliding_window);
        imagesc(sliding_window);
        
>>>>>>> 1e476c1a0b9a600705c05e8ccb59021b82b4ddb4
    end
end 