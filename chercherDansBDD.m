function [ resultats ] = chercherDansBDD( histogramme, nomBdd )
%UNTITLED3 Summary of this function goes here
%   resultats : cell de taille 3,5 contenant le nom des jeux,
%               les images des jeux et les degres de confiance

    nbResultats = 5;
    resultats = cell(nbResultats,3);
    sommeDdc = 0;
    minDdc = 0;
    indexMinDdc = 1;
    if( exist(nomBdd, 'file') > 0)
        bdd = load(nomBdd, '-mat');
        bdd = bdd.bdd;
        
        [tailleBDD, ~] = size(bdd);
        for i=1:tailleBDD
            ddc = exp(-norm(histogramme - bdd{i,3}));
            sommeDdc = sommeDdc + ddc;
            if(ddc > minDdc)
                resultats{indexMinDdc, 1} = bdd{i,1};
                resultats{indexMinDdc, 2} = bdd{i,2};
                resultats{indexMinDdc, 3} = ddc;
                
                
                %Mise a jour du degre de confiance minimal
                minDdc = resultats{1, 3};
                indexMinDdc = 1;
                for j=2:nbResultats
                    if(minDdc > resultats{j, 3})
                        minDdc = resultats{j, 3};
                        indexMinDdc = j;
                    end
                end
            end
        end
        for i=1:nbResultats
            resultats{i,3} = resultats{i,3}/sommeDdc;
        end
        
    end
    

end

