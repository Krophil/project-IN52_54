function [ maxCorrelation ] = ressamblanceCourbes( courbe1, courbe2 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[nbValeurs, ~] = size(courbe1);
decalageMax = floor(nbValeurs*0.05);
maxCorrelation = 0;

for i=-decalageMax:decalageMax
    ddc =  corrcoef(courbe1(decalageMax+1:nbValeurs-decalageMax),...
        courbe2(decalageMax+i+1:nbValeurs-decalageMax+i));
%     figure
%     subplot(1,2,1), plot(courbe1(decalageMax:nbValeurs-decalageMax));
%     subplot(1,2,2), plot(courbe2(decalageMax-i:nbValeurs-decalageMax-i));
    ddc = ddc(2);
    if(maxCorrelation<ddc)
        maxCorrelation=ddc;
    end
end

end

