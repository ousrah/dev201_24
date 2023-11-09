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