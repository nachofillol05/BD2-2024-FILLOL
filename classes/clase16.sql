#1- Insert a new employee to , but with an null email. Explain what happens.

insert into employees (employeeNumber,lastName,firstName, extension,officeCode,reportsTo,jobTitle,email) values
(7834,"orellano","joaquin","x9273", 1, 1002,"VP Marketing",null);
#Error Code: 1048. Column 'email' cannot be null
#Esto pasa porque email esta declarado con la constraint not null y no se puede pasar null

#2- Run the first the query
UPDATE employees SET employeeNumber = employeeNumber - 20;
#Al employeeNumber se le resta 20 a todas las filas al numero almacendado en ese campo ejemplo 902 era el id y si lo ejecutas va a ser 882
UPDATE employees SET employeeNumber = employeeNumber + 20;
#Al parecer va recorriendo y va sumando 1 por 1 entonces al encontrarse al ir por ejemplo por 936 le suma 20 y queda 956 pero ya hay otro employeeNumber con ese numero
#y al ser declarado por una primary key no puede estar repetida pero luego se sumaria y quedaria distinto pero como se hace 1 por 1 no te deja, este es un caso muy especifico,
#pero por ahi si le sumas 1 es mas propenso a errores.
select * from employees;

#3- Add a age column to the table employee where and it can only accept values from 16 up to 70 years old.
alter table employees 
add column age int DEFAULT 16, 
add constraint check_age check (age between 16 and 70);
#Error Code: 3819. Check constraint 'chk_age' is violated.
#Esto es porque hay valores que no cumplen esa condicion, al ponerle un default ya los que no cumplen se van a poner el default

#4- Describe the referential integrity between tables film, actor and film_actor in sakila db.
/*
La integridad de referencia entre esas tablas esta dada por la foreign key que conecta la tabla film con cator mediante una tabla intermedia,
la cual guarda las claves primarias de ambas tablas y no permite el borrado de ninguna film o un actor sin antes borrar algun film_actor que contenga a ese a borrar
*/

#5- Create a new column called lastUpdate to table employee and use trigger(s) to keep the date-time updated on inserts and updates operations. 
#Bonus: add a column lastUpdateUser and the respective trigger(s) to specify who was the last MySQL user that changed the row (assume multiple users, other than root, 
#can connect to MySQL and change this table).
alter table employees add column lastUpdate datetime default now();
alter table employees add column lastUpdateUser varchar(255) default "root";
select * from employees;
delimiter $$
create trigger before_update_employees
before update on employees
for each row
begin
	set new.lastUpdate=now();
    set new.lastUpdateUser= current_user();
end$$
delimiter ;

delimiter $$
create trigger before_insert_employees
before insert on employees
for each row
begin
	set new.lastUpdate=now();
    set new.lastUpdateUser= current_user();
end$$
delimiter ;

INSERT INTO employees (
    employeeNumber,
    lastName,
    firstName,
    extension,
    email,
    officeCode,
    reportsTo,
    jobTitle,
    lastUpdate,
    lastUpdateUser
) VALUES (
    1001,
    'Smith',
    'John',
    'x123',
    'john.smith@example.com',
    '1',
    NULL,
    'Sales Manager',
    NOW(),
    CURRENT_USER()
);

UPDATE employees
SET
    lastName = 'Doe',
    firstName = 'Jane',
    extension = 'x456',
    email = 'jane.doe@example.com',
    officeCode = '2',
    reportsTo = 1002,
    jobTitle = 'Senior Sales Manager',
    lastUpdate = NOW(),
    lastUpdateUser = CURRENT_USER()
WHERE
    employeeNumber = 956;
    
#6- Find all the triggers in sakila db related to loading film_text table. What do they do? Explain each of them using its source code for the explanation.
show triggers;
select * from film_text;
select * from film;
/*
Basicamente tiene un trigger conectado a cada accion de film osea un update, insert y delete que va a crear un film_text que contiene solo el nombre
y la descripcion y se va modificando creando y borrando a la par de la tabla film
*/
#cuando se crea
DELIMITER $$

CREATE TRIGGER ins_film
AFTER INSERT ON film
FOR EACH ROW
BEGIN
    INSERT INTO film_text (film_id, title, description)
        VALUES (NEW.film_id, NEW.title, NEW.description);
END$$

DELIMITER ;
#cuando se cambia
DELIMITER $$

CREATE TRIGGER upd_film
AFTER UPDATE ON film
FOR EACH ROW
BEGIN
    IF (OLD.title != NEW.title) OR (OLD.description != NEW.description) OR (OLD.film_id != NEW.film_id)
    THEN
        UPDATE film_text
            SET title = NEW.title,
                description = NEW.description,
                film_id = NEW.film_id
        WHERE film_id = OLD.film_id;
    END IF;
END$$

DELIMITER ;
#cuando se borra
DELIMITER $$

CREATE TRIGGER del_film
AFTER DELETE ON film
FOR EACH ROW
BEGIN
    DELETE FROM film_text WHERE film_id = OLD.film_id;
END$$

DELIMITER ;





