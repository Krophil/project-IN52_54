function [ resultats ] = chercherDansBDD( histogramme, nomBdd )
%UNTITLED3 Summary of this function goes here
%   resultats : cell de taille 4,5 contenant le nom des jeux,
%               les images des jeux, les degres de confiance

    nbResultats = 5;
    resultatstmp = cell(nbResultats,3);
    resultats = cell(nbResultats,4);
    for i=1:nbResultats
        resultatstmp{i,3} = 0;
    end
    sommeDdc = 0;
    minDdc = 0;
    indexMinDdc = 1;
    if( exist(nomBdd, 'file') > 0)
        bdd = load(nomBdd, '-mat');
        bdd = bdd.bdd;
        
        [tailleBDD, ~] = size(bdd);
        for i=1:tailleBDD
            ddc = (corrcoef(histogramme, bdd{i,3}));
            ddc = ddc(2);
            sommeDdc = sommeDdc + ddc;
            if(ddc > minDdc)
                resultatstmp{indexMinDdc, 1} = bdd{i,1};
                resultatstmp{indexMinDdc, 2} = bdd{i,2};
                resultatstmp{indexMinDdc, 3} = ddc;
                
                
                %Mise a jour du degre de confiance minimal
                minDdc = resultatstmp{1, 3};
                indexMinDdc = 1;
                for j=2:nbResultats
                    if(minDdc > resultatstmp{j, 3})
                        minDdc = resultatstmp{j, 3};
                        indexMinDdc = j;
                    end
                end
            end
        end
%         for i=1:nbResultats
%             resultats{i,3} = resultats{i,3}/sommeDdc;
%         end
        resultats = flipud(sortrows(resultatstmp,3));
        for i=1:nbResultats
            resultats{i,4} = floor(resultats{i,3}/sommeDdc *100);
        end
    end
    

end

