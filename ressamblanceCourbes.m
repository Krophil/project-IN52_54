function [ maxCorrelation ] = ressamblanceCourbes( courbe1, courbe2 )
%ressamblanceCourbes Calcule le coefficient de correlation de deux courbes
%en essayant de les decaler
%   coubre1, courbe2 : courbes a comparer
%   maxCorrelation : coefficient de correlation le plus haut avec les
%   differents decalages

[nbValeurs, ~] = size(courbe1);
decalageMax = floor(nbValeurs*0.05);
maxCorrelation = 0;

for i=-decalageMax:decalageMax
    ddc =  corrcoef(courbe1(decalageMax+1:nbValeurs-decalageMax),...
        courbe2(decalageMax+i+1:nbValeurs-decalageMax+i));
    ddc = ddc(2);
    if(maxCorrelation<ddc)
        maxCorrelation=ddc;
    end
end

end

