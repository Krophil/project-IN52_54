nomFichier = '7wonders_original.jpg';
image = imread(nomFichier);
ajouterBDD(image, pic2data(image), '7 Wonders', 'bddtest.mat');
nomFichier = 'abyss_original.jpg';
image = imread(nomFichier);
ajouterBDD(image, pic2data(image), 'Abyss', 'bddtest.mat');
nomFichier = 'battlesheep_original.jpg';
image = imread(nomFichier);
ajouterBDD(image, pic2data(image), 'battlesheep', 'bddtest.mat');
nomFichier = 'dungeon_fighter_original.jpg';
image = imread(nomFichier);
ajouterBDD(image, pic2data(image), 'dungeon fighter', 'bddtest.mat');
nomFichier = 'mr_jack_original.jpg';
image = imread(nomFichier);
ajouterBDD(image, pic2data(image), 'mr_jack', 'bddtest.mat');
nomFichier = 'seasons_original.jpg';
image = imread(nomFichier);
ajouterBDD(image, pic2data(image), 'seasons', 'bddtest.mat');

