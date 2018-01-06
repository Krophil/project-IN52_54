function [ ] = ajouterBDD( image, histogrammeImage, nomJeu, nomBDD )
%ajouterBDD Ajoute un element dans une base de donnée
%       Si il y a un jeu du meme nom, les donnees sont remplacees
% image : l'image de la boite du jeu a ajouter comme reference
% histogrammeImage : les donnes utilisees pour comparer les boites
% nomJeu : Nom du jeu a ajouter
% nomBDD : nom du fichier contenant la base de donnée

    %On verifie l'existance du fichier
    if( exist(nomBDD, 'file') > 0)
        %On charge la BDD
        bdd = load(nomBDD, '-mat');
        bdd = bdd.bdd;
        [taille, ~] = size(bdd);
        index = taille + 1;
        %On cherche si le jeu est deja enregistre
%         for i=1:taille 
%             if(nomJeu == bdd{i,1})
%                 index = i;
%             end
%         end
        bdd{index, 1} = nomJeu;
        bdd{index, 2} = image;
        bdd{index, 3} = histogrammeImage;
    else
        %Si le fichier n'existe pas, on cree une nouvelle base de donnee
        bdd = cell(1,3);
        bdd{1, 1} = nomJeu;
        bdd{1, 2} = image;
        bdd{1, 3} = histogrammeImage;
    end
    %On ecrase le fichier pour enregistrer la base a jour
    save(nomBDD, 'bdd');
end

