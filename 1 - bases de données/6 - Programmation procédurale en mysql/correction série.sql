use librairie_201;
drop function if exists dateff;
delimiter &&
create function dateff( dateP varchar(50))
returns varchar(50)
deterministic
begin
    return date_format(str_to_date(dateP,"%d/%m/%Y"),"%d %M %Y");
end &&
delimiter ;


drop function if exists dateff;
delimiter &&
create function dateff( dateP varchar(50))
returns varchar(50)
deterministic
begin
 declare day int default day(str_to_date(dateP,"%d/%m/%Y"));
 declare year int default year(str_to_date(dateP,"%d/%m/%Y"));
 declare month int default month(str_to_date(dateP,"%d/%m/%Y"));
 declare name varchar(50) default case month
 when 1 then ' Janvier '
 when 2 then ' Favrier '
 when 3 then ' Mars '
 when 4 then ' Avril '
 when 5 then ' Mai '
 when 6 then ' Juin '
 when 7 then ' Juillet '
 when 8 then ' Aout '
 when 9 then ' Septembre '
 when 10 then ' Octobre '
 when 11 then ' Novembre '
 when 12 then ' Decembre '
  
 end;
    return concat (day, name, year);
end &&
delimiter ;


select dateff("12/01/2011 ") as date;

#exercice2

drop function if exists CalculerEcartEntreDates;
DELIMITER $$

CREATE FUNCTION CalculerEcartEntreDates(date1 DATETIME, date2 DATETIME, unite VARCHAR(10))
RETURNS varchar(50)
deterministic
BEGIN
    DECLARE ecart varchar(50);
     
    IF unite = 'jour' THEN
        SET ecart = TIMESTAMPDIFF(day, date1, date2);
    ELSEIF unite = 'mois' THEN
        SET ecart = TIMESTAMPDIFF(month, date1, date2);
    ELSEIF unite = 'annee' THEN
        SET ecart = TIMESTAMPDIFF(year, date1, date2);
    ELSEIF unite = 'heure' THEN
        SET ecart = TIMESTAMPDIFF(HOUR, date1, date2);
    ELSEIF unite = 'minute' THEN
        SET ecart = TIMESTAMPDIFF(MINUTE, date1, date2);
    ELSEIF unite = 'seconde' THEN
        SET ecart = TIMESTAMPDIFF(SECOND, date1, date2);
    ELSE
        SET ecart = "erreur"; 
    END IF;

    RETURN ecart;
END $$

DELIMITER ;

select CalculerEcartEntreDates("1999-8-7","1999-9-10","mois");

select if(1=0,"egale",if(2=3,"deux","trois"));




