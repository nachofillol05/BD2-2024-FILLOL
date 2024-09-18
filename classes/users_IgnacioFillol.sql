create user 'data_analyst'@'localhost' identified by 'password';
#Grant permissions only to SELECT, UPDATE and DELETE to all sakila tables to it.
use sakila;
grant select,update, delete on sakila.* to 'data_analyst'@'localhost';
SHOW GRANTS FOR data_analyst@localhost;
#Login with this user and try to create a table. Show the result of that operation.
/*mysql> create table tabla(
    -> numero int not null,
    -> nombre varchar(55),
    -> primary key(idtipodocumento)
    -> ) engine=INNODB;
ERROR 1142 (42000): CREATE command denied to user 'data_analyst'@'localhost' for table 'tabla'*/

#Try to update a title of a film. Write the update script.
/*mysql> UPDATE film
    -> SET title = 'New Movie Title', 
    ->     rental_rate = 3.99         
    -> WHERE film_id = 1;     */
#Query OK, 1 row affected (0,07 sec) Rows matched: 1  Changed: 1  Warnings: 0   

#With root or any admin user revoke the UPDATE permission. Write the command
revoke UPDATE on sakila.* from data_analyst@localhost;    

#Login again with data_analyst and try again the update done in step 4. Show the result.
/*mysql> UPDATE film
    -> SET title = 'New Movie Title', -- Cambiamos el título
    ->     rental_rate = 3.99         -- Cambiamos la tarifa de alquiler
    -> WHERE film_id = 1; 
ERROR 1142 (42000): UPDATE command denied to user 'data_analyst'@'localhost' for table 'film*/
