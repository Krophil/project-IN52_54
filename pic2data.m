function [result] = pic2data(pic)
    % On r�cup�re uniquement la teinte de l'image    
    hslPic = rgb2hsv(pic); 
    hPic = hslPic(:,:,1);
    
    % Passage en histogramme
    
    [counts, x] = imhist(hPic);
    
    % Passer de 255 valeurs � 51 (r�union par pack de 5)
    
    result = zeros(50,1);
    nbPixel = 0;
    
    for i=10:5:255
       result(i/5) = counts(i) + counts(i-1) + counts(i-2) + counts(i-3) + counts(i-4);
       nbPixel = nbPixel + result(i/5);
    end
    
    result = result / nbPixel;
end

