/*exercice 1 :
On considère la table suivante :
Produit (NumProduit, libelle, PU, stock)
*/


drop database if exists produits_201;

create database produits_201 collate utf8mb4_general_ci;
use produits_201;

create table Produit(numProduit int auto_increment primary key,
libelle varchar(50) ,
PU float ,stock int);


insert into produit values (1,'table',350,100),
							(2,'chaise',100,10),
                            (3,'armoire',2350,10),
                            (4,'pc',3500,20),
                            (5,'clavier',150,200),
                            (6,'souris',50,200),
                            (7,'ecran',2350,70),
                            (8,'scanner',1350,5),
                            (9,'imprimante',950,5);
                            



select * from produit;

#1.	Ecrire une PS qui affiche tous les produits ;
drop procedure if exists q1 ;
delimiter $$
create procedure q1()
begin
	select*from produit;
end $$
delimiter ;
call  q1();
    

#2.	Ecrire une procédure stockée qui affiche les libellés 
#des produits dont le stock est inférieur à 10 ;

drop procedure if exists q2 ;
delimiter $$
create procedure q2()
begin
	select libelle from produit
    where stock<10;
end $$
delimiter ;
call  q2();


#3.	Ecrire une PS qui admet en paramètre un numéro de produit et affiche un message contenant le libellé, le prix et la quantité en stock équivalents, si l’utilisateur passe une valeur lors de l’exécution de la procédure ;
drop procedure if exists q3;
delimiter $$
create procedure q3(in np int)
begin
if np is null then

select 'aucun paramétre n''a été envoyé' as info;

else
	select concat("libelle : ",libelle,"prix unitaire: ",PU,"quantite en stock : ", stock) as info
    from produit 
    where numProduit=np;
end if;
end $$
delimiter ;
call  q3(877);

#4.	Ecrire une PS qui permet de supprimer un produit en passant son numéro comme paramètre ;
delimiter $$
create procedure q4(in np int)
begin
	delete from produit where numProduit=np;
end $$
delimiter ;
call q4(1);



#Exercice 2 :

#Ecrire une PS qui permet de mettre à jour le stock après une opération de vente de produits, la PS admet en paramètre le numéro d’article à vendre et la quantité à vendre puis retourne un message suivant les cas :

#a.	Opération impossible : si la quantité est supérieure au stock de l’article ;

#b.	Besoin de réapprovisionnement si stock-quantité < 10

#c.	Opération effectuée  avec succès, la nouvelle valeur du stock est (afficher la nouvelle valeur) ;

drop procedure if exists ex2;
delimiter $$
create procedure ex2(id int,nb int)
begin
	declare msg varchar(255);
	declare stockInitial int;
	select stock into stockInitial from produit where numproduit = id;
	if nb > stockInitial then 
		set msg = "Opération impossible";
	else 
		update produit set stock = stock - nb where numproduit = id;
		if (stockInitial-nb) < 10 then 
			set msg = "besoin de réprovisonnement";
		else 
			set msg = concat("Opération effectuée  avec succès, la nouvelle valeur du stock est ( ",stockInitial-nb,")");
		end if;
	end if;
	select msg;
end $$
delimiter ;


select * from produit;

call ex2(1,110);
call ex2(2,5);
call ex2(4,1);

#Exercice 3 :

#Ecrire une PS qui retourne le prix moyen des produits 
#(utiliser un paramètre OUTPUT) ; Exécuter la PS ;
drop procedure if exists ex3;
delimiter $$
	create procedure ex3(inout moyen float)
    begin 
        select moyen;		
		select avg(pu) into moyen from produit;

    end $$
delimiter ;


call ex3(@moyen);
select @moyen;

#Exercice 4 :
#Créer une procédure stockée qui accepte comme paramètre un entier et retourne le factoriel de ce nombre.
drop procedure if exists ex4;
delimiter //
create procedure ex4(in n int, out f int)
begin
	declare i int default 1;
    set f=1;
	while (i<=n) do
		set f=f*i;
		set i=i+1;
	end while;
end //
delimiter ;
call ex4(0,@f);
select @f;




#Exercice 5 :
#1.	Créer une procédure stockée qui accepte les paramètres suivants : 
#a.	 2 paramètres de type entier  
#b.	 1 paramètre de type caractère.
#c.	1 paramètre output de type entier

