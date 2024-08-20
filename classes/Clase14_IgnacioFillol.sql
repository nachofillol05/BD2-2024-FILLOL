#1. Write a query that gets all the customers that live in Argentina. Show the first and last name in one column, the address and the city.

select concat(cu.first_name, ' ', cu.last_name),a.address, ci.city from customer cu inner join address a using(address_id) inner join city ci using(city_id) inner join country co using(country_id) where co.country='Argentina';

#Write a query that shows the film title, language and rating. Rating shall be shown as the full text described here: https://en.wikipedia.org/wiki/Motion_picture_content_rating_system#United_States. Hint: use case.
select title, case rating
        when 'G' then 'G (General Audiences) – All ages admitted.'
        when 'PG' then 'PG (Parental Guidance Suggested) – Some material may not be suitable for children.'
        when 'PG-13' then 'PG-13 (Parents Strongly Cautioned) – Some material may be inappropriate for children under 13.'
        when 'R' then 'R (Restricted) – Under 17 requires accompanying parent or adult guardian.'
        when 'NC-17' then 'NC-17 (Adults Only) – No one 17 and under admitted.'
        else 'Not Rated'
    end as rating_formated,
    l.`name` from film inner join `language` l using(language_id);
    
#Write a search query that shows all the films (title and release year) an actor was part of. 
#Assume the actor comes from a text box introduced by hand from a web page. 
#Make sure to "adjust" the input text to try to find the films as effectively as you think is possible
select f.title, f.release_year, concat(a.first_name, ' ',a.last_name) as nombre from film_actor fa inner join film f using(film_id) inner join actor a using(actor_id) where lower(concat(a.first_name, ' ',a.last_name)) = lower('PENELOPE GUINESS');

#Find all the rentals done in the months of May and June.
# Show the film title, customer name and if it was returned or not. 
#There should be returned column with two possible values 'Yes' and 'No'.

select f.title, c.first_name, case 
when r.return_date  is not null then 'Yes'
else 'No' end as Returned
 from rental r 
 inner join inventory using(inventory_id)
 inner join film f using(film_id)
 inner join customer c using(customer_id)
 where month(rental_date)=5 or month(rental_date)=6;
 
 #4 
 #Cast es utilizado para cambiar de un tipo de dato a otro, es mas global, signed es para enteros, unsigned para naturales
 select title, cast(rental_rate as signed) as rental_rate_int from film;
 #convert es utilizado para lo mismo pero acepta formateo de fechas y hora
 select title, convert(rental_rate, signed) as rental_rate_int from film;
 
 #5
 /*NVL Function(no soportado en mysql)
es usado en sql oraqle para reemplazar null por un valor con la siguiente sintaxis:
NVL(expresion, valor_a_reemplazar)

ISNULL(no soportado en mysql)
es usado en sql server para reemplazar null por un valor con la siguiente sintaxis:
isnull(expresion, valor_a_reemplazar)

IFNULL
es usado en mysql para reemplazar null por un valor con la siguiente sintaxis:
ifnull(expresion, valor_a_reemplazar)

COALESCE
es usado en la mayoria de bases de datos sql para reemplazar el primer null por un valor con la siguiente sintaxis:
coalesce(expresion, expresion2..., valor_a_reemplazar)
*/
select ifnull(rental_rate, 0) AS rental_rate
FROM film;

SELECT COALESCE(rental_rate, 0) AS rental_rate
FROM film;




