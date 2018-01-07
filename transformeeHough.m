function [ ] = transformeeHough( )
    im = imread('whitehall.jpg');
    img = rgb2hsv(im);
    
    % Élément structurant de l'érosion
    SE = [0 1 0; 1 1 1 ; 0 1 0];
    test = img(:,:,1);
    
    % On sauvegarde l'image avant modification
    aTraiter = im2bw(test);
    
    % On enlève le bruit
    test = uint8(medfilt2(test));
    test = im2bw(test, 0);
    test = imfill(test, 'holes');
    test = imerode(imerode(imerode(imerode(imerode(imerode(imerode(test, SE), SE), SE), SE), SE), SE), SE);

    % Rognage de l'image autour de la boîte de jeu
    sumPixV = sum(test==1,2);
    testF_V = find(sumPixV > 0, 1, 'first')-200;
    if(testF_V < 1)
        testF_V = 1;
    end
    testL_V = find(sumPixV > 0, 1, 'last')+20;
    if(testL_V > size(im, 1))
        testL_V = size(im,1);
    end
    
    sumPixH = sum(test==1,1);
    testF_H = find(sumPixH > 0, 1, 'first')-50;
    if(testF_H < 1)
        testF_H = 1;
    end
    testL_H = find(sumPixH > 0, 1, 'last')+20;
    if(testL_H > size(im, 2))
        testL_H = size(im, 2);
    end
    
    im_rec = aTraiter(testF_V:testL_V, testF_H:testL_H, :);
    
    % Transformée de Hough
    BW = edge(im_rec,'canny');
    [H,T,R] = hough(BW);
    P  = houghpeaks(H,5, 'Threshold',10);
    lines = houghlines(BW,T,R,P, 'MinLength', size(im_rec,1)*0.5, 'FillGap', size(im,2)/2);
    figure
    subplot(1,2,1), imshow(im_rec);
    hold on
    for k = 1:length(lines)
       xy = [lines(k).point1; lines(k).point2];
       plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    end
    polynomes = cell(length(lines), 1);
    for k = 1:length(lines)
        polynomes{k} = polyfit([lines(k).point1(1) lines(k).point2(1)], [lines(k).point1(2) lines(k).point2(2)],1);
        
        % Affichage pour debuggage
        xy = [lines(k).point1; lines(k).point2];
        plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','red');
    end
    
    % Recherche des points d'intersection des lignes récupérées autour de
    % la boîte
    points = [];
    for idx = 1:length(polynomes)
        for jdx = 1:length(polynomes)
            if(idx ~= jdx)
                x_intersect = fzero(@(x) polyval(polynomes{jdx}-polynomes{idx},x),3);
                y_intersect = polyval(polynomes{idx},x_intersect);
                if(x_intersect > 1 && x_intersect < size(im_rec, 2) && y_intersect > 1 && y_intersect < size(im_rec, 1))
                     plot(x_intersect,y_intersect,'or');
                    points = [points ; x_intersect y_intersect];
                end
            end
        end
    end
    
    % Unicité des coordonnées
    points = uniquetol(points(:,1:2),'ByRows',true);
%     plot(points(:,1), points(:,2),'*r');
    points = floor(points);
    
    % Coordonnées dans le sens clockwise pour que le polygone soit
    % correctement formé
    x = points(:,1);
    y = points(:,2);
    cx = mean(x);
    cy = mean(y);
    a = atan2(y - cy, x - cx);
    [~, order] = sort(a);
    points = [x(order) y(order)];
    bw = poly2mask(points(:,1),points(:,2),size(im_rec,1), size(im_rec,2));
    toAnalyse = rgb2hsv(im(testF_V:testL_V, testF_H:testL_H, :));
    mask_three_chan = repmat(bw, [1, 1, 3]);
    final = toAnalyse.*mask_three_chan;
    
    
    %transformBoite('mr_jack_originalHSL.jpg', points, final);
     subplot(1,2,2), imshow(final); 
end

