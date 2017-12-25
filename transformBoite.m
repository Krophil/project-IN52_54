function [ ] = transformBoite( original, points, photo )
    %J = original;
    %I = imread(photo);
    J = imread(original);
    I = photo;
    
    % Points principaux vers lesquels on doit se rapprocher
    fixedPoints = [1 size(J, 1); size(J, 2) 1 ; size(J,2) size(J,1) ; 1 1];
    % Points principaux à bouger
    movingPoints = points;
    
    % Affichage pour vérifier les points fixes
    figure
    subplot(1,5,1), imshow(J);
    hold on
    for k = 1:length(fixedPoints)
       plot(fixedPoints(:,1),fixedPoints(:,2),'or');
    end
    hold off

    % Affichage pour vérifier les points qui bougent
    subplot(1,5,2), imshow(I);
    hold on
    for k = 1:length(movingPoints)
       plot(movingPoints(:,1),movingPoints(:,2),'og');
    end

    % Using "fitgeotrans"
    t = fitgeotrans(movingPoints,fixedPoints,'nonreflectivesimilarity');

    % Recover angle and scale by checking how a unit vector 
    % parallel to the x-axis is rotated and stretched. 
    u = [0 1]; 
    v = [0 0];

    % Create a 'projective2d' object and use "transformPointsForward"
    projectiveObj = projective2d(t.T);

    % [x, y] = transformPointsForward(projectiveObj, u, v);
    % 
    % dx = x(2) - x(1);
    % dy = y(2) - y(1);
    % angle = (180/pi) * atan2(dy, dx);
    % scale = 1 / sqrt(dx^2 + dy^2);



    [K, RB] = imwarp(I, projectiveObj); % ,'OutputView',imref2d(size(J))

    subplot(1,5,3), imshow(K);
    ktmp = im2bw(K);
    % Rognage de l'image autour de la boîte de jeu
    sumPixV = sum(ktmp>0,2);
    testF_V = find(sumPixV > 0, 1, 'first')-20;
    if(testF_V < 1)
        testF_V = 1;
    end
    testL_V = find(sumPixV > 0, 1, 'last')+20;
    if(testL_V > size(K, 2))
        testL_V = size(K,2);
    end

    sumPixH = sum(ktmp>0,1);
    testF_H = find(sumPixH > 0, 1, 'first')-20;
    if(testF_H < 1)
        testF_H = 1;
    end
    testL_H = find(sumPixH > 0, 1, 'last')+20;
    if(testL_H > size(K, 2))
        testL_H = size(K, 2);
    end
    K = K(testF_V:testL_V, testF_H:testL_H, :);
    ktmp = ktmp(testF_V:testL_V, testF_H:testL_H, :);
    stats = [regionprops(ktmp); regionprops(not(ktmp))];

    % on affiche l'image obtenue
    subplot(1,5,4), imshow(ktmp); 
    hold on;

    for i = 1:numel(stats)
        rectangle('Position', stats(i).BoundingBox, ...
        'Linewidth', 3, 'EdgeColor', 'r', 'LineStyle', '--');
    end


    %subplot(1,5,4), imshow(K);
    hold on
    for k = 1:length(movingPoints)
       plot(movingPoints(:,1),movingPoints(:,2),'og');
    end
    
    % On retente une dernière fois de bouger les points mais ça marche pas mieux...
    [xdata,ydata]=transformPointsForward(t,movingPoints(:,1),movingPoints(:,2));

    [newX,newY]=worldToIntrinsic(RB,xdata,ydata);

    newPoints = [newX,newY];

    t = fitgeotrans(newPoints,fixedPoints,'projective');

    newProjectiveObj = projective2d(t.T);

    K = imwarp(K, newProjectiveObj);
    
    subplot(1,5,5), imshow(K);

    
end

