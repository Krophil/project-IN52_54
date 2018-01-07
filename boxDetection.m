function [ ] = boxDetection()
    im = imread('mr_jack.jpg');
    im = rgb2hsv(im);
    
    % Élément structurant de l'érosion
    SE = [0 1 0; 1 1 1 ; 0 1 0];
    %test = img(:,:,1);
    
    colTable = im(size(im,1)-20:size(im,1), 1:size(im,2), :);
    subplot(1,3,1),imshow(colTable);
    minCol = min(min(colTable));
    minCol = [minCol(:,:,1); minCol(:,:,2); minCol(:,:,3)];
    maxCol = max(max(colTable));
    maxCol = [maxCol(:,:,1);maxCol(:,:,2); maxCol(:,:,3)];
    
    tmp = im(:,:,1)>minCol(1) & im(:,:,2)>minCol(2) & im(:,:,3)>minCol(3) ...
        & im(:,:,1)<maxCol(1) & im(:,:,2)<maxCol(2) & im(:,:,3)<maxCol(3);
    imshow(tmp);
    figure
    im(tmp) = 0;
    subplot(1,3,2),imshow(im);
    test = im(:,:,1);
    
    % On sauvegarde l'image avant modification
    aTraiter = im2bw(im);
    
    % On enlève le bruit
    test = uint8(medfilt2(aTraiter));
    test = im2bw(test, 0);
    test = imfill(test, 'holes');
    test = imerode(imerode(imerode(imerode(imerode(imerode(imerode(test, SE), SE), SE), SE), SE), SE), SE);
    subplot(1,3,3),imshow(test);
end

