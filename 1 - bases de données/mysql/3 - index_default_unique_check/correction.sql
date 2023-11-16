#Exercice 1 :

#Soit le modèle relationnel suivant relatif à la gestion des notes annuelles d'une promotion d’étudiants :
#ETUDIANT (NEtudiant, Nom, Prénom)
#MATIERE (CodeMat, LibelleMat, CoeffMat)
#EVALUER (NEtudiant, CodeMat, DateExamen, Note)
#Questions :

#1.	Créer la base de données avec le nom « Ecole »;
drop database Ecole;
create database Ecole collate 'utf8mb4_general_ci';
use Ecole;
#2.	Créer les tables avec les clés primaires sans spécifier les clés étrangères ;
create table etudiant(
netudiant int primary key,
nom varchar(255),
prenom varchar(255)
);
create table matiere(
codemat int primary key,
libellemat varchar(255),
coeffmat float
);
create table evaluer(
netudiant int,
codemat int,
dateexaman date ,
note float,
primary key(netudiant,codemat)
);
#3.	Ajouter les clés étrangères à la table EVALUER ; 
alter table evaluer 
add constraint fk_etud foreign key(netudiant) references etudiant(netudiant);

alter table evaluer 
add constraint fk_mat foreign key(codemat) references matiere(codemat);
#4.	Ajouter la colonne Groupe dans la table ETUDIANT: Groupe NOT NULL ; 
alter table etudiant
add column groupe int not null;
#5.	Ajouter la contrainte unique pour l’attribut (LibelleMat) ; 
alter table matiere add constraint uq_libellemat unique(libellemat);
#6.	Ajouter une colonne Age à la table ETUDIANT, avec la contrainte (age >16) ; 
alter table etudiant
add column age int check(age>16);
#7.	Ajouter une contrainte sur la note pour qu’elle soit dans l’intervalle (0-20) ; 
alter table evaluer add constraint chk_note check(note>0 and note<20); # (note between 0 and 20)
#8.	Remplir les tables par les données ;



#Exercice 2 :

#Soit le schéma relationnel suivant :

 # AVION ( NumAv, TypeAv, CapAv, VilleAv)
 # PILOTE (NumPil, NomPil,titre, VillePil) 
 # VOL (NumVol, VilleD, VilleA, DateD, DateA, NumPil#,NumAv#)

#Travail à réaliser :

#  À l'aide de script SQL: 

#1.	Créer la base de données sans préciser les contraintes de clés.
create database Avion collate 'utf8mb4_general_ci';
use Avion;
create table AVION ( 
NumAv int  ,
TypeAv varchar(50),
CapAv int,
 VilleAv varchar (50)
 );
 
create table PILOTE (
NumPil int  , 
NomPil varchar(50),
titre varchar(50), 
VillePil varchar(50)
) ;

create table VOL (
NumVol int  , 
VilleD varchar(50),
 VilleA varchar(50), 
 DateD date , DateA date, NumPil int, NumAv int);
 
#2.	Ajouter les contraintes de clés aux tables de la base.
alter table vol add constraint pk_vol primary key (numvol);
alter table pilote add constraint pk_pilote primary key (numPil);
alter table Avion add constraint pk_avion primary key (numav);

alter table vol add constraint fk_vol_pilote foreign key (numpil) references pilote(numpil) ;
alter table vol add constraint fk_vol_avion foreign key (numav) references avion(numav) ;
#3.	Ajouter des contraintes qui correspondent aux règles de gestion suivantes

#	Le titre de courtoisie doit appartenir à la liste de constantes suivantes :
#M, Melle, Mme.
alter table PILOTE add constraint ck_titre check(titre in ("M","Melle","Mme"));
#	Les valeurs noms, ville doivent être renseignées.
alter table pilote  add constraint chk_NomPil check(NomPil is not null);
alter table pilote 
modify column NomPil varchar(50) not null;
alter table pilote add constraint chk_VillePil check(VillePil is not null);



#	La capacité d’un avion doit être entre 50 et 100.
alter table  AVION  add constraint chk_capacite check (CapAv between 50 and 100);


#4.	Ajouter la  colonne ‘date de naissance’ du pilote : DateN 
alter table pilote
	add DateN date;

#5.	Ajouter une contrainte qui vérifie que la date de départ d’un vol est toujours 
#inférieure ou égale à sa date d’arrivée.
alter table vol 
add constraint chk_verification check(dated <= datea);
#6.	Supprimer la colonne VilleAv
alter table avion drop VilleAv;
#7.	Supprimer la table PILOTE
alter table vol
drop constraint fk_vol_pilote;
drop table pilote;

#8.	Remplir la base de données pour vérifier les contraintes appliquées.
