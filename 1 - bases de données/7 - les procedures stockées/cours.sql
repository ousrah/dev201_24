
 #Les procédures stockées
 
 
 use employes_201;
 
 select * from departement where id_dep = 1;
 select * from employe where id_dep=1;
 
 
delimiter $$
create procedure exemple1()
	begin
	 select * from departement where id_dep = 1;
	 select * from employe where id_dep=1;
	end $$
delimiter ;
 
call exemple1;
 
 
 delimiter $$
 create procedure exemple2(n int)
 begin
 	 select * from departement where id_dep = n;
	 select * from employe where id_dep=n;
  end $$
 delimiter ;
  
 call exemple2(3);
 
 
 
 
 delimiter $$
 create procedure exemple3( in n int)
 begin
 	 select * from departement where id_dep = n;
	 select * from employe where id_dep=n;
  end $$
 delimiter ;
 
 
 call exemple3(3);
 
 drop procedure if exists exemple4;
 
 delimiter $$
 create procedure exemple4( in n int, out nb int)
 begin
 	 select * from departement where id_dep = n;
	 select * from employe where id_dep=n;
     select count(*) into nb from employe where id_dep=n;
  end $$
 delimiter ;
 
 call exemple4(3,@nb);
 select @nb;
 
 
 
 #Les views
 
 #Les tables temporaires
  
 # Les triggers (les déclencheurs)
  
 #Les transactions
 
 #Les cursseurs
 
 #La gestion des erreurs
 
 #La sécurité
 
 #La sauvegarde et la resauration des données