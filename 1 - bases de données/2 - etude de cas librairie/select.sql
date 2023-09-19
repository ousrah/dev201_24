select ceiling(rand()*25);

use librairie_201;
# 1.	Liste des noms des éditeurs situés à Paris triés 
#par ordre alphabétique. 
select distinct NOMED 
FROM EDITEUR
WHERE VILLEED="paris"
order by NOMED ;



#2.	Liste des écrivains de (tous les champs)  langue française,
# triés par ordre alphabétique sur le nom et le prénom.
select distinct * from ecrivain 
where LANGUECR="Français"
order by NOMECR desc , PRENOMECR ASC;



#3.	Liste des titres des ouvrages (NOMOUVR) ayant été
# édités entre (ANNEEPARU) 1986 et 1987.
select nomouvr from ouvrage 
where anneeparu between 1986 and 1987;

#4.	Liste des éditeurs dont le n° de téléphone est inconnu
select * 
from editeur 
where TELED is NULL;

#5.	Liste des auteurs (nom + prénom) dont le nom contient un ‘C’.
select concat(NomEcr , ' ' , PrenomEcr)
from Ecrivain
where NomEcr like '%C%' ; 


#6.	Liste des titres d’ouvrages contenant  
#le mot "banque" (éditer une liste triée par n° d'ouvrage croissant). 
select  nomouvr
from ouvrage
where nomouvr like '%banque%'
order by numouvr;


#7.	Liste des dépôts (nom) situés à Grenoble ou à Lyon.

select Nomdep
from depot
where villeDEP in( 'Grenoble','Lyon');

#8.	Liste des écrivains (nom + prénom) américains
# ou de langue française. 
select concat(NomEcr , ' ' , PrenomEcr) as nom from ecrivain
where paysecr ="usa" or languecr = "francais";

#9.	Liste des auteurs (nom + prénom) de langue 
#française dont le nom ou le prénom commence par un ‘H’. 

select concat(NomEcr , ' ' , PrenomEcr), languecr as nom from ecrivain
where languecr = "francais" and (nomecr like "H%" or prenomecr like "H%");

select 5 * 3 + 2;
select 5 * (3 + 2 );


#10.	Titres des ouvrages en stock au dépôt n°2. 
select NOMOUVR 
FROM OUVRAGE O
JOIN STOCKER S ON S.NUMOUVR=O.NUMOUVR
WHERE S.NUMDEP="2";


select NOMOUVR 
FROM OUVRAGE where NUMOUVR in(
	select NUMOUVR from stocker
    WHERE NUMDEP="2");

#11.	Liste des auteurs (nom + prénom) ayant écrit des livres coûtant 
#au moins 30 € au 1/10/2002. 
select concat(NomEcr , ' ' , PrenomEcr) as auteurs from ecrivain ecr
join ecrire e on ecr.numecr = e.numecr
join ouvrage o on e.numouvr = o.numouvr
join tarifer t on o.numouvr= t.numouvr
where t.prixvente>=30 and t.datedeb="2002-10-01";

#12.	Ecrivains (nom + prénom) ayant écrit des livres sur le thème (LIBRUB) 
#des « finances publiques ». 
select distinct concat(NomEcr , ' ' , PrenomEcr) as auteurs from ecrivain ecr
join ecrire e on ecr.numecr = e.numecr
join ouvrage o on e.numouvr = o.numouvr
join classification c on c.numrub=o.numrub
where c.librub="finances publiques";
#13.	Idem R12 mais on veut seulement les auteurs dont le nom contient un ‘A’. 

select distinct concat(NomEcr , ' ' , PrenomEcr) as auteurs from ecrivain ecr
join ecrire e on ecr.numecr = e.numecr
join ouvrage o on e.numouvr = o.numouvr
join classification c on c.numrub=o.numrub
where c.librub="finances publiques"
AND nomEcr like "%A%";


#14.	En supposant l’attribut PRIXVENTE dans TARIFER comme un prix TTC et 
#un taux de TVA égal à 15,5% sur les ouvrages, donner le prix HT de chaque ouvrage. 



SELECT o.NOMOUVR,T.prixvente/1.155 as prixht , prixvente
from ouvrage o 
join tarifer T on o.NUMOUVR=T.NUMOUVR;
#15.	Nombre d'écrivains dont la langue est l’anglais ou l’allemand. 

