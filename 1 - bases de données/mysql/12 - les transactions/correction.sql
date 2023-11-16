drop DATABASE if EXISTS gestion_Chaises_201;
CREATE DATABASE if not EXISTS gestion_Chaises_201;
use gestion_Chaises_201;

CREATE TABLE if NOT EXISTS Salle (
	NumSalle int AUTO_INCREMENT PRIMARY key ,
	Etage int,
	NombreChaises int ,
    CONSTRAINT check_nb CHECK (NombreChaises>=20 and NombreChaises<=30 ) #between
    );
    
CREATE TABLE if NOT EXISTS Transfert (
	NumSalleOrigine int ,
	NumSalleDestination int ,
	DateTransfert DATEtime DEFAULT CURRENT_TIMESTAMP ,
	NbChaisesTransferees int ,
    PRIMARY key(NumSalleOrigine,NumSalleDestination,DateTransfert),
    FOREIGN KEY (NumSalleOrigine) references Salle(NumSalle),
	FOREIGN KEY (NumSalleDestination) references Salle(NumSalle)
    );
    
insert into salle values (1,1,24), (2,1,26),(3,1,26),(4,2,28);

drop procedure if exists q4;
delimiter $$
create procedure q4(SalleOrigine int ,SalleDest int,NbChaises int ,dateTransfert date)
begin
	declare exit handler for sqlexception
    begin
		rollback; #pour annuler 1ere update lorsque la 2eme n'effectue pas
        select 'Impossible d’effectuer le transfert des chaises'  ;
    end;
    start transaction ;
		update salle set NombreChaises=NombreChaises-NbChaises where NumSalle=SalleOrigine;
        update salle set NombreChaises=NombreChaises+NbChaises where NumSalle=SalleDest;
        insert into transfert values(SalleOrigine,SalleDest,dateTransfert,NbChaises);
        
    commit;
end $$
delimiter ;
select * from salle;
call q4(2,3,4,current_date());
select * from transfert;
delete from transfert;
    
    