#La gestion des exceptions
drop database if exists dev201_204;
create database dev201_204;
use dev201_204;
drop table if exists test;
create table test (id int auto_increment primary key, nom varchar(50) not null unique);
insert into test(nom) values ('iam');
insert into test(nom) values (null);
insert into test(nom) values ('iam');
drop procedure if exists insert_test;
delimiter $$
create procedure insert_test(v_name text)
begin
	declare exit handler for 1048 select "le nom ne peut pas être null";
	declare exit handler for 1062 select "Ce nom existe déjà";
	declare exit handler for 1406 select "Les données sont trop longs";

	insert into test(nom) values (v_name);
	select "opération effectuée avec succès";
end $$
delimiter ;

call insert_test(55);
call insert_test(null);


call insert_test('inwi lkmqsjdf lmqsjnd fgmoqsh dlkqjsh dfmlkqsihd fmqlskd fjmlqkjs dfmlqsj dfmlkqsj dfmlqsj dflkqjs dmfljk qsmdfj q');




drop procedure if exists insert_test;
delimiter $$
create procedure insert_test(v_name text)
begin
	declare flag boolean default false;
	begin
		declare exit handler for 1048 set flag = true;
		declare exit handler for 1062 set flag = true;
		declare exit handler for 1406 set flag = true;
		insert into test(nom) values (v_name);
		select "opération effectuée avec succès";
    end;
    if flag then
		select "erreur d'insertion de données";
    end if;
end $$
delimiter ;



call insert_test(55);
call insert_test(null);


call insert_test('inwi lkmqsjdf lmqsjnd fgmoqsh dlkqjsh dfmlkqsihd fmqlskd fjmlqkjs dfmlqsj dfmlkqsj dfmlqsj dflkqjs dmfljk qsmdfj q');
call insert_test('bien');



drop procedure if exists insert_test;
delimiter $$
create procedure insert_test(v_name text)
begin
	declare message varchar(200) default "";
	begin
		declare exit handler for 1048 set message = "le nom ne peut pas être null";
		declare exit handler for 1062 set message = "ce nom existe déjà";
		declare exit handler for 1406 set message = "le nom est trop long";
		insert into test(nom) values (v_name);
		select "opération effectuée avec succès";
    end;
    if message!="" then
		select message;
    end if;
end $$
delimiter ;


call insert_test(55);
call insert_test(null);
call insert_test('inwi lkmqsjdf lmqsjnd fgmoqsh dlkqjsh dfmlkqsihd fmqlskd fjmlqkjs dfmlqsj dfmlkqsj dfmlqsj dflkqjs dmfljk qsmdfj q');
call insert_test('ok');




drop procedure if exists insert_test;
delimiter $$
create procedure insert_test(v_name text)
begin
	declare flag boolean default false;
    declare v_errno int;
    declare v_msg varchar(255);
    declare v_sqlstate varchar(5);
	begin
		declare exit handler for sqlexception
					begin
						get diagnostics condition 1
							v_sqlstate = returned_sqlstate,
                            v_errno = mysql_errno,
                            v_msg = message_text;
						set flag = true;
					end;
		insert into test(nom) values (v_name);
		select "opération effectuée avec succès";
    end;
    if flag then
		#select concat (v_errno, ' -  ',v_msg, ' - ' , v_sqlstate);
        case v_errno
        when 1048 then select "le nom ne peut pas être null";
        when 1062 then select "ce nom exist deja";
     #   when 1406 then select "le nom est trop long";
        else
			select v_msg;
        end case;
    end if;
end $$
delimiter ;

call insert_test(55);
call insert_test(null);
call insert_test('inwi lkmqsjdf lmqsjnd fgmoqsh dlkqjsh dfmlkqsihd fmqlskd fjmlqkjs dfmlqsj dfmlkqsj dfmlqsj dflkqjs dmfljk qsmdfj q');
call insert_test(54);

drop procedure if exists get_name_by_id;
delimiter $$
create procedure get_name_by_id(v_id int, out v_name varchar(50))
begin
	declare flag boolean default false;
    declare v_errno int;
    declare v_msg varchar(255);
    declare v_sqlstate varchar(5);
	begin
		declare exit handler for not found #sqlexception
					begin
						get diagnostics condition 1
							v_sqlstate = returned_sqlstate,
                            v_errno = mysql_errno,
                            v_msg = message_text;
						set flag = true;
					end;
                    #set msg = "introuvabl"
		select nom into v_name from test where id = v_id;
    end;
    if flag then
		select concat(v_errno, ' ', v_msg,' ', v_sqlstate);
    end if;
	
end$$
delimiter ;

call get_name_by_id(100,@n);
select @n;

select nom into @n from test where id = 100;




drop procedure if exists set_text;
delimiter $$
create procedure set_text (txt varchar(50))
begin
	declare var int;
	set var = txt;
end $$
delimiter ;


call set_text("55");

call set_text("ab");

drop procedure if exists set_text;
delimiter $$
create procedure set_text (txt varchar(50))
begin
	declare var int;
    declare exit handler for 1366 select "erreur de conversion";
	set var = txt;
    select var;
end $$
delimiter ;


call set_text("55");

call set_text("ab");



drop procedure if exists set_text;
delimiter $$
create procedure set_text (txt varchar(50))
begin
	declare var int;
    declare flag boolean default false;
    declare v_errno int;
    declare v_msg varchar(255);
    declare v_sqlstate varchar(5);
	begin
		declare exit handler for sqlexception
					begin
						get diagnostics condition 1
							v_sqlstate = returned_sqlstate,
                            v_errno = mysql_errno,
                            v_msg = message_text;
						set flag = true;
					end;
        	set var = txt;
			select var;

    end;
    if flag then
		select concat(v_errno, ' ', v_msg,' ', v_sqlstate);
    end if;
	
    
end $$
delimiter ;


call set_text("55");

call set_text("ab");




drop procedure if exists set_text;
delimiter $$
create procedure set_text (txt varchar(50))
begin
	declare var int;
	begin
		declare exit handler for sqlstate 'HY000' select "erreur de conversion";
		set var = "ab";
		select var;
    end;
end $$
delimiter ;


call set_text("55");

call set_text("ab");




drop procedure if exists divide;
delimiter $$
create procedure divide(a float, b float)
begin
	declare r float;
	if b=0 then
		signal sqlstate '23000' set mysql_errno=10000, me = "blablabla";
    
    end if;
 
	set r = a/b;
    select r;
end $$
delimiter ;

call divide(3,0);


#Les transactions




#Les curseurs