select count(*) nb
from ecrivain
where languecr in ("anglais","allemand");


#16.	Nombre total d'exemplaires d’ouvrages sur la « gestion de portefeuilles »
# (LIBRUB) stockés dans les dépôts Grenoblois. 

select sum(Qtestock) nbExemplaire 
from stocker s
join ouvrage o on s.NUMOUVR=o.NUMOUVR
join classification c on o.NUMRUB=c.NUMRUB
join depot d on d.NUMDEP =s.NUMDEP 
where c.LIBRUB="gestion de portefeuilles"
and d.villedep="Grenoble";


select sum(qtestock) nbExemplaires
from stocker s 
where numouvr in (select numouvr from ouvrage where numrub in 
                   (select numrub from classification where librub = 'gestion de portefeuilles'))
and numdep in (select numdep from depot where villedep = 'grenoble');

#17.	Titre de l’ouvrage ayant le prix le plus élevé - faire deux requêtes.
# (réponse: Le Contr ôle de gestion dans la banque.)
select NOMOUVR from OUVRAGE 
join TARIFER on OUVRAGE.NUMOUVR = TARIFER.NUMOUVR
where PRIXVENTE = (select max(PRIXVENTE) from TARIFER);

#la réponse suivante est fausse
select nomouvr , prixvente 
from ouvrage o join tarifer t on o.numouvr= t.numouvr
order by prixvente desc
limit 1;

#18.	Liste des écrivains avec pour chacun le nombre d’ouvrages qu’il a écrits. 
select concat(NomEcr , ' ' , PrenomEcr) as auteurs, count(*) as 'nb ouevres'
from ecrire e
join ecrivain ecr on e.numecr=ecr.numecr
group by auteurs;
#19.	Liste des rubriques de classification avec, pour chacune, le nombre 
#d'exemplaires en stock dans les dépôts grenoblois. 

select c.librub, sum(s.Qtestock) nbExemplaires
from classification c
join ouvrage o on o.numrub=c.numrub
join stocker s on s.numouvr=o.numouvr
join depot d on d.NUMDEP =s.NUMDEP 
where  d.villedep="Grenoble"
group by c.librub ;


create view q19 as
select c.librub, sum(s.Qtestock) nbExemplaire 
from classification c
join ouvrage o on o.numrub=c.numrub
join stocker s on s.numouvr=o.numouvr
join depot d on d.NUMDEP =s.NUMDEP 
where  d.villedep="Grenoble"
group by c.librub ;

#20.	Liste des rubriques de classification avec leur état de stock dans les
# dépôts grenoblois: ‘élevé’ s’il y a plus de 1000 exemplaires dans cette rubrique, 
#‘faible’ sinon. (réutiliser la requête 19). 




case
 when condition then 'value'
 when condition then 'value'
 when condition then 'value'
 when condition then 'value'
 when condition then 'value'
 else 'value'
end

case champ
  when v1 then 'value'
  when v2 then 'value'
  when v3 then 'value'
  else 'value'
end


select c.librub,sum(s.qtestock) as nb, 
	case 
		when sum(s.qtestock)>1000 then "élevé"
        else "faible"
        end as "etat stock"
from classification c
join ouvrage o on o.numrub=c.numrub
join stocker s on s.numouvr=o.numouvr
join depot d on d.NUMDEP =s.NUMDEP
where  d.villedep="Grenoble"
group by c.librub ;



select librub, nbExemplaire,
case 
when nbExemplaire >1000 then 'eleve'
else 'faible'
end as 'etat stock'
 from Q19
 

#21.	Liste des auteurs (nom + prénom) ayant écrit des livres sur 
#le thème (LIBRUB) des « finances publiques » ou bien ayant écrit des livres
# coûtant au moins 30 € au 1/10/2002 - réutiliser les requêtes 11 et 12. 


#22.	Liste des écrivains (nom et prénom) n’ayant écrit aucun des ouvrages 
#présents dans la base. 


#23.	Mettre à 0 le stock de l’ouvrage n°6 dans le dépôt Lyon2. 


#24.	Supprimer tous les ouvrages de chez Vuibert de la table OUVRAGE.


#25.	créer une table contenant les éditeurs situés à Paris et leur n° de tel.  

