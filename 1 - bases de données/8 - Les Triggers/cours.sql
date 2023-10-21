#Les triggers - Les déclencheurs
drop database if exists gestionCommerciale_201;
create database gestionCommerciale_201 collate utf8mb4_general_ci;
use gestionCommerciale_201;

create table produit(id int auto_increment primary key,
designation varchar(50), qteStock int);

create table commande (id int auto_increment primary key,dateCommande date);

create table ligne (id_commande int not null,
id_produit int not null, qte int, prix float,
 constraint fk_ligne_produit foreign key (id_produit) references produit(id),
 constraint fk_ligne_commande foreign key (id_commande) references commande(id));
 
 insert into produit values (1,'table',30),(2,'chaise',100),(3,'pc',20);
 
 insert into commande values (1,'2023-10-1');
 
 select * from ligne;
 select * from produit;
 
 insert into ligne values (1,1,2,300);
 insert into ligne values (1,2,8,50);
 
 delete from ligne where (id_commande=1 and id_produit=2);

delimiter $$
create trigger t1 after insert on ligne for each row
begin
 update produit set qteStock = qteStock - new.qte where id = new.id_produit;
end $$
delimiter ; 
 
 
 
 delimiter $$
create trigger t2 after delete on ligne for each row
begin
 update produit set qteStock = qteStock + old.qte where id = old.id_produit;
end $$
delimiter ; 

 
 