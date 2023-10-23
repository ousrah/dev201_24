/*EX 1 - Soit la base de données suivante :  (Utilisez celle de la série des fonctions):
Pilote(numpilote,nom,titre,villepilote,daten,datedebut)
Vol(numvol,villed,villea,dated,datea, #numpil,#numav)
Avion(numav,typeav ,capav)*/
#1 – Ajouter la table pilote le champ nb d’heures de vols ‘NBHV’ sous la forme  « 00:00 ».
use vols_201;
alter table pilote add nbhv time;
alter table vol modify dated datetime;
alter table vol modify datea datetime;
update pilote set nbhv = '00:00';
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
select * from pilote;

#3 – Si on supprime un vol le nombre d’heures de vols du pilote qui a effectué ce vol doit être recalculé. Proposez une solution.


#4 – Si on modifie la date de départ ou d’arrivée d’un vol le nombre d’heures de vols du pilote qui a effectué ce vol doit être recalculé. Proposez une solution.



/*EX 2 - Soit la base de données suivante :  (Utilisez celle de la série des PS):

DEPARTEMENT (ID_DEP, NOM_DEP, Ville)
EMPLOYE (ID_EMP, NOM_EMP, PRENOM_EMP, DATE_NAIS_EMP, SALAIRE, #ID_DEP)
*/
#1 – Ajouter le champs salaire moyen dans la table département.
#2 – On souhaite que le salaire moyen soit recalculé automatiquement si on ajoute un nouvel employé, on supprime ou on modifie le salaire d’un ou plusieurs employés. Proposez une solution.

/*EX 2 - Soit la base de données suivante : (Utilisez celle de la série des PS):
Recettes (NumRec, NomRec, MethodePreparation, TempsPreparation)
Ingrédients (NumIng, NomIng, PUIng, UniteMesureIng, NumFou)
Composition_Recette (NumRec, NumIng, QteUtilisee)
Fournisseur (NumFou, RSFou, AdrFou)
*/

#1 – Ajoutez le champ prix à la table recettes.
#2 – On souhaite que le prix de la recette soit calculé automatiquement si on ajoute un nouvel ingrédient, on supprime un ingrédient ou on modifie la quantité ou le prix d’un ou plusieurs ingrédients. Proposez une solution. 
