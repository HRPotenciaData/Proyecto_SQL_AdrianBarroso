-- 1. CREAR ESQUEMA DE BASE DE DATOS

-- 2. MOSTRAR NOMBRES DE TODAS PELICULAS CON CLASIFICACION DE EDADES DE R

SELECT title, rating
FROM film
WHERE rating = 'R'

-- 3.NOMBRES DE ACTORES QUE TENGAN actor_id ENTRE 30 Y 40

SELECT "first_name", "last_name", "actor_id"
FROM "actor"
WHERE "actor_id" BETWEEN 30 AND 40;

-- 4. PELICULAS CUYO IDIOMA COINCIDE CON EL IDIOMA ORIGINAL

SELECT title, language_id, original_language_id
FROM film
WHERE language_id = original_language_id;

-- 5. ORDENAR PELICULAS POR DURACION ASCENDENTE

SELECT "title", "length"
FROM "film"
ORDER BY "length" ASC;


-- 6. NOMBRE Y APELLIDO ACTORES CON 'ALLEN' EN APELLIDO

SELECT CONCAT (first_name, ' ', last_name) AS nombre_actor
FROM "actor"
WHERE "last_name" LIKE '%ALLEN%';

-- 7. TOTAL PELICULAS EN CADA CLAS. Y RECUENTO

SELECT c.name AS category_name, 
	COUNT(f.film_id) AS total_films
FROM "category" c
JOIN film_category fc 
ON c.category_id = fc.category_id
JOIN film f 
ON fc.film_id = f.film_id
GROUP BY c."name"
ORDER BY total_films DESC;

-- 8. TITULO PELIS 'PG-13' O > 3 HORAS

SELECT title, rating,  ROUND (length/60.0, 2) AS hours
FROM "film"
WHERE "rating" = 'PG-13' OR "length" > 180
ORDER BY "rating" ASC;
 

-- 9. VARIABILIDAD REMPLAZO PELICULAS

SELECT ROUND (VARIANCE (replacement_cost), 2) AS varianza
FROM "film";

-- 10. MAYOR Y MENOR DURACION DE PELICULAS

SELECT 
	MAX(length) AS max_length_film,
	MIN(length) AS min_length_film
FROM "film";

-- 11. COSTE DEL ANTEPENULTIMO ALQUILER ORDENADO POR DIA

SELECT 
	f.title,
	f.rental_rate,
	r.rental_date
FROM 
	rental r
JOIN
	inventory i 
ON
	i.inventory_id = r.inventory_id 
JOIN 	
	film f 
ON 
	f.film_id = i.film_id
ORDER BY 
	r.rental_date DESC
OFFSET
	2 LIMIT 1;

-- 12. TITULO PELICULAS DE FILM QUE NO SEAN NC-17 NI G DE CLASIFICACION

SELECT title, rating
FROM film
WHERE rating 
NOT IN ('NC-17', 'G');

-- 13. PROMEDIO DURACION PELICULAS PARA CADA CLASIFICACION DE TABLA FIM Y MOSTRAR CALSIFICACION Y PROMEDIO

SELECT ROUND (AVG(length),2) AS average_length_film, rating 
FROM film
GROUP BY rating; 

-- 14. TITULO PELICULAS > A 180 MINUTOS

SELECT title, length 
FROM film
WHERE length>180
ORDER BY length ASC;

-- 15. DINERO TOTAL GENERADO

SELECT SUM(amount) AS total_amount
FROM payment


-- 16. 10 CLIENTES CON > VALOR ID

SELECT SUM (amount) AS valor_id, customer_id
FROM payment
GROUP BY customer_id
ORDER BY valor_id 
	DESC
	LIMIT 10;

-- 17. NOMBRE Y APELLIDO DE ACTORES DE PELICULA 'EGG IGBY'

SELECT a.first_name, a.last_name, f.title
FROM actor a 
JOIN film_actor fa 
ON fa.actor_id = a.actor_id
JOIN film f 
ON f.film_id = fa.film_id
WHERE f.title = 'EGG IGBY';


-- 18. NOMBRES PELICULAS UNICAS

SELECT DISTINCT title
FROM film;

-- 19. TITULO PELICULAS COMEDIA Y > 180 MINUTOS

SELECT c.name, f.length, f.title
FROM film_category fc 
JOIN category c 
	ON fc.category_id = c.category_id