drop procedure if exists ex5;
delimiter $$
create procedure ex5(in n int,in m int,in o varchar(1),out res varchar(50))
begin
	case o 
        when '+' then
            set res = n + m;
        when '-' then
            set res = n - m;
        when '*' then
            set res = n * m;
        when '/' then
            set res = n / m;
        when '%' then
            set res = n % m;
        else
           set res= "operation invalid";
    end case; 
end $$
delimiter ;
call ex5(10,5,"*",@res);select @res;
call ex5(10,5,"+",@res);select @res;
call ex5(10,5,"-",@res);select @res;
call ex5(10,3,"/",@res);select @res;
call ex5(10,5,"h",@res);select @res;
call ex5(10,3,"%",@res);
select @res;

#La procédure doit enregistrer le résultat de calcul entre les deux nombres selon l’opérateur passé dans le troisième paramètre (+,-,%,/,*). 
#Exercice 6 :
#Soit la base de données suivante :
#Recettes (NumRec, NomRec, MethodePreparation, TempsPreparation)
#Ingrédients (NumIng, NomIng, PUIng, UniteMesureIng, NumFou)
#Composition_Recette (NumRec, NumIng, QteUtilisee)
#Fournisseur (NumFou, RSFou, AdrFou)
#Créer les procédures stockées suivantes :


drop database if exists cuisine_201;
create database cuisine_201;
use cuisine_201;
create table Recettes (
NumRec int auto_increment primary key, 
NomRec varchar(50), 
MethodePreparation varchar(60), 
TempsPreparation int
);
create table Fournisseur (
NumFou int auto_increment primary key, 
RSFou varchar(50), 
AdrFou varchar(100)
);
create table Ingrédients (
NumIng int auto_increment primary key,
NomIng varchar(50), 
PUIng float, 
UniteMesureIng varchar(20), 
NumFou int,
   constraint  fkIngrédientsFournisseur foreign key (NumFou) references Fournisseur(NumFou)
);
create table Composition_Recette (
NumRec int not null,
constraint  fkCompo_RecetteRecette foreign key (NumRec) references Recettes(NumRec), 
NumIng int not null ,
  constraint  fkCompo_RecetteIngrédients foreign key (NumIng) references Ingrédients(NumIng),
QteUtilisee int,
constraint  pkRecetteIngrédients primary key (NumIng,NumRec)
);

insert into Recettes  values(1,'gateau','melangeprotides' ,30),
							(2,'pizza ','melangeglucides' ,15),
							(3,'couscous','melangelipides' ,45);
insert into Fournisseur  values (1,'meditel','fes'),
								(2,'maroc telecom','casa'),
								(3,'inwi','taza');
insert into Ingrédients values(1,'Tomate', 100,'cl',1),
								(2,'ail', 200,'gr',2),
								(3,'oignon', 300,'verre',3);
							
insert into Composition_Recette values (2,1,10);
insert into Composition_Recette values (2,2,1);

#PS1 : Qui affiche la liste des ingrédients avec pour chaque ingrédient 
#le numéro, le nom et la raison sociale du fournisseur.

drop procedure PS1;
delimiter $$
create procedure PS1()
begin
select i.NumIng,i.NomIng,f.RSFou from Ingrédients i
join Fournisseur f on f.NumFou = i.NumFou;
end$$
delimiter ;

call PS1();

#PS2 : Qui affiche pour chaque recette le nombre d'ingrédients et 
#le montant cette recette
drop procedure if exists ps2;
delimiter $$
	create procedure ps2()
    begin
		select r.NomRec ,count(i.NumIng) as nombre_ingrediant , sum(i.PUIng*c.QteUtilisee) as montant
        from Recettes r 
        left join Composition_Recette c on r.NumRec=c.NumRec
        left join Ingrédients i on i.NumIng=c.NumIng
        group by r.NomRec,r.NumRec;
    end $$
delimiter ;
call ps2();


