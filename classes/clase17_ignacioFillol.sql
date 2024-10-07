/*Create two or three queries using address table in sakila db:
include postal_code in where (try with in/not it operator)
eventually join the table with city/country tables.
measure execution time.
Then create an index for postal_code on address table.
measure execution time again and compare with the previous ones.
Explain the results
*/
select *,case active when 1 then 'active' else 'inactive'end as status from address inner join customer using(address_id) inner join city using(city_id) inner join country using(country_id) where postal_code in (35200,17886,53561,42399) and store_id = 1 order by district desc;
#0.0035 seg
select a.address, a.postal_code, c.city, co.country from address a inner join city c on a.city_id = c.city_id inner join country co on c.country_id = co.country_id where a.postal_code not in ('12345', '67890', '54321');
#0.0058 seg
CREATE INDEX index_postal_code ON address(postal_code);
#1. 0.0030 seg
#2.0.0036 seg

#2.Run queries using actor table, searching for first and last name columns independently. Explain the differences and why is that happening?
select first_name from actor where first_name like "%A";#0.0011
select last_name from actor where first_name like "%A";#0.0010
#Esto es debido a que last_name tiene un index entonces va a sacar esa columna de los datos almacenados y no de la consulta que tardaria mas :)

#3.Compare results finding text in the description on table film with LIKE and in the film_text using MATCH ... AGAINST. Explain the results.
select * from film where description like "%feminist%";#0.0068
select * from film_text where match (title, description) against("%feminist%");#0.0030
#Hay que hacer esto porque sakila tiene el fullText como tiltle unido a description y si no pones los 2 da error porque description no tiene un fulltext solo y va a ser mas rapido porque el fulltext tiene un index para que se almacene 
#Entonces esto hace que lo saque directamente de ahi ya que es un texto largo.