JOIN film f 
	ON f.film_id = fc.film_id
WHERE c."name" = 'Comedy' 
	AND f."length" > 180; 

-- 20. NOMBRE CATEGORIA Y PROMEDIO DE LAS CATEGORIAS DE PELICULAS CON PROMEDIO > 110 MIN. 

SELECT  c.name AS category_name,
    	ROUND(AVG(f.length), 2) AS avg_length
FROM category c
JOIN film_category fc 
ON c.category_id = fc.category_id
JOIN film f 
ON f.film_id = fc.film_id
GROUP BY c."name"
HAVING AVG(f.length) > 110
ORDER BY avg_length DESC;

-- 21. MEDIA DURACION POR ALQUILER

SELECT ROUND (AVG (rental_duration), 2) AS avg_rental_duration
FROM film

-- 22. CREAR COLUMNA CON NOMBRE Y APELLIDOS DE ACTORES Y ACTRICES

SELECT CONCAT (first_name,' ', last_name) AS nombre_completo
FROM actor;

-- 23. Nº ALQUILER POR DIA ORDENADO DE FORMA DESCENDENTE

SELECT to_char(rental_date, 'YYYY-MM-DD') AS rental_day, COUNT(*) AS rental_count
FROM rental  
GROUP BY to_char(rental_date, 'YYYY-MM-DD')
ORDER BY rental_count DESC;

-- 24. peliculas con duracion > promedio

SELECT title, length 
FROM film
WHERE length > 
	(SELECT AVG(length) 
	FROM film);

-- 25. Nº ALQUILERES POR MES

SELECT to_char(rental_date, 'Month')
	AS rental_month, 
	COUNT(*) AS rental_count
FROM rental  
GROUP BY TO_CHAR(rental_date, 'Month')
ORDER BY rental_month;

-- 26. PROMEDIO, DESVIACION ESTANDAR Y VARIANZA TOTAL PAGADO

SELECT ROUND (AVG(amount),2) AS average_amount,
		ROUND (VARIANCE(amount),2) AS variance_amount, 
		ROUND (STDDEV(amount),2) AS deviation_amount
FROM payment;

-- 27. PELICULAS QUE SE ALQUILAN POR ENCIMA DEL PRECIO MEDIO

SELECT rental_rate , title 
FROM film
WHERE rental_rate >
	(SELECT AVG (rental_rate) 
	FROM film);
	
-- 28. ID ACTORES CON MAS DE 40 PELICULAS

SELECT actor_id , 
	COUNT(film_id) AS film_count
FROM film_actor 
GROUP BY actor_id
HAVING COUNT(film_id)>40;

-- 29.OBTENER TODAS LAS PELICULAS Y SI ESTAN DISPONIBLES MOSTRAR CANTIDAD

SELECT f.title,
    COUNT(i.inventory_id) AS available_copies
FROM 
    film f
LEFT JOIN 
    inventory i ON f.film_id = i.film_id
GROUP BY 
    f.title
ORDER BY 
    available_copies DESC;

-- 30. ACTORES Y Nº PELIS EN LAS QUE HA ACTUADO

SELECT a.actor_id, a.first_name, a.last_name, 
		COUNT(fa.film_id) AS film_count
FROM actor a 
JOIN film_actor fa 
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY film_count DESC;

-- 31. OBTENER TODAS LAS PELIS Y ACTORES QUE HAN ACTUADO EN ELLAS INCLUSO SI NO TIENEN ACTORES ASOCIADOS

SELECT  f.title, a.first_name, a.last_name
FROM film f 
LEFT JOIN film_actor fa 
ON f.film_id = fa.film_id
LEFT JOIN actor a 
ON fa.actor_id = a.actor_id
ORDER BY f.title, a.last_name, a.first_name;

-- 32. OBTENER TODOS LOS ACTORES Y MOSTRAR PELICULAS EN LAS QUE HAN ACTUADO

SELECT a.first_name, a.last_name, f.title
FROM actor a 
LEFT JOIN film_actor fa 
ON a.actor_id = fa.actor_id
LEFT JOIN film f 
ON f.film_id = fa.film_id
ORDER BY a.first_name, a.last_name, f.title;

-- 33. OBTENER TODAS LAS PELIS Y TODOS LOS REGISTROS DE ALQUILER

