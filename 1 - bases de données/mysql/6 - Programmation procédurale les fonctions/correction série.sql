use librairie_201;
drop function if exists dateff;
delimiter &&
create function dateff( dateP varchar(50))
returns varchar(50)
deterministic
begin
    return date_format(str_to_date(dateP,"%d/%m/%Y"),"%d %M %Y");
end &&
delimiter ;


drop function if exists dateff;
delimiter &&
create function dateff( dateP varchar(50))
returns varchar(50)
deterministic
begin
 declare day int default day(str_to_date(dateP,"%d/%m/%Y"));
 declare year int default year(str_to_date(dateP,"%d/%m/%Y"));
 declare month int default month(str_to_date(dateP,"%d/%m/%Y"));
 declare name varchar(50) default case month
 when 1 then ' Janvier '
 when 2 then ' Favrier '
 when 3 then ' Mars '
 when 4 then ' Avril '
 when 5 then ' Mai '
 when 6 then ' Juin '
 when 7 then ' Juillet '
 when 8 then ' Aout '
 when 9 then ' Septembre '
 when 10 then ' Octobre '
 when 11 then ' Novembre '
 when 12 then ' Decembre '
  
 end;
    return concat (day, name, year);
end &&
delimiter ;


select dateff("12/01/2011 ") as date;

#exercice2

drop function if exists CalculerEcartEntreDates;
DELIMITER $$

CREATE FUNCTION CalculerEcartEntreDates(date1 DATETIME, date2 DATETIME, unite VARCHAR(10))
RETURNS varchar(50)
deterministic
BEGIN
    DECLARE ecart varchar(50);
    IF unite = 'jour' THEN
        SET ecart = TIMESTAMPDIFF(day, date1, date2);
    ELSEIF unite = 'mois' THEN
        SET ecart = TIMESTAMPDIFF(month, date1, date2);
    ELSEIF unite = 'annee' THEN
        SET ecart = TIMESTAMPDIFF(year, date1, date2);
    ELSEIF unite = 'heure' THEN
        SET ecart = TIMESTAMPDIFF(HOUR, date1, date2);
    ELSEIF unite = 'minute' THEN
        SET ecart = TIMESTAMPDIFF(MINUTE, date1, date2);
    ELSEIF unite = 'seconde' THEN
        SET ecart = TIMESTAMPDIFF(SECOND, date1, date2);
    ELSE
        SET ecart = "erreur"; 
    END IF;

    RETURN ecart;
END $$

DELIMITER ;

select CalculerEcartEntreDates("1999-8-7","1999-9-10","mois");

select if(1=0,"egale",if(2=3,"deux","trois"));


/*
Exercice 3 : application sur la bd ‘gestion_vols’
Gestion vol
Pilote(numpilote,nom,titre,villepilote,daten,datedebut)
Vol(numvol,villed,villea,dated,datea, #numpil,#numav)
Avion(numav,typeav ,capav)
*/

drop database if exists vols_201;

create database vols_201 collate utf8mb4_general_ci;
use vols_201;

create table Pilote(numpilote int auto_increment primary key,
nom varchar(50),
titre varchar(50),
villepilote varchar(50),
daten date,
datedebut date);

create table Avion(numav int auto_increment primary key,
typeav  varchar(50),
capav int);

create table Vol(numvol int auto_increment primary key,
villed varchar(50),
villea varchar(50),
dated date,
datea date, 
numpil int,
constraint fk_vols_pilote foreign key(numpil) references pilote(numpilote),
numav int,
constraint fk_vols_avion foreign key(numav) references avion(numav));

insert into pilote values (1,'khalid','M.','tetouan','1980-01-01','2000-01-01'),
(2,'souad','Mme.','casablanca','1990-01-01','2010-01-01'),
(3,'mohamed','M.','marrakech','2000-01-01','2022-01-01');

insert into avion values (1,'boeing',120),
(2,'caravel',30),
(3,'airbus',150);

insert into avion values (4,'test',120);

