#Add a new customer
#To store 1
#For address use an existing address. The one that has the biggest address_id in 'United States'
use sakila;

insert into customer(store_id,address_id, first_name, last_name, email) values(1,(select max(address_id) from address a inner join city c on c.city_id=a.city_id inner join country co on c.country_id=co.country_id where co.country='United States'), 'JUAN INSERTADO', 'INSERTADO', 'INSERTADO@gmail.com');

#Add a rental
#Make easy to select any film title. I.e. I should be able to put 'film tile' in the where, and not the id.
#Do not check if the film is already rented, just use any from the inventory, e.g. the one with highest id.
#Select any staff_id from Store 2.
insert into rental (rental_date,inventory_id, staff_id, customer_id) values(
now(),
(select inventory_id from inventory i inner join film f on f.film_id=i.film_id where f.title='PRIDE ALAMO' LIMIT 1),
(select max(staff_id) from staff where store_id=2),
3
);

#Update film year based on the rating
#For example if rating is 'G' release date will be '2001'
#You can choose the mapping between rating and year.
#Write as many statements are needed.

update film
set release_year= '2001'
where rating='G';
update film
set release_year= '2002'
where rating='PG';
update film
set release_year= '2003'
where rating='NC-17';
update film
set release_year= '2004'
where rating='PG-13';
update film
set release_year= '2005'
where rating='R';
select * from film order by rating;

#Return a film
#Write the necessary statements and queries for the following steps.
#Find a film that was not yet returned. And use that rental id. Pick the latest that was rented for example.
#Use the id to return the film.


update rental 
set return_date=now()
where rental_id=(select max(rental_id) where return_date is null);
select * from rental where rental_id= 16053;


#Try to delete a film
#Check what happens, describe what to do.
#Write all the necessary delete statements to entirely remove the film from the DB.
delete from film where film_id=1;
#Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`sakila`.`film_actor`, CONSTRAINT `fk_film_actor_film` FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`) ON DELETE RESTRICT ON UPDATE CASCADE)
delete from film_actor where film_id=1;
delete from film_category where film_id=1;
delete from rental where inventory_id in (select inventory_id from inventory where film_id=1);
delete from inventory where film_id=1;
delete from film where film_id=1;
select * from film order by film_id asc;

#Rent a film
#Find an inventory id that is available for rent (available in store) pick any movie. Save this id somewhere.
#Add a rental entry
#Add a payment entry
#Use sub-queries for everything, except for the inventory id that can be used directly in the queries.
#Añado datos para que no este vacia cuando pide inventory que no tengan una rental asociada: 
/*INSERT INTO inventory (film_id, store_id, last_update)
VALUES (6, 1, NOW());

INSERT INTO inventory (film_id, store_id, last_update)
VALUES (2, 1, NOW());

INSERT INTO inventory (film_id, store_id, last_update)
VALUES (3, 2, NOW());


INSERT INTO inventory (film_id, store_id, last_update)
VALUES (4, 2, NOW());

INSERT INTO inventory (film_id, store_id, last_update)
VALUES (5, 2, NOW());*/
select inventory_id from inventory i left outer join rental r using(inventory_id) where r.rental_id is null limit 1;
insert into rental (rental_date,inventory_id,customer_id,staff_id) values (
	NOW(), 
	(4587), 
    (SELECT customer_id FROM customer LIMIT 1), 
    (SELECT staff_id FROM staff LIMIT 1));
    
INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date)
VALUES (
    (SELECT customer_id FROM rental WHERE inventory_id = 4587 LIMIT 1),
    (SELECT staff_id FROM rental WHERE inventory_id = 4587 LIMIT 1),   
    (SELECT max(rental_id) FROM rental WHERE inventory_id = 4587),  
    466.43, 
    NOW() 
);



