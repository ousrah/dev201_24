
select ceiling(rand()*25);

#1.	La liste des biens de type ‘villa’
#methode 1
select *
from bien B join type T on B.id_type= T.id
where nom = 'villa' ;
#methode 2
select * 
from bien 
where id_type in (select id 
				 from type 
                 where nom="villa");


#2.	La liste des appartements qui se trouvent à Tétouan
#methode 1
select b.* from bien b 
join type t on b.id_type=t.id 
join quartier q on q.id=b.id_quartier
join ville v on v.id=q.id_ville
where t.nom="appartement" and v.nom="tetouan";

#methode 2
select * from bien
where id_quartier in (select id from quartier 
            where id_ville in (select id from ville 
							where nom="Tetouan"))
and id_type in (select id from type 
                 where nom="Appartement");
            
#methode 3 (juste pour voir les possibilité)
select * from bien
where id_quartier in (select distinct q.id 
						from quartier q join ville v on q.id_ville = v.id
							where v.nom="Tetouan")
and id_type in (select id from type 
                 where nom="Appartement");



#3.	La liste des appartements loués par M. Marchoud Ali
	# quels sont les biens de type appartement qui on un 
	#contrat avec le client dont le nom est marchoud et le prénom est ali

#methode 1
select * from contrat c
join client clt on c.id_client=clt.id
join bien b on b.reference=c.reference
join type t on t.id=b.id_type
where t.nom="appartement" and clt.nom="marchoud" and clt.prenom="ali";

#methode2
select * from bien 
where id_type in (select id from type 
				where nom = 'appartement')
and reference in (select reference from contrat 
				where id_client in (select id from client
									where nom = 'marchoud' and prenom='ali')
				);

#4.	Le nombre des appartements loués dans le mois en cours

select count(*) nb
from contrat c join bien b on c.reference=b.reference
join type t on B.id_type= T.id
where month((date_creation))=month(current_date() ) and year((date_creation))=year(current_date() ) and t.nom="appartement"; 


#5.	Les appartements disponibles actuellement à 
#Martil dont le loyer est inférieur à 2000 DH 
#triés du moins chère au plus chère

select * from bien where reference not in (
select distinct reference from contrat 
where date_entree <=curdate() 
and ( date_sortie>curdate() or date_sortie is null)
)
and id_type in (select id from type where nom = 'appartement')
and id_quartier in (select id from quartier where id_ville in (select id from ville where nom = 'martil'))
and loyer <2000
order by loyer asc;
#6.	La liste des biens qui n’ont jamais été loués

#methode 1
select * from bien 
	where reference not in (select distinct reference from contrat);

#methode2
select * from bien 
 left join contrat on bien.reference = contrat.reference
where contrat.reference is null;

#7.	La somme des loyers du mois en cours
select sum(loyer), concat(month(date_creation),'-',year(date_creation))
from contrat
where concat(month(date_creation),'-',year(date_creation))
=
concat(month(current_date() ),'-', year(current_date())) 
group by concat(month(date_creation),'-',year(date_creation)); 