SELECT f.title, r.rental_id, r.rental_date, r.return_date
FROM film f 
LEFT JOIN inventory i 
ON i.film_id = f.film_id
LEFT JOIN rental r 
ON r.inventory_id = i.inventory_id
ORDER BY f.title, r.rental_date;

-- 34. ENCONTRAR LOS 5 CLIENTES QUE MAS DINERO HAYAN GASTADO

SELECT c.customer_id, c.first_name, c.last_name,
		SUM(p.amount) AS total_spent
FROM payment p
JOIN customer c 
ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name  
ORDER BY total_spent DESC
LIMIT 5;

-- 35. SELECCIONAR ACTORES CUYO NOMBRE ES JOHNNY

SELECT first_name , last_name 
FROM actor a
WHERE "first_name" = 'JOHNNY';

-- 36. RENOMBRAR COLUMNA FIRST_NAME COMO NOMBRE Y LAST_NAME COMO APELLIDO

SELECT first_name AS Nombre, last_name AS Apellido
FROM actor a
WHERE "first_name" LIKE '%JOHNNY%';

--37. ID MÁS ALTO Y MÁS BAJO DE TABLA ACTOR

SELECT MAX(actor_id) AS highest_id,
	   MIN(actor_id) AS lowest_id
FROM actor a;

--38. Nº ACTORES EN LA TABLA ACTOR

SELECT COUNT(actor_id) AS total_actors
FROM actor a;

--39. SELECCIONAR TODOS LOS ACTORES ORDENADOS POR APELLIDO ASCENDENTE

SELECT first_name , last_name 
FROM actor a 
ORDER BY last_name ASC;

-- 40. 5 PRIMERAS PELICULAS DE LA TABLA FILM

SELECT * 
FROM film f 
LIMIT 5;

-- 41. AGRUPAR ACTORES POR NOMBRE Y CONTAR CUANTOS ACTORES TIENEN EL MISMO NOMBRE Y CUAL SE REPITE MAS

SELECT first_name, COUNT(first_name) AS total
FROM actor a 
GROUP BY a.first_name
ORDER BY total DESC;

-- 42. TODOS LOS ALQUILERES Y NOMBRES CLIENTES QUE LOS REALIZARON

SELECT 
	c.first_name,
	c.last_name,
	r.rental_id,
	r.rental_date,
	r.return_date
FROM 
	rental r
JOIN
	customer c 
ON
	c.customer_id = r.customer_id 
	
ORDER BY r.rental_date;

-- 43. MOSTRAR TODOS LOS CLIENTES Y SUS ALQUILERES SI EXISTEN, INCLUYENDO LOS QUE NO TIENEN ALQUILERES

SELECT c.customer_id,c.first_name,c.last_name,r.rental_id,r.rental_date,r.return_date
FROM 
    customer c
LEFT JOIN 
    rental r ON c.customer_id = r.customer_id
ORDER BY 
    c.last_name, c.first_name, r.rental_date;

-- 44. CROSS JOIN ENTRE TABLAS FILM Y CATEGORY Y COMENTAR SI APORTA VALOR

SELECT 
    f.title AS film_title,
    c.name AS category_name
FROM 
    film f
CROSS JOIN 
    category c;

--No aporta valor en este contexto, ya que no refleja la relación real entre películas y categorías.
-- Solo muestra combinaciones hipotéticas que no tienen utilidad analítica ni informativa.

-- 45. ENCUENTRA LOS ACTORES QUE HAN PARTICIPADO EN PELICULAS DE CATEGORIA ACTION

SELECT DISTINCT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa 
ON a.actor_id = fa.actor_id
JOIN film f 
ON fa.film_id = f.film_id
JOIN film_category fc 
ON f.film_id = fc.film_id
JOIN category c
ON fc.category_id = c.category_id
WHERE c."name" = 'Action'
ORDER BY a.last_name, a.first_name;

-- 46. ACTORES QUE NO HAN PARTICIPADO EN PELICULAS

SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
LEFT JOIN film_actor fa 
ON a.actor_id = fa.actor_id
WHERE fa.film_id IS NULL
ORDER BY a.last_name, a.first_name;

-- 47. NOMBRE DE ACTORES Y LA CANTIDAD DE PELICULAS EN LAS QUE HAN PARTICIPADO

SELECT a.first_name, a.last_name,
	COUNT (fa.film_id) AS total_film
FROM actor a
JOIN film_actor fa 
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY total_film DESC;

