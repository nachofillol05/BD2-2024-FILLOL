use sakila;
#Find all the film titles that are not in the inventory.
select * from film f where not f.film_id in(select film_id from inventory);
select i.inventory_id, f.* from film f left outer join inventory i using(film_id) where i.inventory_id is null;

#Find all the films that are in the inventory but were never rented. Show title and inventory_id. This exercise is complicated. 
#hint: use sub-queries in FROM and in WHERE or use left join and ask if one of the fields is null
select f.title, i.inventory_id from film f
inner join inventory i using(film_id)
left outer join rental r using(inventory_id)
where r.rental_id is null;

#Generate a report with: customer (first, last) name, store id, film title, when the film was rented and returned for each of these customers .
#order by store_id, customer last_name
select concat(c.first_name, " ",c.last_name) as complete_name, s.store_id, f.title from rental r
inner join customer c using(customer_id)
inner join store s using(store_id)
inner join inventory i using(inventory_id)
inner join film f using(film_id)
where r.return_date is not null;

#Show sales per store (money of rented films). show store's city, country, manager info and total sales (money)
#(optional) Use concat to show city and country and manager first and last name
select s1.store_id AS 'Tienda',
CONCAT(co.country, ', ', ci.city) AS 'Location', CONCAT(sta.first_name, ' ', sta.last_name) AS 'Manager',
concat("$",(select sum(p.amount) from rental 
inner join inventory using(inventory_id) 
inner join store s2 using(store_id) 
inner join payment p using(rental_id) 
where s1.store_id=s2.store_id)) as total_sales
from store s1
inner join address using(address_id)
inner join city ci using(city_id)
inner join country co using(country_id)
inner join staff sta on sta.staff_id = s1.manager_staff_id;

#Which actor has appeared in the most films?
select a1.*, count(f_a.film_id) as cantidad from actor a1
inner join film_actor f_a using(actor_id)
inner join film f using(film_id)
group by a1.actor_id
having cantidad > all (
select count(fa.film_id) as cant_films from actor a2
inner join film_actor fa ON a2.actor_id = fa.actor_id 
where a2.actor_id != a1.actor_id
group by a2.actor_id );

