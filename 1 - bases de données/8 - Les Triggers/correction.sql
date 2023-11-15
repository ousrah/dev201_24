/*EX 1 - Soit la base de données suivante :  (Utilisez celle de la série des fonctions):
Pilote(numpilote,nom,titre,villepilote,daten,datedebut)
Vol(numvol,villed,villea,dated,datea, #numpil,#numav)
Avion(numav,typeav ,capav)*/
#1 – Ajouter la table pilote le champ nb d’heures de vols ‘NBHV’ sous la forme  « 00:00 ».
use vols_201;
alter table pilote add nbhv time default "00:00:00";
alter table vol modify dated datetime;
alter table vol modify datea datetime;
#update pilote set nbhv = '00:00';
select * from pilote;
select * from vol;
#2 – Ajouter un déclencheur qui calcule le nombre heures lorsqu’on 
#ajoute un nouveau vol et qui augmente automatiquement le 
#nb d’heures de vols du pilote qui a effectué le vol.

drop trigger if exists t1;
delimiter $$
create trigger t1 after insert on Vol for each row
begin 
	update pilote set NBHV=NBHV+timediff(new.datea, new.dated) where numpilote= NEW.numpil ;
end $$
delimiter ;
insert into vol values
(15,'tetouan','casa','2023-10-01 09:00','2023-10-01 10:00',2,1);
select * from vol;
select floor(rand()*23);
#3 – Si on supprime un vol le nombre d’heures de vols du pilote qui a effectué ce vol doit être recalculé. Proposez une solution.
drop trigger if exists t2;
delimiter $$
create trigger t2 after delete on Vol for each row
begin 
	update pilote set NBHV=NBHV-timediff(old.datea, old.dated) where numpilote= old.numpil ;
end $$
delimiter ;
delete from vol where numvol=15;
select * from pilote;
#4 – Si on modifie la date de départ ou d’arrivée d’un vol le nombre d’heures de vols du pilote qui a effectué ce vol doit être recalculé. Proposez une solution.

drop trigger if exists q4;
delimiter $$
create trigger q4 after update on vol for each row
begin

    declare ancienne_duree time;
    declare nouvelle_duree time;
    set ancienne_duree = timediff(old.datea, old.dated);
    set nouvelle_duree = timediff(new.datea, old.dated);
    if (old.datea!=new.datea or old.dated!=new.dated) then
		update pilote
			set nbhv = nbhv - ancienne_duree + nouvelle_duree
			where numpilote = new.numpil;
	end if;
end $$
delimiter ;
update vol set datea = '2023-10-01 10:00:00' where numvol = 14;
select * from pilote;
select * from vol;

/*EX 2 - Soit la base de données suivante :  (Utilisez celle de la série des PS):

DEPARTEMENT (ID_DEP, NOM_DEP, Ville)
EMPLOYE (ID_EMP, NOM_EMP, PRENOM_EMP, DATE_NAIS_EMP, SALAIRE, #ID_DEP)
*/
#1 – Ajouter le champs salaire moyen dans la table département.
use employes_201;
alter table departement
add column salaire_moyen float;
#2 – On souhaite que le salaire moyen soit recalculé automatiquement si on ajoute un nouvel employé, on supprime ou on modifie le salaire d’un ou plusieurs employés. Proposez une solution.

drop trigger if exists t3;
delimiter $$
create trigger t3 after  update on employe  on Employe for each row
begin 
	update departement set salaire_moyen=(select avg(salaire)from employe  where ID_DEP= NEW.ID_DEP )
     where ID_DEP= NEW.ID_DEP;
end $$
delimiter ;

drop trigger if exists t4;
delimiter $$
create trigger t4 after delete  on Employe  for each row
begin 
	update departement set salaire_moyen=(select avg(salaire)from employe  where ID_DEP= old.ID_DEP )
     where ID_DEP= old.ID_DEP;
