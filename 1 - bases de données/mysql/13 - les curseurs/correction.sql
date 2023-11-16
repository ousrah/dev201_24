#Objectif : Manipuler les curseurs/imbriquer les curseurs

#Base de données ‘Gestion_vols’ :


use vols_201;
select * from pilote;
alter table pilote add salaire float;

#1)	Réalisez un curseur en lecture seule avec déplacement vers l’avant qui extrait 
#la liste des pilotes avec pour informations l’identifiant, le nom et le salaire du pilote ;
select * from pilote ;
select * from vol;
#Affichez les informations à l’aide de l’instruction Select (print)
drop procedure if exists q1;
delimiter $$
create procedure q1()
begin
	declare id int;
    declare nomp varchar(55);
    declare s float;
    declare nb int;
    declare flag boolean default false ;
    declare c1 cursor for select numpilote,nom,salaire from pilote;
    declare continue handler for not found set flag = true;
    open c1;
    b1:loop
		fetch c1 into id,nomp,s;
        if flag then
			leave b1;
		end if;
        select concat( "le pilote (",id,")", " ",nomp," " , ifnull(s,""), " est affecté aux vols")  pilote;
		select concat(" Depart " , villed,  "  arrivée  ", villea) voyage from vol where numpil = id;
		select count(numvol)into nb from vol where numpil = id ;
        if nb = 0 then 
			update pilote set salaire = 5000 where numpilote = id;
		elseif (nb between 1 and 3) then
			update pilote set salaire = 7000 where numpilote = id;
		else
			update pilote set salaire = 8000 where numpilote = id;
        end if;
        

	end loop b1;
    close c1;
end $$
delimiter ;
call q1();


#2)	Complétez le script précédent en imbriquant un deuxième curseur qui va préciser pour chaque pilote, quels sont les vols effectués par celui-ci.

#Vous imprimerez alors, pour chaque pilote une liste sous la forme suivante :
#- Le pilote ‘ xxxxx xxxxxxxxxxxxxxxxx est affecté aux vols :
#       Départ : xxxx  Arrivée : xxxx
#       Départ : xxxx  Arrivée : xxxx
#       Départ : xxxx  Arrivée : xxxx
#-Le pilote ‘ YYY YYYYYYYY est affecté aux vols :
#       Départ : xxxx  Arrivée : xxxx
#       Départ : xxxx  Arrivée : xxxx


#3)	Vous allez modifier le curseur précédent pour pouvoir mettre à jour le salaire du pilote. Vous afficherz une ligne supplémentaire à la suite de la liste des vols en précisant l’ancien et le nouveau salaire du pilote.
#Le salaire brut du pilote est fonction du nombre de vols auxquels il est affecté :

#	Si 0 alors le salaire est 5 000
#	Si entre 1 et 3,  salaire de 7 000
#	Plus de 3, salaire de 8000


#Exercice 2
#Soit la base de données suivante

#Employé :

#Matricule	nom	prénom	état
#1453	Lemrani	Kamal	fatigué
#4532	Senhaji	sara	En forme
#			…
#			..

#Groupe :
#Matricule	Groupe
#1453	Administrateur
#1453	Chef
#4532	Besoin vacances
#…	


drop database if exists employes_201;
create database employes_201 collate utf8mb4_general_ci;
use employes_201;
create table employe(matricule int  primary key, nom varchar(50), prenom varchar(50), etat varchar(50));
create table groupe (matricule int , groupe varchar(50), constraint fk_employe foreign key (matricule) references employe(matricule));

insert into employe values (1453,'lemrani','kamal','fatigué'),(4532,'senhaji','sara','en forme');


#On désire ajouter les employés dont l’état est fatigué dans le groupe ‘besoin vacances’ dans la table Groupe;
#Utiliser un curseur ;
drop procedure if exists ex2;
delimiter $$
create procedure ex2()
begin
	declare m int ;
	declare flag boolean default false ;
	declare c1 cursor for  select matricule from employe where etat='fatigué';
	declare continue handler for not found  set flag=true;
	open c1;
		b1:loop
			fetch c1 into m;
			if flag then 
				leave b1;
			end if ;
			insert into groupe values(m,'besoin vacances');
		end loop b1;
	close c1;
end $$
delimiter ;
select * from employe;
select * from groupe;
call ex2();




