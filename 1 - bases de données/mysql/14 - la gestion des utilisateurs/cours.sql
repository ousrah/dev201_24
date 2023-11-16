#La gestion des utilisateurs
drop user if exists 'khalid'@'localhost';
create user 'khalid'@'localhost' identified by '123456';
set password for khalid@localhost  = 'abcdefg';

grant all privileges on cuisine_201.* to khalid@localhost;
revoke all privileges on cuisine_201.* from khalid@localhost;

show grants for khalid@localhost;

grant select on cuisine_201.recettes to khalid@localhost;

grant insert on cuisine_201.recettes to khalid@localhost;

grant select, insert, update, delete on cuisine_201.recettes to khalid@localhost;

use cuisine_201;
select * from ingrédients;
grant select(numing, noming, unitemesureing) on cuisine_201.ingrédients to khalid@localhost;

grant alter on cuisine_201.recettes to khalid@localhost;
flush privileges;

grant create routine  on cuisine_201.* to  khalid@localhost;


#La gestion des groupes (roles)
drop user if exists u1@localhost;
drop user if exists u2@localhost;
drop user if exists u3@localhost;

create user u1@localhost identified by '123456';
create user u2@localhost identified by '123456';
create user u3@localhost identified by '123456';

set default role all to u1@localhost;


drop role if exists lecture@localhost;
drop role if exists edition@localhost;


create role lecture@localhost;
create role edition@localhost;

grant select on cuisine_201.* to lecture@localhost;
grant select, update, delete, insert on cuisine_201.* to edition@localhost;

grant lecture@localhost to u1@localhost;
grant edition@localhost to u1@localhost;

show grants for u1@localhost;
show grants for u1@localhost using lecture@localhost,  edition@localhost ;


revoke delete on cuisine_201.recettes from u1@localhost;



flush privileges;


