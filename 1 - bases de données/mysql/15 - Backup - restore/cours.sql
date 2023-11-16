#sauvegarde
dans la ligne de commande
c:\>mysqldump -h locahost -P 3308 -u root -p cuisine_203 > d:\savecuisine.sql
password: 123456


#restauration
#methode 1
mysql -h locahost -P 3308 -u root -p 
password: 123456

mysql> create database cuisineresto collate utf8mb4_general_ci;
mysql> use cuisineresto;
mysql> source  d:\savecuisine.sql

#methode2
dans mysql :
mysql> create database cuisineresto2 collate utf8mb4_general_ci;

dans la ligne de commande 
c:\>mysql -h localhost -P 3308 -u root -p cuisineresto2 <  d:\savecuisine.sql;