insert into vol values
(1,'tetouan','casablanca','2023-10-01','2023-10-01',1,1),
(2,'tetouan','casablanca','2023-10-01','2023-10-01',1,2),
(3,'casablanca','tetouan','2023-10-02','2023-10-02',1,3),
(4,'tanger','casablanca','2023-10-03','2023-10-03',2,1),
(5,'casablanca','tanger','2023-10-04','2023-10-04',2,2),
(6,'marrakech','casablanca','2023-10-05','2023-10-05',2,3),
(7,'casablanca','marrakech','2023-10-06','2023-10-06',3,1),
(8,'tanger','marrakech','2023-10-07','2023-10-07',3,2),
(9,'marrakech','tanger','2023-10-08','2023-10-08',3,3),
(10,'tetouan','casablanca','2023-10-12','2023-10-12',1,2),
(11,'casablanca','tetouan','2023-10-12','2023-10-12',1,2);

#1.	Ecrire une fonction qui retourne le nombre de pilotes ayant 
#effectué un nombre de vols supérieur à un nombre donné comme paramètre ;



drop function if exists q1;
delimiter $$
	create function q1(n int)
    returns int
    reads sql data
    begin
		declare nb int default 0;
        
        select count(*) into nb from (
						select numpil, count(numvol) 
						from vol
						group by numpil
						having count(numvol)>n) f;
                        
        return nb;
    end $$
delimiter ;
select q1(2);
select q1(4);
select q1(6);



#2.	Ecrire une fonction qui retourne la durée de travail d’un pilote 
#dont l’identifiant est passé comme paramètre ;



drop function if exists q2;
delimiter $$
	create function q2(n int)
    returns varchar(250)
    reads sql data
    begin
		declare nb int ;
        declare y,m,d int;
        declare result varchar(250);
		select timestampdiff(day,datedebut,date(now())) into nb 
						from pilote 
						where numpilote = n;
		set y= floor(nb/365);
        set m = floor((nb%365)/30);
        set d = (nb%365)%30;
	    set result = concat("le pilote num ",n," a travaillé pendant : " , y ," année(s),  ", m , " mois et " , d , " jour(s)");
        return result;
    end $$
delimiter ;

select q2(3);

#3.	Ecrire une fonction qui renvoie le nombre des avions 
#qui ne sont pas affectés à des vols ;

drop function if exists q3;
delimiter $$
	create function q3()
    returns int
    reads sql data
    begin
		declare nbAvion int;
        select count(*) into nbAvion
		from Avion
		where Avion.numav not in (select distinct numav from vol);
        
        /*select count(*) into nbAvion from avion a
			left join vol v on v.numav=a.numav
			where v.numav is null*/

        return nbAvion;
    end $$
delimiter ;
select q3();






#4.	Ecrire une fonction qui retourne le numero du plus ancien 
#pilote qui a piloté l’avion dont le numero est passé en paramètre ;


drop function if exists q4;
delimiter $$
	create function q4(n int)
    returns int
    reads sql data
    begin
		declare pil int;
        
			select numpilote into pil from pilote p join vol v on p.numpilote = v.numpil
			where datedebut in
						(select min(datedebut)
						from pilote p join vol v on p.numpilote = v.numpil
						where numav = n)
			and  numav = n;

        return pil;
    end $$
delimiter ;
select q4(1);



select numpilote from pilote p join vol v on p.numpilote = v.numpil
where datedebut in
			(select min(datedebut)
			from pilote p join vol v on p.numpilote = v.numpil
			where numav = 1)
and  numav = 1;




#5.	Ecrire une fonction table qui retourne 
#le nombre des pilotes dont le salaire est inférieur
# à une valeur passée comme paramètre ;


/*
Exercice 4:
Considérant la base de données suivante :
DEPARTEMENT (ID_DEP, NOM_DEP, Ville)
EMPLOYE (ID_EMP, NOM_EMP, PRENOM_EMP, DATE_NAIS_EMP, SALAIRE,#ID_DEP)
*/


drop database if exists employes_201;

create database employes_201 COLLATE "utf8_general_ci";
use employes_201;


create table DEPARTEMENT (
ID_DEP int auto_increment primary key, 
NOM_DEP varchar(50), 
Ville varchar(50));

