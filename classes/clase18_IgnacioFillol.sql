#Write a function that returns the amount of copies of a film in a store in sakila-db. Pass either the film id or the film name and the store id.
drop procedure copiesOfFilm;
delimiter // 
create procedure copiesOfFilm(in film int,in store int, out amount_copies int)
begin
	select count(*) into amount_copies from inventory where film_id=film and store_id=store; 
end // 
delimiter ;
call copiesOfFilm(2,2,@amount);
select @amount;
#Write a stored procedure with an output parameter that contains a list of customer first and last names separated by ";", that live in a certain country. 
#You pass the country it gives you the list of people living there. USE A CURSOR, do not use any aggregation function (ike CONTCAT_WS.
drop procedure customer_by_country_list;
DELIMITER //
CREATE PROCEDURE customer_by_country_list (IN country_name VARCHAR(255), OUT lista TEXT)
BEGIN
	declare finished boolean;
    declare cliente varchar(255);
	DECLARE customer_list CURSOR FOR SELECT concat(first_name," ",last_name) FROM customer inner join address using (address_id) inner join city using(city_id) inner join country co using(country_id) where co.country=country_name;
	declare continue handler for not found set finished = 1;
    set lista="";
    open customer_list;
    get_list:loop
		fetch customer_list into cliente;
        if finished = 1 then
			leave get_list;
		end if;
        if lista="" then
			set lista = cliente;
        else
			set lista = concat(lista, "; ", cliente);
		end if;
    end loop get_list;
END
delimiter ;
call customer_by_country_list("Argentina",@lista);
select @lista;

#Review the function inventory_in_stock and the procedure film_in_stock explain the code, write usage examples.
show create procedure film_in_stock;

/*CREATE DEFINER=`bdi`@`localhost` PROCEDURE `film_in_stock`(IN p_film_id INT, IN p_store_id INT, OUT p_film_count INT)
    READS SQL DATA
BEGIN
     SELECT inventory_id
     FROM inventory
     WHERE film_id = p_film_id
     AND store_id = p_store_id
     AND inventory_in_stock(inventory_id);

     SELECT COUNT(*)
     FROM inventory
     WHERE film_id = p_film_id
     AND store_id = p_store_id
     AND inventory_in_stock(inventory_id)
     INTO p_film_count;
END*/
/*La función `inventory_in_stock` está diseñada para verificar si un artículo específico en el inventario de la tienda está disponible (en stock). 
Funciona de la siguiente manera: se pasa un `inventory_id` como parámetro. El primer paso verifica si se ha realizado algún alquiler para ese artículo contando las filas en la tabla `rental` 
que coincidan con el `inventory_id` dado. Si no se encuentran alquileres, la función devuelve `TRUE`, lo que indica que el artículo está en stock. Si existen alquileres, la función procede al siguiente paso. 
En este segundo paso, la función verifica si alguna de las filas en la tabla `rental` para este artículo tiene un `return_date` que aún sea `NULL`. Cuenta cuántos alquileres no tienen una fecha de devolución 
(es decir, no han sido devueltos). Si el recuento es cero, lo que significa que todos los alquileres han sido devueltos, la función devuelve `TRUE`, ya que el artículo ahora está de vuelta en stock. 
Si al menos una `return_date` sigue siendo `NULL`, la función devuelve `FALSE`, lo que significa que el artículo aún está alquilado.*/

show create function inventory_in_stock;
/*CREATE DEFINER=`bdi`@`localhost` FUNCTION `inventory_in_stock`(p_inventory_id INT) RETURNS tinyint(1)
    READS SQL DATA
BEGIN
    DECLARE v_rentals INT;
    DECLARE v_out     INT;
    SELECT COUNT(*) INTO v_rentals
    FROM rental
    WHERE inventory_id = p_inventory_id;
    IF v_rentals = 0 THEN
      RETURN TRUE;
    END IF;

    SELECT COUNT(rental_id) INTO v_out
    FROM inventory LEFT JOIN rental USING(inventory_id)
    WHERE inventory.inventory_id = p_inventory_id
    AND rental.return_date IS NULL;

    IF v_out > 0 THEN
      RETURN FALSE;
    ELSE
      RETURN TRUE;
    END IF;
END*/
/*El procedimiento `film_in_stock` tiene un propósito similar, pero en lugar de verificar un artículo, devuelve el número total de copias de una película en particular que están disponibles en una tienda específica. 
El procedimiento toma dos parámetros de entrada: `p_film_id` y `p_store_id`. El procedimiento funciona en dos partes: primero, recupera el `inventory_id` de todos los artículos en la tabla `inventory` 
que coincidan con el `film_id` y `store_id` proporcionados y que estén actualmente disponibles para alquilar. La disponibilidad se verifica utilizando la función `inventory_in_stock` explicada anteriormente. 
En segundo lugar, cuenta el número de copias disponibles de la película (aquellas que pasaron la verificación de `inventory_in_stock`) y almacena el resultado en la variable `p_film_count`, que se devuelve para indicar 
cuántas copias de la película están disponibles para alquilar en esa tienda.*/