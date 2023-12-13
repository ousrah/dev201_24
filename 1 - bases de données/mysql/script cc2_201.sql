drop database if exists cc2_201;
create database cc2_201;
use cc2_201;

create table chauffeur(
	code_ch varchar(10) primary key,
    nom_ch varchar(30),
    pre_ch varchar(30),
    date_ch date,
    ad_ch varchar(80),
    cp_ch varchar(5),
    ville_ch varchar(40),
    tel_ch varchar(15)
	);
    
       
create table type(
	type  varchar(10) primary key, 
    lib_type varchar(30)
    );
   
   create table hangar( 
	num_hg varchar(10) primary key , 
	nb_places int,  
    garde boolean);
  
  
create table vehicule(
	immat  varchar(10) primary key, 
	marque varchar(5), 
    ref varchar(5), 
    puis int,
    poids float,
    equip varchar(30),
    cout_km float,
    type varchar(10),
    num_hg varchar(10),
    constraint fk_vehicule_type foreign key(type) references type(type),
    constraint fk_vehicule_hangar foreign key(num_hg) references hangar(num_hg)

	);
 
      
create table permis(
	code_per  varchar(5) primary key, 
    lib_per varchar(30)
    );
 
   
create table obtenir( 
	code_per varchar(5) , 
	code_ch varchar(10),  
    date_ob date,
	constraint fk_obtenir_permis foreign key(code_per) references permis(code_per), 
    constraint fk_obtenir_chauffeur foreign key(code_ch) references chauffeur(code_ch)
    );
    
create table date_util(
	date_util date primary key 
		);
   
   create table utiliser( 
	date_util date , 
    code_ch varchar(10),
    immat varchar(10),
	km_deb int,
    km_fin int,
	constraint fk_utiliser_date_util foreign key(date_util) references date_util(date_util), 
	constraint fk_utiliser_chauffeur foreign key(code_ch) references chauffeur(code_ch), 
    constraint fk_utiliser_vehicule foreign key(immat) references vehicule(immat)
    );
    
    
    



insert into permis values (1,'A'),(2,'B'),(3,'C');
insert into hangar values (1,100,true),(2,50,true),(3,200,false);
insert into type values (1,'citadine'),(2,'utilitaire'),(3,'camion');
insert into date_util values ('2023-12-11'),('2023-12-12'),('2023-12-13');
insert into chauffeur values (1,'ch1','ch1','2022-01-01','ad1',20000,'tetouan','06212154');
insert into chauffeur values (2,'ch2','ch2','2021-01-01','ad2',30000,'martil','06212155');
insert into chauffeur values (3,'ch3','ch3','2020-01-01','ad3',40000,'tanger','06212156');

insert into vehicule values ('B1','pg','a1',1,2,'a1',15421,1,1);
insert into vehicule values ('B2','rn','a2',1,2,'a2',80000,2,2);
insert into vehicule values ('B3','mr','a3',1,2,'a3',500,3,3);


insert into obtenir values (1,1,'2019-11-15'),(2,2,'2019-11-19'),(3,3,'2019-11-16');

insert into utiliser values ('2023-12-11',1,'B1',1000,2000),('2023-12-12',1,'B2',3000,4000),('2023-12-13',1,'B3',5000,6000);