-- 48. CREAR VISTA LLAMADA "actor_num_peliculas" QUE MUESTRE LOS NOMBRES DE ACTORES Y Nº DE PELICULAS EN QUE HAN PARTICIPADO

CREATE VIEW actor_num_peliculas AS
SELECT a.first_name, a.last_name, 
	COUNT(fa.film_id) AS total_film
FROM actor a
JOIN film_actor fa
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name;

-- 49. Nº TOTAL ALQUILERES REALIZADO POR CADA CLIENTE

SELECT COUNT(r.rental_id) AS total_rentals,
r.customer_id, c.first_name, c.last_name 
FROM rental r 
JOIN customer c 
ON r.customer_id = c.customer_id
GROUP BY c.first_name, c.last_name, r.customer_id 
ORDER BY total_rentals DESC

-- 50. DURACION TOTAL DE LAS PELICULAS DE CATEGORIA ACTION

SELECT SUM(f.length) AS total_duration 
FROM film f 
JOIN film_category fc 
ON fc.film_id = f.film_id
JOIN category c 
ON c.category_id = fc.category_id
WHERE c.name = 'Action';

-- 51. CREAR TABLA TEMPORAL LLAMADA "CLIENTE_RENTAS_TEMPORAL" PARA ALMACENAR EL TOTAL ALQUILERES POR CLIENTES

CREATE TEMP TABLE cliente_rentas_temporal AS
SELECT c.customer_id, c.first_name, c.last_name,
    COUNT(r.rental_id) AS total_rentals
FROM customer c
JOIN rental r 
ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

-- 52. CREA TABLA TEMPORAL LLAMADA "PELICULAS_ALQUILADAS" PARA ALMACENAR PELICULAS QUE HAN SIDO ALQUILADAS AL MENOS 10 VECES

CREATE TEMP TABLE peliculas_alquiladas AS
SELECT f.film_id, f.title,
COUNT (r.rental_id) AS total_rentals
FROM film f
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
HAVING COUNT (r.rental_id) >= 10;

-- 53. ENCONTRAR TITULO DE PELICULAS QUE HAN SIDO ALQUILADAS POR CLIENTES CON NOMBRE "Tammy Sanders" Y QUE AUN NO SE HAN DEVUELTO, ORDENADOS ALFABETICAMENTE POR TITULO PELICULA

SELECT f.title, c.first_name, c.last_name
FROM film f  
JOIN inventory i 
ON f.film_id = i.film_id
JOIN rental r 
ON i.inventory_id = r.inventory_id
JOIN customer c 
ON r.customer_id = c.customer_id
WHERE first_name = 'TAMMY' 
	AND last_name = 'SANDERS' 
	AND r.return_date IS NULL
ORDER BY f.title;

-- 54. NOMBRE ACTORES QUE HAN ACTUADO EN AL MENOS UNA PELICULA QUE PERTENECE A LA CATEGORIA 'Sci-Fi' ORDENANDO LOS RESULTADOS ALFABETICAMENTE POR APELLIDO

SELECT DISTINCT a.first_name, a.last_name
FROM actor a 
JOIN film_actor fa 
ON a.actor_id = fa.actor_id
JOIN film f 
ON fa.film_id = f.film_id
JOIN film_category fc 
ON f.film_id = fc.film_id
JOIN category c 
ON fc.category_id = c.category_id
WHERE c.name = 'Sci-Fi'
ORDER BY a.last_name ASC;

-- 55. NOMBRE Y APELLIDO DE ACTORES QUE HAN ACTUADO EN PELICULAS QUE SE ALQUILARON DESPUES DE QUE LA PELICULA 'Spartacus Cheaper' SE ALQUILARA POR PRIMERA VEZ. ORDENAR ALFABETICAMENTE POR APELLIDO

SELECT DISTINCT a.first_name, a.last_name
FROM actor a 
JOIN film_actor fa 
ON a.actor_id = fa.actor_id
JOIN film f 
ON f.film_id = fa.film_id
JOIN inventory i 
ON f.film_id = i.film_id
JOIN rental r 
ON r.inventory_id = i.inventory_id
WHERE r.rental_date > (
	SELECT MIN(r2.rental_date)
	FROM film f2 
	JOIN inventory i2 
		ON f2.film_id = i2.film_id
	JOIN rental r2
		ON i2.inventory_id = r2.inventory_id
	WHERE f2.title = 'SPARTACUS CHEAPER'
	)
	ORDER BY a.last_name ASC;