create table EMPLOYE (
ID_EMP int auto_increment primary key, 
NOM_EMP varchar(50), 
PRENOM_EMP varchar(50), 
DATE_NAIS_EMP date, 
SALAIRE float,
ID_DEP int ,
constraint fkEmployeDepartement foreign key (ID_DEP) references DEPARTEMENT(ID_DEP));

insert into DEPARTEMENT (nom_dep, ville) values 
		('FINANCIER','Tanger'),
		('Informatique','Tétouan'),
		('Marketing','Martil'),
		('GRH','Mdiq');

insert into EMPLOYE (NOM_EMP , PRENOM_EMP , DATE_NAIS_EMP , SALAIRE ,ID_DEP ) values 
('said','said','1990/1/1',8000,1),
('hassan','hassan','1990/1/1',8500,1),
('khalid','khalid','1990/1/1',7000,2),
('souad','souad','1990/1/1',6500,2),
('Farida','Farida','1990/1/1',5000,3),
('Amal','Amal','1990/1/1',6000,4),
('Mohamed','Mohamed','1990/1/1',7000,4);

select * from employe;

#1.	Créer une fonction qui retourne le nombre d’employés
drop function if exists q1;
delimiter $$
create function q1()
returns int
reads sql data
begin
    return  (select count(*)  from employe);
end $$
delimiter ;

select q1();
#2.	Créer une fonction qui retourne la somme des salaires de tous les employés
delimiter $$
create function q2()
returns int
reads sql data
begin
    return  (select sum(SALAIRE)  from employe);
end $$
delimiter ;

select q2();
#3.	Créer une fonction pour retourner le salaire minimum de tous les employés
delimiter $$
create function q3()
returns int
reads sql data
begin
    return  (select min(SALAIRE)  from employe);
end $$
delimiter ;

select q3();
#4.	Créer une fonction pour retourner le salaire maximum de tous les employés
delimiter $$
create function q4()
returns int
reads sql data
begin
    return  (select max(SALAIRE)  from employe);
end $$
delimiter ;

select q4();
#5.	En utilisant les fonctions créées précédemment, 
#Créer une requête pour afficher le nombre des employés, 
#la somme des salaires, le salaire minimum et le salaire maximum

select q1() as nombreEMP,
		q2() as sommeSalaire,
        q3() as minsalaire,
        q4() as maxsalaire;

#6.	Créer une fonction pour retourner le nombre d’employés d’un département donné.
delimiter $$
create function q6(id int)
returns int
reads sql data
begin
    return  (select count(*)  from employe
					where ID_DEP=id);
end $$
delimiter ;
select q6(1);
#7.	Créer une fonction la somme des salaires des employés d’un département donné
delimiter $$
create function q7(id int)
returns int
reads sql data
begin
    return  (select sum(salaire)  from employe
					where ID_DEP=id);
end $$
delimiter ;
select q7(1);



#8.	Créer une fonction pour retourner le salaire minimum des employés d’un département donné
delimiter $$
create function q8(id int)
returns int
reads sql data
begin
    return  (select min(salaire)  from employe
					where ID_DEP=id);
end $$
delimiter ;
select q8(1);
#9.	Créer une fonction pour retourner le salaire maximum des employés d’un département.
delimiter $$
create function q9(id int)
returns int
reads sql data
begin
    return  (select max(salaire)  from employe
					where ID_DEP=id);
end $$
delimiter ;
select q9(1);
#10.	En utilisant les fonctions créées précédemment, Créer une requête pour afficher pour les éléments suivants : 
#a.	Le nom de département en majuscule. 
#b.	La somme des salaires du département
#c.	Le salaire minimum
#d.	Le salaire maximum

select upper(NOM_DEP) as nom_departement,
		q7(ID_DEP) as somme_salaire_departement,
        q8(ID_DEP) as minimum_salaire_departement,
        q9(ID_DEP) as maximum_salaire_departement from departement;

#11.	Créer une fonction qui accepte comme paramètres 2 chaines 
#de caractères et elle retourne les deux chaines en majuscules concaténé 
#avec un espace entre eux.
delimiter $$
create function q11(a varchar(250),b varchar(250))
returns varchar(250)
deterministic
begin
declare resultat varchar(250);
set resultat=concat(upper(a),' ',upper(b));
return resultat;
end $$
delimiter ;
select q11('samya','mansour')