#PS3 : Qui affiche la liste des recettes qui se composent de
# plus de 10 ingrédients avec pour chaque recette le numéro et le nom
#PS3 : Qui affiche la liste des recettes qui se composent de plus de 10 ingrédients avec pour chaque recette le numéro et le nom
drop procedure if exists PS3;
delimiter $$
create procedure PS3()
begin
	select R.NumRec, R.NomRec
    from recettes R
    inner join Composition_Recette CR on R.NumRec = CR.NumRec
    group by R.NumRec, R.NomRec
    having count(CR.NumIng) >10;
end $$
call PS3;






#PS4 : Qui reçoit un numéro de recette et qui retourne son nom


drop procedure if exists PS4;
delimiter $$
create procedure PS4(in id int, out nom_rec varchar(160))
begin
    select NomRec into nom_rec
    from Recettes
    where NumRec = id;
end $$
delimiter ;
call PS4(3,@nom_rec);
select @nom_rec as 'nom recette';


#PS5 : Qui reçoit un numéro de recette. Si cette recette a au 
#moins un ingrédient, la procédure retourne son meilleur ingrédient 
#(celui qui a le montant le plus bas) sinon elle ne retourne 
#"Aucun ingrédient associé"

drop procedure if exists PS5;
delimiter $$
create procedure PS5(id int, out msg varchar(150))
begin
	declare nbIng int;
    select count(*) into nbIng from composition_recette where numRec = id;
    if nbIng=0 then
		set msg = concat('Aucun ingrédient associé à la recette numero ', id);
	else
			select concat('Le meilleur ingredient de la recette numero ',id,' est ',NomIng) into msg from composition_recette CR  join ingrédients i on cr.numing = i.numing
			where numrec = id
			order by PUIng
			limit 1;
        end if;

end $$
delimiter ;

call PS5(1,@message);
select @message;






#PS6 : Qui reçoit un numéro de recette et qui affiche la liste des ingrédients
# correspondant à cette recette avec pour chaque ingrédient le nom, la quantité
# utilisée et le montant
drop procedure if exists PS6;
delimiter $$
create procedure PS6(in idr int)
begin
    select  i.NomIng, c.QteUtilisee , (i.PUIng*c.QteUtilisee) as montant
    from Ingrédients  as i
    join Composition_Recette  as c on i.NumIng = c.NumIng
    where c.NumRec = idr;
end $$
delimiter ;
call PS6(2);


#PS7 : Qui reçoit un numéro de recette et qui affiche :
#Son nom (Procédure PS_4)
#La liste des ingrédients (procédure PS_6)
#Son meilleur ingrédient (PS_5)
drop procedure if exists ps7;
delimiter $$
create procedure ps7(in id int)
begin
    call PS4(id,@nom);
    select @nom;
    
    call PS6(id);
    
    call PS5(id, @msg);
    select @msg;
end $$
delimiter ;
call ps7(2);
#PS8 : Qui reçoit un numéro de fournisseur vérifie si ce fournisseur existe. 
#Si ce n'est pas le cas afficher le message 'Aucun fournisseur ne porte 
#ce numéro' Sinon vérifier, s'il existe des ingrédients fournis 
#par ce fournisseur si c'est le cas afficher la liste des ingrédients 
#associés (numéro et nom) Sinon afficher un message 'Ce fournisseur 
#n'a aucun ingrédient associé. Il sera supprimé' et 
#supprimer ce fournisseur
drop procedure if exists ps8;
delimiter $$
	create procedure ps8(num int)
	begin
		declare nb int;
		declare nbIng int;
		select count(*) into nb from fournisseur where numfou = num;
		if nb=0 then
			select 'Aucun fournisseur ne porte ce numéro';
		else
			select count(*) into nbIng from ingrédients where numfou = num;
			if nbIng = 0 then
				select 'ce fournisseur n''a aucun ingrédient';
				delete from fournisseur where numfou = num;
			else
				select NumIng,NomIng from ingrédients where numfou = num;
			end if;
		end if;
	end $$
delimiter ;
select * from fournisseur;
call ps8(4);
insert into fournisseur values (4,'test','test');




#PS9 : Qui affiche pour chaque recette :
#Un message sous la forme : "Recette : (Nom de la recette), temps de préparation : (Temps)
#La liste des ingrédients avec pour chaque ingrédient le nom et la quantité
#Un message sous la forme : Sa méthode de préparation est : (Méthode)
#Si le prix de reviens pour la recette est inférieur à 50 DH afficher le message
#'Prix intéressant'