-- 56. NOMBRE Y APELLIDO DE ACTORES QE NO HAN ACTUADO EN NINGUNA PELICULA DE LA CATEGORIA MUSIC

SELECT a.first_name, a.last_name
FROM actor a 
WHERE a.actor_id NOT IN (
	SELECT DISTINCT a2.actor_id
	FROM actor a2 
	JOIN film_actor fa 
	ON a2.actor_id = fa.actor_id
	JOIN film f 
	ON fa.film_id = f.film_id
	JOIN film_category fc 
	ON f.film_id = fc.film_id
	JOIN category c 
	ON fc.category_id = c.category_id 
	WHERE c.name = 'Music'
	)
ORDER BY a.last_name ASC;


-- 57. PELICULAS ALQUILADAS POR MAS DE 8 DIAS

SELECT DISTINCT f.title
FROM rental r 
JOIN inventory i 
ON r.inventory_id = i.inventory_id
JOIN film f 
ON i.film_id = f.film_id
WHERE r.return_date IS NOT NULL
	AND r.return_date - r.rental_date > INTERVAL '8 days'
ORDER BY  f.title;

-- 58. TITULO DE TODAS LAS PELICULAS CON CATEGORIA ANIMATION

SELECT f.title
FROM film f 
JOIN film_category fc 
ON f.film_id = fc.film_id
JOIN category c 
ON fc.category_id = c.category_id
WHERE c.name = 'Animation'
ORDER BY f.title;

-- 59. PELICULAS MISMA DURACION QUE DANCING FEVER. ORDENAR ALFABETICAMENTE POR TITULO

SELECT title, length 
FROM film 
WHERE length = (
	SELECT length 
	FROM film
	WHERE title = 'DANCING FEVER'
	)
ORDER BY title;

-- 60. NOMBRE CLIENTES QUE HAN ALQUILADO AL MENOS 7 PELICULAS DISTINTAS, ORDENADOS ALFABETICAMENTE POR APELLIDOS.

SELECT c.first_name, c.last_name,
	COUNT(DISTINCT f.film_id) AS different_films
FROM customer c 
JOIN rental r 
ON c.customer_id = r.customer_id
JOIN inventory i 
ON r.inventory_id = i.inventory_id
JOIN film f 
ON i.film_id = f.film_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT f.film_id) >=7
ORDER BY c.last_name ASC

-- 61. TOTAL PELICULAS ALQUILADAS POR CATEGORIA Y MOSTRAR NOMBRE CATEGORIA Y RECUENTO ALQUILERES

SELECT c.name AS category_name,
		COUNT(r.rental_id) AS total_rentals
FROM category c 
JOIN film_category fc 
ON c.category_id = fc.category_id
JOIN film f 
ON fc.film_id = f.film_id
JOIN inventory i 
ON f.film_id = i.film_id
JOIN rental r 
ON i.inventory_id = r.inventory_id 
GROUP BY c.name
ORDER BY total_rentals DESC;

-- 62. Nº PELICULAS POR CATEGORIA ESTRENADAS EN 2006

 SELECT c.name AS category_name,
 		COUNT(fc.film_id) AS total_films
 FROM category c 
 JOIN film_category fc 
 ON c.category_id = fc.category_id 
 JOIN film f 
 ON fc.film_id = f.film_id
 WHERE f.release_year = 2006
 GROUP BY c.name
 ORDER BY total_films DESC;

-- 63. TODAS COMBINACIONES POSIBLES DE TRABAJADORES CON LAS TIENDAS QUE TENEMOS

SELECT s.first_name || ' ' || s.last_name AS employee_name, st.store_id
FROM staff s
CROSS JOIN store st
ORDER BY employee_name, st.store_id;

-- 64. CANTIDAD TOTAL DE PELICULAS ALQUILADAS POR CADA CLIENTE Y MUESTRA ID CLIENTE, NOMBRE Y APELLIDO Y CANTIDAD DE PELICULAS ALQUILADAS

SELECT c.customer_id, c.first_name || ' ' || c.last_name AS customer_name, 
	COUNT(r.rental_id) AS total_rentals
FROM customer c 
JOIN rental r
ON c.customer_id = r.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY total_rentals DESC;