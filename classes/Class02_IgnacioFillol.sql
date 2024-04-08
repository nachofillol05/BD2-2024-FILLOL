DROP DATABASE IF EXISTS imdb;
CREATE DATABASE imdb;

USE imdb;
#film (film_id, title, description, release_year);
CREATE TABLE IF NOT EXISTS film(
	film_id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(55),
    description TEXT(600),
    release_year YEAR,
    CONSTRAINT pk_film_id PRIMARY KEY(film_id)
);

#actor (actor_id, first_name, last_name)
CREATE TABLE IF NOT EXISTS actor(
	actor_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(55),
    last_name VARCHAR(55),
    CONSTRAINT pk_actor_id PRIMARY KEY(actor_id)
);

#film_actor (actor_id, film_id)
CREATE TABLE IF NOT EXISTS film_actor(
	actor_id INT NOT NULL,
    film_id INT NOT NULL,
    CONSTRAINT pk_actor_film PRIMARY KEY(actor_id , film_id)
);

#Alter table add column last_update to film and actor
ALTER TABLE film ADD last_update DATETIME;
ALTER TABLE actor ADD last_update DATETIME;
#Alter table add foreign keys to film_actor table
ALTER TABLE film_actor ADD CONSTRAINT fk_film FOREIGN KEY (film_id) REFERENCES film(film_id);
ALTER TABLE film_actor ADD CONSTRAINT fk_actor FOREIGN KEY (actor_id) REFERENCES actor(actor_id);
#Insert some actors, films and who acted in each film
INSERT INTO film (title, description, release_year, last_update) 
VALUES 
('Sueño de fuga', 'Dos hombres encarcelados entablan una amistad única a lo largo de los años, encontrando consuelo y eventual redención a través de actos de decencia común.', 1994, NOW()),
('El padrino', 'El patriarca envejecido de una dinastía del crimen organizado transfiere el control de su imperio clandestino a su hijo renuente.', 1972, NOW()),
('El caballero de la noche', 'Cuando la amenaza conocida como El Guasón emerge de su pasado misterioso, causa estragos y caos en la gente de Gotham.', 2008, NOW());

INSERT INTO actor (first_name, last_name, last_update)
VALUES
('Tim', 'Robbins', NOW()),
('Morgan', 'Freeman', NOW()),
('Marlon', 'Brando', NOW()),
('Al', 'Pacino', NOW()),
('Christian', 'Bale', NOW());

INSERT INTO film_actor (actor_id, film_id)
VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 3);
