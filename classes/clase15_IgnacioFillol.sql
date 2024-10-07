#Create a view named list_of_customers, it should contain the following columns:
#customer id
#customer full name,
#address
#zip code
#phone
#city
#country
#status (when active column is 1 show it as 'active', otherwise is 'inactive')
#store id
create view list_of_customers as 
select customer_id,concat(first_name, " ", last_name),a.address, a.phone,ci.city,co.country, case active when 1 then 'active' else 'inactive'end as status,store_id from customer inner join address a using(address_id) inner join city ci using(city_id) inner join country co using(country_id);

select * from list_of_customers;

#2. Create a view named film_details, it should contain the following columns: film id, title, description, category, price, length, rating, actors - 
#as a string of all the actors separated by comma. Hint use GROUP_CONCAT
drop view film_details;
create view film_details as
select f.film_id, f.title,f.description, c.name, f.rental_rate,f.`length`, f.rating, group_concat(a.first_name, " ", a.last_name) as actors from film_actor f_a inner join film_category f_c using(film_id) inner join category c using(category_id) inner join film f using(film_id) inner join actor a using(actor_id) group by film_id, c.name;
select * from film_details;

#Create view sales_by_film_category, it should return 'category' and 'total_rental' columns.
drop view sales_by_film_category;
create view sales_by_film_category as
select name, count(*) as total_rental from rental inner join inventory using(inventory_id) inner join film using(film_id)inner join film_category using(film_id)inner join category using(category_id) group by category_id;
select * from sales_by_film_category;


#Create a view called actor_information where it should return, actor id, first name, last name and the amount of films he/she acted on.
create view actor_information as
select actor_id,first_name, last_name, count(*) from film_actor inner join actor using(actor_id) group by actor_id;
select * from actor_information;

#Analyze view actor_info, explain the entire query and specially how the sub query works. Be very specific, take some time and decompose each part and give an explanation for each.
show create view actor_info;
CREATE DEFINER=CURRENT_USER SQL SECURITY INVOKER VIEW actor_info
AS
SELECT
a.actor_id,
a.first_name,
a.last_name,
GROUP_CONCAT(DISTINCT CONCAT(c.name, ': ',
		(SELECT GROUP_CONCAT(f.title ORDER BY f.title SEPARATOR ', ')
                    FROM sakila.film f
                    INNER JOIN sakila.film_category fc
                      ON f.film_id = fc.film_id
                    INNER JOIN sakila.film_actor fa
                      ON f.film_id = fa.film_id
                    WHERE fc.category_id = c.category_id
                    AND fa.actor_id = a.actor_id
                 )
             )
             ORDER BY c.name SEPARATOR '; ')
AS film_info
FROM sakila.actor a
LEFT JOIN sakila.film_actor fa
  ON a.actor_id = fa.actor_id
LEFT JOIN sakila.film_category fc
  ON fa.film_id = fc.film_id
LEFT JOIN sakila.category c
  ON fc.category_id = c.category_id
GROUP BY a.actor_id, a.first_name, a.last_name;
#Es agrupado por el id del actor, first_name, last_name; empezando desde la tabla actor haciendo un left join a la categoria y la pelicula para que tambien muestre los vacios, muestra los datos y ademas
#Muestra una concatenacion que va a decir en todas las peliculas que esta separado por categoria el distinct es para que aparezca 1 vez la pelicula por categoria y son ordenadas por orden alfabetico.Esto se hace "filtrando" esas peliculas donde la categoria sea igual a la de la pelicula
#Esto sera mostrado en el formato de la informacion y despues la categoria ":" las peliculas separadas por "," y las categorias por ";"

#Materialized views, write a description, why they are used, alternatives, DBMS were they exist, etc.
/*
Se almacenan en el disco por lo que no se tendra que ejecutar nuevamente cuando se prenda la base de datos, tampoco será actualizada cuando se modifique la tabla que utiliza. Algun caso practico podira ser
las provincias de un pais que es muy raro que cambie y siempre las tenes ahi filtradas listas para ser utilizadas. Sirve para grandes volumenes de datos o consultas con operaciones complejas
con un comando refresh pueden ser actualizadas. Ocupan espacio en el disco duro
Alternativas:Podrias usar una view normal pero esto capaz consume mas recursos como ram y procesador y tardaria mas cuando prendes la base de datos o actualizas una table,
DMBS: se puede usar este tipo de vista en mySQL, sql server,ibm db2,poostgreSQL entre otros
*/

