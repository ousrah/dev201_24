drop database if exists banque_201;
create database banque_201 collate utf8mb4_general_ci;
use banque_201;
create table account(
				AccountNumber varchar(50) primary key not null, 
				funds decimal(8,2), 
				check (funds>=0), 
				check (funds<=50000)
	);
    
    
insert into account values ('acc1',40000);    
insert into account values ('acc2',30000);    

select * from account;
#POUR FAIRE LE TRANSFERT IL FAUT FAIRE DEUX OPERATIONS
update account set funds = funds-10000 where AccountNumber = 'acc1';
update account set funds = funds+10000 where AccountNumber = 'acc2';

select * from account;

#POUR FAIRE LE TRANSFERT IL FAUT FAIRE DEUX OPERATIONS
update account set funds = funds-10000 where AccountNumber = 'acc1';
update account set funds = funds+10000 where AccountNumber = 'acc2';
select * from account;

#POUR FAIRE LE TRANSFERT IL FAUT FAIRE DEUX OPERATIONS
update account set funds = funds-10000 where AccountNumber = 'acc1';
update account set funds = funds+10000 where AccountNumber = 'acc2';

select * from account;


DELETE FROM ACCOUNT;

insert into account values ('acc1',40000);    
insert into account values ('acc2',30000);   

drop procedure if exists virement;
delimiter $$
create procedure virement (ac1 varchar(50), ac2 varchar(50), m decimal(8,2))
begin
	declare exit handler for sqlException
    begin
		get diagnostics condition 1 
			@sqlstate = returned_sqlstate,
            @errno = mysql_errno,
            @msg = message_text;
		rollback;
		select concat('error', @errno , ' (', @sqlstate , ') ', @msg) as msg;
	end;
    start transaction;
		update account set funds = funds-m where AccountNumber = ac1;
		update account set funds = funds+m where AccountNumber = ac2;
    commit ;
end$$
delimiter ;

select * from account;
call virement ('acc1','acc2',10000);
select * from account;
call virement ('acc1','acc2',10000);
select * from account;
call virement ('acc1','acc2',10000);
select * from account;

