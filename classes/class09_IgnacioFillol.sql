#Get the amount of cities per country in the database. Sort them by country, country_id.
select co.country, count(*) as amount_cities from city ci
inner join country co on co.country_id = ci.country_id
group by co.country_id
order by co.country, co.country_id;

#Get the amount of cities per country in the database. Show only the countries with more than 10 cities, order from the highest amount of cities to the lowest
select co.country, count(*) as amount_cities from city ci
inner join country co on co.country_id = ci.country_id
group by co.country_id
having 10<amount_cities
order by amount_cities desc;

#Generate a report with customer (first, last) name, address, total films rented and the total money spent renting films. Show the ones who spent more money first .
select first_name,last_name,a.*, 
(select count(*) from rental r where r.customer_id=c.customer_id) as total_films_rented, 
(select sum(amount) from payment p where p.customer_id=c.customer_id) as total_money_spent 
from customer c
inner join address a on c.address_id=a.address_id
order by total_money_spent desc; 

#Which film categories have the larger film duration (comparing average)?.Order by average in descending order
select c.name,avg(length) as average_duration  from category c
inner join film_category fc on fc.category_id= c.category_id
inner join film f on f.film_id=fc.film_id
group by c.name
order by average_duration desc;

#Show sales per film rating
select rating, concat(sum(p.amount), ' USD') as sales from film f
inner join inventory i on i.film_id = f.film_id
inner join rental r on r.inventory_id= i.inventory_id
inner join payment p on r.rental_id= p.rental_id
group by rating
order by sales desc;