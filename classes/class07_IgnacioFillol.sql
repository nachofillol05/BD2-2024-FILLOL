use sakila;

#Find the films with less duration, show the title and rating.
select title, rating from film where length =  (select min(`length`) from film);

#Write a query that returns the tiltle of the film which duration is the lowest. If there are more than one film with the lowest durtation, the query returns an empty resultset.
select title from film f1 where length < ALL (select length from film f2 where f1.film_id != f2.film_id);

#Generate a report with list of customers showing the lowest payments done by each of them. Show customer information, the address and the lowest amount, 
#provide both solution using ALL and/or ANY and MIN.
select c.*,min(p.amount) as lowest_amount,a.* from payment p
inner join customer c on c.customer_id=p.customer_id
inner join address a on c.address_id=a.address_id 
group by p.customer_id;

select p.amount as lowest_amount,c.*,a.* from payment p
inner join customer c on c.customer_id=p.customer_id
inner join address a on c.address_id=a.address_id 
where p.amount <= all(select amount from payment p2 where p.customer_id=p2.customer_id)
group by p.customer_id, p.amount;
#nose si esta bien ese group by amount


#Generate a report that shows the customer's information with the highest payment and the lowest payment in the same row.
select c.*, (select max(p.amount) from payment p where c.customer_id=p.customer_id) as highest, (select min(amount) from payment p where c.customer_id=p.customer_id) as lowest from customer c;
