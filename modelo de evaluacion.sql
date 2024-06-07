#Obtener los pares de apellidos de actores que comparten nombres, considerando solo los actores cuyo nombre comienza con una vocal. Mostrar el nombre, los 2
#apellidos y las películas que comparten.

SELECT 
    actor1.first_name,
    actor1.last_name,
    actor2.last_name,
    (
         SELECT GROUP_CONCAT(DISTINCT f.title SEPARATOR ', ')
        from film_actor fa
        inner join film_actor fa2 on fa.film_id = fa2.film_id
        inner join film f on fa.film_id=f.film_id
        where fa.actor_id=actor1.actor_id
        and fa2.actor_id=actor2.actor_id
    ) AS peliculas_compartidas
FROM 
    (SELECT * FROM actor WHERE first_name LIKE 'A%' OR first_name LIKE 'E%' OR first_name LIKE 'I%' OR first_name LIKE 'O%' OR first_name LIKE 'U%') actor1
INNER JOIN 
    actor actor2 ON actor1.first_name = actor2.first_name
WHERE 
    actor1.actor_id < actor2.actor_id
ORDER BY 
    actor1.first_name, actor2.first_name;


#Mostrar aquellas películas cuya cantidad de actores sea mayor al promedio de actores por películas. Además, mostrar su cantidad de actores y una lista de los
#nombres de esos actores.

select f.title, count(*) as cant_actores,group_concat(distinct concat(a.first_name, ' ', a.last_name) separator ', ') as actores from film_actor fa
inner join film f using(film_id)
inner join actor a using(actor_id)
group by f.title
having cant_actores > 
(select avg(cantidad_actores) from (select count(*) as cantidad_actores from film_actor inner join film f using(film_id) group by f.title) actorxfilm);

#Generar un informe por empleado mostrando el local, la cantidad y sumatoria de sus ventas, su venta máxima, mínima, cuantas veces se repite la venta máxima y la
#mínima, además mostrar en una columna una concatenación de todos los alquileres mostrando el título de la película alquilada y el monto pagado. Considerar sólo los
#datos del año actual.

select sta1.first_name, sto.store_id, count(r.rental_id) as cant_ventas, sum(p.amount) as sum_ventas, max(p.amount) as max_venta, min(p.amount) as min_venta,
(select count(*) from staff sta inner join payment p using(staff_id) where year(p.payment_date) > 2005 and amount=(select max(amount) from payment p where staff_id=sta.staff_id and year(p.payment_date) > 2005 group by staff_id) and staff_id =sta1.staff_id) as cant_maximos,
(select count(*) from staff sta inner join payment p using(staff_id) where year(p.payment_date) > 2005 and amount=(select min(amount) from payment p where staff_id=sta.staff_id and year(p.payment_date) > 2005 group by staff_id) and staff_id =sta1.staff_id) as cant_minimos,
group_concat(distinct p.amount, f.title separator ', ')
from staff sta1
inner join payment p using(staff_id)
inner join store sto using(store_id)
inner join rental r on r.rental_id = p.rental_id
inner join inventory i on i.inventory_id=r.inventory_id
inner join film f using(film_id)
where year(p.payment_date) > 2005
group by sta1.staff_id;
select payment_id,staff_id,amount from payment where amount=0.00 and payment_date>2005;
