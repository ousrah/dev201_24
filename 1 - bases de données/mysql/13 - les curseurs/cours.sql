use vols_201;
select * from vol;
delete from vol;
select * from pilote;
select * from avion;


drop procedure if exists insertVols;
delimiter $$
create procedure insertVols(a int, vd varchar(50), va varchar(50))
begin
	declare id_pilote int;
    declare flag boolean default false;
    declare c1 cursor for select numpilote from pilote;
    declare continue handler for not found set flag = true;
    open c1;
    b1: loop
		fetch c1 into id_pilote;
        if flag then
			leave b1;
		end if;
        insert into vol values (null,vd,va,current_date(),current_date(),id_pilote,a);
    end loop b1;
    close c1;
end $$
delimiter ;

call insertVols (1,'tetouan','casa');

select * from  vol;



/*
Exercice 0
refaire l'exemple du cours.
*/

/*Exercice 1 
pour chaque pilote on souhaite ajouter un vol de sa ville de résidence à une 
ville passée en paramètre sur un avion passé en paramètre dans la date du jour.
*/
drop procedure ex1;
delimiter $$
create procedure ex1(va varchar(50),av int)
begin 
	declare idpilote int;
    declare vd varchar(50);
    declare flag boolean default false;
    declare c1 cursor for select numpilote,villepilote from pilote;
    declare continue handler for not found set flag=true;
    open c1;
		b1:loop
			fetch c1 into idpilote,vd;
			if flag then 
				leave b1;
			end if;
            insert into Vol values(null,vd,va,current_date(),current_date(),idpilote,av);
		end loop b1;
        
    close c1;
end $$
delimiter ;
use vols_201;
delete from vol;
select * from vol;
call ex1('paris',1);




/*Exercice 2
pour chaque pilote on souhaite ajouter un vol de sa ville de résidence à une 
ville passée en paramètre sur chaqune des  avions de la base de données.
utilisez deux curseurs imbriqué
*/

drop procedure ex2;
delimiter $$
create procedure ex2(va varchar(50))
begin 
	declare idpilote int;
    declare vd varchar(50);
    declare flag boolean default false;
    declare c1 cursor for select numpilote,villepilote,numav from pilote, avion;
    declare continue handler for not found set flag=true;
    open c1;
		b1:loop
			fetch c1 into idpilote,vd;
			if flag then 
				leave b1;
			end if;
            begin
					declare av int;
					declare flag2 boolean default false;
					declare c2 cursor for select  numav from avion;
					declare continue handler for not found set flag2=true;
                    open c2;
                        b2:loop
							fetch c2 into av;
                            if flag2 then
								leave b2;
                            end if;
                            insert into Vol values(null,vd,va,current_date(),current_date(),idpilote,av);
                        end loop b2;
                    close c2;
            end ;
		end loop b1;
    close c1;
end $$
delimiter ;
use vols_201;
delete from vol;
select * from vol;



select * from avion;
call ex2('madrid');

# si vous souhaitez répondre a cette question sans utilisation de curseurs imbriqués
select numpilote,villepilote,numav from pilote, avion order by numpilote, numav;


drop procedure ex2;
delimiter $$
create procedure ex2(va varchar(50))
begin
	declare av int;
	declare idpilote int;
    declare vd varchar(50);
    declare flag boolean default false;
    declare c1 cursor for select numpilote,villepilote, numav from pilote, avion;
    declare continue handler for not found set flag=true;
    open c1;
		b1:loop
			fetch c1 into idpilote,vd, av;
			if flag then 
				leave b1;
			end if;
            insert into Vol values(null,vd,va,current_date(),current_date(),idpilote,av);
		end loop b1;
        
    close c1;
end $$
delimiter ;
