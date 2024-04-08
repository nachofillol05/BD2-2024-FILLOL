USE sakila;

#SHOW title and special features of films that are PG-13
SELECT title,special_features FROM film
WHERE rating = 'PG-13';

#get a list of all the different films duration
select length from film group by length;

#show title, rental_rate and replacement_cost of films that have replacement_cost from 20.00 up to 24.00
SELECT title, rental_rate, replacement_cost FROM film where replacement_cost between 20.00 and 24.00;

#show title, category rating of films that have 'Behind the Scenes' as special_features
select f.title, c.name, f.rating from film_category f_c 
inner join film f on f.film_id=f_c.film_id
inner join category c on c.category_id=f_c.category_id
where f.special_features LIKE '%Behind the Scenes%';

#show first name and lastname of actors that acted in 'ZOOLANDER FICTION'
select a.first_name, a.last_name from film_actor f_a
inner join actor a on a.actor_id=f_a.actor_id
inner join film f on f.film_id=f_a.film_id
where f.title='ZOOLANDER FICTION';

#SHOW the address,city and country of the store with id 1
select a.address,ci.city,co.country from store s 
inner join address a on a.address_id=s.address_id
inner join city ci on ci.city_id=a.city_id
inner join country co on co.country_id=ci.country_id
where s.store_id=1; 

#show pair of film titles and rating of films that have the same rating
select f1.title, f2.title, f1.rating from film f1, film f2 where f1.rating = f2.rating;

#get all the films that are avaible in store id 2 and the manager first/last name of thsi store(the manager will appear in all the rows)
select f.title,sta.first_name, sta.last_name from inventory i
inner join store s on s.store_id=i.store_id
inner join staff sta on sta.staff_id = s.manager_staff_id
inner join film f on f.film_id=i.film_id
where s.store_id=2;


