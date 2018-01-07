function [ resultats ] = chercherDansBDD( histogramme, nomBdd )
%chercherDansBDD Retourne les resultats les plus proches pour une BDD
%   histogramme : histogramme de l'immage dont il faut trouver la
%   correspondance dans la BDD
%   nomBdd : nom de la BDD
%   resultats : cell de taille 4,5 contenant le nom des jeux,
%               les images des jeux, les degres de confiance

    %initialisation
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
        %Ouverture de la BDD
        bdd = load(nomBdd, '-mat');
        bdd = bdd.bdd;
        
        %Boucle pour chaque element de la BDD
        [tailleBDD, ~] = size(bdd);
        for i=1:tailleBDD
            %calcul du coefficient de correlation
            ddc = ressamblanceCourbes(histogramme, bdd{i,3});
            %calcul de la somme des coefficient pour le calcul du
            %pourcentage final
            sommeDdc = sommeDdc + ddc;
            %si le resultat deja calcule avec le coefficient de correlation
            %le plus bas est inferieur au nouveau, on le remplace
            if(ddc > minDdc)
                resultatstmp{indexMinDdc, 1} = bdd{i,1};
                resultatstmp{indexMinDdc, 2} = bdd{i,2};
                resultatstmp{indexMinDdc, 3} = ddc;
                
                
                %Mise a jour du coefficient de correlation le plus bas
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
        
        %trie des resultats
        resultats = flipud(sortrows(resultatstmp,3));
        %calcul des probabilites
        for i=1:nbResultats
            resultats{i,4} = floor(resultats{i,3}/sommeDdc *100);
        end
    end
    

end

