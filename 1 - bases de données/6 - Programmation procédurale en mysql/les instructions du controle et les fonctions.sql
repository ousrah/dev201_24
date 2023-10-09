 #Le bloc d'instruction

 
 drop function if exists hello;
 delimiter $$
	 create function hello()
	 returns varchar(50)
     deterministic #NO SQL  reads sql data
	 begin
		return "hello world";
	 end $$
 delimiter ;
 
 
 select hello();
 
 
 
 drop function if exists somme;
 delimiter $$
	 create function somme(a int, b int)
	 returns int
     deterministic 
	 begin
		return a+b;
	 end $$
 delimiter ;
 
 select somme(3,5);
 
 select 3+5;
 #Les instructions de controle
 
	 #La déclaration
	 
	 #L'affectation
	 
     
     drop function if exists somme;
 delimiter $$
	 create function somme(a int, b int)
	 returns int
     deterministic 
	 begin
		declare c int default 0; #declaration et initialisation
        #set c = a+b;  #affectation avec set
        #select a+b into c; #affectation avec select
        set c=a+b; #set est préférable
		return c;
	 end $$
 delimiter ;
     
     
     select somme(3,5);
     
     
	 #L'affichage
	
     
	 #Les conditions
	#syntaxe générale
    #if condition then
    
    #elseif condition then
    
    #else
    
    #end if
    
    
    drop function if exists comparaison;
    delimiter $$
    create function comparaison(a int, b int)
    returns varchar(50)
    deterministic
    begin
		declare result varchar(50) default "";
		if (a<b) then
			set result = concat(a, " est plus petite que ", b);
		elseif (a=b) then
			set result = concat(a, " et ", b, " sont égaux");
		else
			set result = concat(a, " est plus grande que ", b);
        end if;
        return result;
    end $$
    delimiter ;
    
    
    select comparaison (13,13);
    
    
    drop function if exists jour;
    delimiter $$
    create function jour(j int)
    returns varchar(50)
    deterministic
    begin
		declare jourSemaine varchar(50) default "";
        set jourSemaine = case j
        when 1 then "Dimanche"
        when 2 then "Lundi"
        when 3 then "Mardi"
        when 4 then "Mercredi"
        when 5 then "Jeudi"
        when 6 then "Vendredi"
        when 7 then "Samedi"
        else "erreur"
        end;
		return jourSemaine;
    end $$
    delimiter ;
    
    
    
    drop function if exists jour;
    delimiter $$
    create function jour(j int)
    returns varchar(50)
    deterministic
    begin
		declare jourSemaine varchar(50) default "";
        set jourSemaine = case 
        when j=1 then "Dimanche"
        when j=2 then "Lundi"
        when j=3 then "Mardi"
        when j=4 then "Mercredi"
        when j=5 then "Jeudi"
        when j=6 then "Vendredi"
        when j=7 then "Samedi"
        else "erreur"
        end;
		return jourSemaine;
    end $$
    delimiter ;
    
    
    
    select jour(3);
    select jour(8);
 
 #equation premier degrès
 #Ax+B=0
 #a=0 b=0 => R
 #a=0 b!=0 => ensemble vide
 #a!=0 => -b/a
 
 
 drop function if exists equation;
 delimiter $$
	create function equation(a float , b float)
    returns varchar(50)
    deterministic
    begin
		declare x varchar(50) default "";
        if (a=0) then 
			if (b=0) then
				set x="admet une solution dans r";
			else
				set x="l'equation n'admet pas de solution";
			end if;
		else	
			set x=concat("la solution est ", -b/a);
		end if;
        return x;
	end $$;
delimiter ;
select equation(0,5); #  0x+5=0     5 comparaisons   2    2
select equation(3,5); # 3x+5=0      5 comparaisons  2     1
select equation(3,0); # 3x+0=0      3 comparaisons  2     1
select equation(0,0); # 0x+0=0      2 comparaisons  2    2

#Equation deuxième degrès
#Ax²+Bx+C=0

#A=0 b=0 c=0  => R
#a=0 b=0 c!=0  => ensemble vide
#a=0 b!=0   =>   -c/b
#a!=0   
#   delta=pow(b,2)-4ac #(b*b)-(4*a*c)
#   delta<0 => impossible dans R
#   delta =0 => x1=x2=-b/(2*a)
#   delta>0 =>  x1 = (-b-sqrt(delta))/(2*a)   x1 = (-b+sqrt(delta))/(2*a)
   

#---------------------------------------------------------------------------------------
drop function  if exists equation2;
delimiter &&
create function equation2(a int , b int , c int )
returns  varchar(50)
deterministic 
begin
	declare x varchar(50) default "";
    declare delta int default 0;
	declare x1 int default 0;
	declare x2 int default 0;
    
    if (a=0) then
		if (b=0) then
			if (c=0) then
				set x="l'equation admet une solution dans R";
			else
				set x="ensemble vide"; 
			end if;
        else
			set x= -c/b; 
        end if;
	else
		set delta= pow(b,2)-4*a*c ;
         if(delta<0) then 
			set x="impossible";
         elseif(delta=0) then 
            set x=concat("la solution est: x1=x2=",-b/(2*a));
         else 
			set x1=(-b-sqrt(delta))/(2*a) ;
			set x2=(-b+sqrt(delta))/(2*a);
			set x=concat("la solution est",x1,",",x2);
		end if;
    end if;
    return x;
end &&
delimiter ;

select equation2(0,0,0);
select equation2(0,0,2);
select equation2(0,5,5);
select equation2(2,4,2);
select equation2(2,56,10);
select equation2(2,56,10);



    
	 #Les boucles
 
 
 #Les fonctions
 
 
 
 
 
 
 
 
 #Les procédures stockées
 
 #Les views
 
 #Les tables temporaires
  
 # Les triggers (les déclencheurs)
  
 #Les transactions
 
 #Les cursseurs
 
 #La gestion des erreurs
 
 #La sécurité