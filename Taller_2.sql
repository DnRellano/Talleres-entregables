##Taller 2
##Daniel Alejandro Cuaspa Arellano

USE sakila;

### Parte 1 – SELECT y WHERE
## Consultas básicas sobre la BD SAKILA
SELECT * FROM customer;

## 1. Mostrar los nombres y apellidos de los clientes 
SELECT first_name, last_name FROM customer; 

## 2. Mostar películas con duración mayor a 120 minutos
SELECT title, length 
FROM film 
WHERE length >= 120;

### Parte 2 – ORDER BY
## 3. Ordenar clientes por apellido --> Por orden alfabetico de la A a la Z
SELECT last_name
FROM customer
ORDER BY last_name ASC;

## 4. Top 5 películas más largas --> TIP: Use la palabra LIMIT
SELECT title, length 
FROM film 
ORDER BY length DESC 
LIMIT 5;

### Parte 3 – INNER JOIN
## 5. Cantidad pagada y fecha del pago con nombre y apellido del cliente (JOIN entre Payment - Customer)
SELECT 
    p.amount, 
    p.payment_date, 
    c.first_name, 
    c.last_name
FROM payment AS p
INNER JOIN customer AS c ON p.customer_id = c.customer_id;

## 6. Películas alquiladas (JOIN entre Rental - Inventory - Film)
SELECT 
    f.title, 
    r.rental_date
FROM rental r
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id;
 
### Parte 4 – LEFT JOIN
## 7. Nombre y apellido de clientes sin pagos (LEFT JOIN entre Payment - Customer pero usando WHERE)
SELECT 
	c.first_name,
    c.last_name
FROM customer c
LEFT JOIN payment p ON c.customer_id = p.customer_id
WHERE p.payment_id IS NULL;

## 8. Listar los nombres de las peliculas y su duracion de aquellos titulos que no tienen actores
SELECT 
	f.title,
    f.length
FROM film f 
LEFT JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id IS NULL;

### Parte 5 – INSERT, UPDATE, DELETE (Data Definition Language )
## 9. Insertar actor temporal
INSERT INTO actor (first_name, last_name)
VALUES ('ALEJANDRO', 'TEMPORAL');
SELECT * 
FROM actor 
WHERE first_name = 'ALEJANDRO' AND last_name = 'TEMPORAL';

## 10. Actualizar actor
UPDATE actor 
SET first_name = 'ALEJO' 
WHERE last_name = 'TEMPORAL'; 
SELECT * 
FROM actor 
ORDER BY actor_id DESC 
LIMIT 5;

## 11. Eliminar actor
DELETE FROM actor 
WHERE last_name = 'TEMPORAL';
SELECT LAST_INSERT_ID();

### Parte 6 - Consultas Avanzadas
##Top 5 clientes con mayor cantidad de dinero pagado al servicio de rentas
SELECT 
    c.first_name, 
    c.last_name, 
    SUM(p.amount) AS total_pagado
FROM customer c
INNER JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY total_pagado DESC
LIMIT 5;

## 13. Top 5 Películas más alquiladas ->Agrupar los datos con conteo y tomar las mejores 5
SELECT 
    f.title AS 'Título de la Película', 
    COUNT(r.rental_id) AS 'Total de Alquileres'
FROM rental r
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id
ORDER BY COUNT(r.rental_id) DESC
LIMIT 5;