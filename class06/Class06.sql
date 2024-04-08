use sakila;

#List all the actors that share the last name. Show them in order
SELECT first_name,last_name FROM customer c1 
 WHERE EXISTS (
	SELECT * FROM customer c2 
		WHERE c1.last_name = c2.last_name AND c1.customer_id != c2.customer_id
			)ORDER BY c1.last_name;
            
#Find actors that don't work in any film
SELECT ac.first_name, ac.last_name FROM film_actor fi_ac
inner join actor ac on ac.actor_id = fi_ac.actor_id
where NOT EXISTS(select * from actor ac2 where ac.actor_id = ac2.actor_id);
		
#Find customers that rented only one 
select c.first_name,c.last_name,count(r.customer_id) as cant_compras from rental r 
inner join customer c on c.customer_id=r.customer_id
group by r.customer_id having 1=count(r.customer_id);

#Find customers that rented more than one film
select c.first_name,c.last_name,count(r.customer_id) as cant_compras from rental r 
inner join customer c on c.customer_id=r.customer_id
group by r.customer_id having 1<count(r.customer_id);

#List the actors that acted in 'BETRAYED REAR' or in 'CATCH AMISTAD'
SELECT ac.first_name, ac.last_name FROM film_actor fi_ac
inner join actor ac on ac.actor_id = fi_ac.actor_id
inner join film f on f.film_id=fi_ac.film_id
where f.title in ('BETRAYED REAR','CATCH AMISTAD')  group by ac.actor_id;

#List the actors that acted in 'BETRAYED REAR' but not in 'CATCH AMISTAD'
SELECT ac.first_name, ac.last_name 
FROM film_actor fi_ac
INNER JOIN actor ac ON ac.actor_id = fi_ac.actor_id
INNER JOIN film f ON f.film_id = fi_ac.film_id
WHERE f.title = 'BETRAYED REAR'
AND ac.actor_id not IN (
    SELECT actor_id 
    FROM film_actor fa
    INNER JOIN film fi ON fi.film_id = fa.film_id
    WHERE fi.title='CATCH AMISTAD'
);

#List the actors that acted in both 'BETRAYED REAR' and 'CATCH AMISTAD'
SELECT ac.first_name, ac.last_name 
FROM film_actor fi_ac
INNER JOIN actor ac ON ac.actor_id = fi_ac.actor_id
INNER JOIN film f ON f.film_id = fi_ac.film_id
WHERE f.title = 'BETRAYED REAR'
AND ac.actor_id IN (
    SELECT actor_id 
    FROM film_actor fa
    INNER JOIN film fi ON fi.film_id = fa.film_id
    WHERE fi.title='CATCH AMISTAD'
);

#List all the actors that didn't work in 'BETRAYED REAR' or 'CATCH AMISTAD'
select a.first_name, a.last_name
from actor a
where a.actor_id not in (
  select f_a.actor_id from film_actor f_a
  inner join film f on f_a.film_id = f.film_id
  where f.title like '%BETRAYED REAR%'
)
and a.actor_id not in (
  select f_a.actor_id from film_actor f_a
  inner join film f on f_a.film_id = f.film_id
  where f.title like '%CATCH AMISTAD%'
);