end $$
delimiter ;


drop trigger if exists t5;
delimiter $$
create trigger t5 after update  on Employe  for each row
begin 
	update departement set salaire_moyen=(select avg(salaire)from employe  where ID_DEP= old.ID_DEP )
     where ID_DEP= old.ID_DEP;
end $$
delimiter ;

select * from employe where id_dep=1;

insert into employe values (8,'test','test','2023-10-25',8250,1);
update employe set salaire = 15000 where id_emp = 2;
delete from employe where id_emp = 1;
select * from departement;


/*EX 2 - Soit la base de données suivante : (Utilisez celle de la série des PS):
Recettes (NumRec, NomRec, MethodePreparation, TempsPreparation)
Ingrédients (NumIng, NomIng, PUIng, UniteMesureIng, NumFou)
Composition_Recette (NumRec, NumIng, QteUtilisee)
Fournisseur (NumFou, RSFou, AdrFou)
*/

#1 – Ajoutez le champ prix à la table recettes.
use cuisine_201;
alter table recettes add column prix float default 0;

#2 – On souhaite que le prix de la recette soit calculé automatiquement 
#si on ajoute un nouvel ingrédient, on supprime un ingrédient ou on modifie la quantité ou le prix 
#d’un ou plusieurs ingrédients. Proposez une solution. 

delimiter $$
create trigger q1 after insert on Composition_Recette
for each row 
begin
	update Recettes set prix = prix + (
						select PUIng from Ingrédients where NumIng = new.NumIng 
						) * new.QteUtilisee where NumRec =new.NumRec;
end$$
delimiter ;


select floor(rand()*23);
delimiter $$
create trigger q2 after delete on Composition_Recette
for each row 
begin
	update Recettes set prix = prix -(
						select PUIng from Ingrédients where NumIng = old.NumIng 
						) * old.QteUtilisee where NumRec =old.NumRec;
end$$
delimiter ;
delete from Composition_Recette where NumRec=4 and NumIng=2;


select * from recettes;
insert into recettes values (4,'test','test',15,0);
select * from Composition_Recette;
insert into Composition_Recette values (4,1,1);
insert into Composition_Recette values (4,2,2);
select * from ingrédients;

drop trigger q3;
delimiter $$
create trigger q3 after update on Composition_Recette
for each row 
begin
	update Recettes set prix = prix +(
						select PUIng from Ingrédients where NumIng = new.NumIng 
						) * (new.QteUtilisee-old.QteUtilisee)
                        
                        where NumRec =new.NumRec;
end$$
delimiter ;
update Composition_Recette set QteUtilisee=2  where NumRec=4 and NumIng=1;

select * from recettes where numrec = 6;
insert into recettes values (6,'dev6','dev6',15,0);
select * from Composition_Recette where numrec = 5;
insert into Composition_Recette values (6,1,1);
insert into Composition_Recette values (6,2,1);
delete from  Composition_Recette where numrec = 6 and numing = 2;
update Composition_Recette set qteutilisee=0 where numrec = 6 and numing=1;



update recettes set prix = 0;
select * from recettes;



select * from ingrédients;

select * from composition_recette;


drop trigger if exists t5;
delimiter $$
create trigger t5 after update on ingrédients for each row
begin
	declare numr int;
    declare prixx float;
    declare flag boolean default false;
    declare c1 cursor for select distinct numRec from composition_recette where numIng = new.numIng;
    declare continue handler for not found set flag = true;
    open c1;
		b1:loop
			fetch c1 into numr;
            if flag then
				leave b1;
			end if;
            select sum(PuIng*qteutilisee) into prixx from composition_recette cp 
					join ingrédients i on cp.numing=i.numing where numrec = numr;
            update recettes set prix = prixx where numrec = numr;
        end loop b1;
    close c1;
end $$
delimiter ;
select * from ingrédients;
select * from recettes;
update ingrédients
set puing=5;



 