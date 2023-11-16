#1 - on va copier le tableu de word vers excel
#2 - on va enregistrer le fichier excel sous forme csv avec l'option ; comme separateur et unicode (UTF8) comme codage
#creer un base de donnée vide
create database ecole_201 collate utf8mb4_general_ci;
#clique bouton droit sur la base de donnée et lancer l'importation avec Table Data import Wizard
#remarque garder tous les champs avec le type texte

#visualisez votre tableau importé
SELECT * FROM ecole_201.tableau;

#correction des notes en remplaçant les , par les .
update tableau set note = replace(note,',','.');
#vérification
select * from tableau;

#modifier le type du champ note
alter table tableau modify Note  float;

#extraction des villes
create table ville 
	select distinct ville as nom  from tableau;

#visualisez l'importation
select * from ville;

#ajout de la clé primaire
alter table ville add id int auto_increment primary key;

#vérification
select * from ville;


#extraction des classes
create table classe 
	select distinct classe as nom  from tableau;
#visualisez l'importation
select * from classe;

#ajout de la clé primaire
alter table classe add id int auto_increment primary key;
#vérification
select * from classe;

#correction de la date de naissance
update tableau set `date Naissance` = date_format(str_to_date(`date Naissance`,'%d/%m/%Y'),'%Y-%m-%d');

#vérification
select * from tableau;

#modifier le champ date de naissance en type date
alter table tableau modify `date Naissance` date;

#extraction des stagiaires
create table stagiaire
	select distinct `Nom stagiaire` as nom,`prénom Stagiaire` as prenom , `Date Naissance` as daten, v.id as id_ville, c.id as id_classe 
    from tableau t join ville v on t.ville = v.nom
    join classe c on t.classe = c.nom;

#vérification
select * from stagiaire
#ajout de la clé primaire
alter table stagiaire add id int auto_increment primary key;

#ajout des clé étrangères
alter table stagiaire add constraint fk_stagiaire_ville foreign key(id_ville ) references ville(id);
alter table stagiaire add constraint fk_stagiaire_classe foreign key(id_classe ) references classe(id);


#extraction des matieres
create table matiere 
	select distinct Matière as nom  from tableau;
select * from matiere;
alter table matiere add id int auto_increment primary key;
select * from matiere;


#extraction des Appréciation
create table appreciation 
	select distinct Appréciation as nom  from tableau;
select * from appreciation;
alter table appreciation add id int auto_increment primary key;
select * from appreciation;



#extraction des notes
create table note
	select note, s.id as id_stagiaire, m.id id_matiere, a.id id_appreciation
	from tableau t
	join stagiaire s on (t.`Nom stagiaire` = s.nom and t.`prénom Stagiaire` = s.prenom)
	join matiere m on t.Matière = m.nom
	join appreciation a on t.Appréciation = a.nom;
    
#creation de la clé primaire   
alter table note add constraint pk_note primary key (id_stagiaire, id_matiere) ;
#creation des clés étrangères
alter table note add constraint fk_note_stagiaire foreign key(id_stagiaire ) references stagiaire(id);
alter table note add constraint fk_note_matiere foreign key(id_matiere ) references matiere(id);
alter table note add constraint fk_note_appreciation foreign key(id_appreciation ) references appreciation(id);
   