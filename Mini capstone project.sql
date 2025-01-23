-- ========================================================================================
-- ANALYSIS OF RENTAL PATTERNS AND FILMS POPULARITY IN MAVEN DATABASE
-- =========================================================================================


USE mavenmovies;
-- =============
-- 1.RENTAL TRENDS:
-- ==============

-- task1:  Analyze the monthly rental trends over the available data period.

SELECT MONTHNAME(rental_date) as Monthly_Rental, COUNT(rental_id) as Total_rental_orders
FROM rental
GROUP BY MONTHNAME(rental_date)
ORDER BY Total_rental_orders desc;

-- task2: Determine the peak rental hours in a day based on rental transactions.
SELECT DATE_FORMAT(rental_date, '%h %p') as rental_hour, COUNT(rental_id) as Total_rentals
FROM rental 
GROUP BY DATE_FORMAT(rental_date, '%h %p')
ORDER BY Total_rentals DESC;


-- =========================
--  2. FILM POPULARITY:	
-- ==========================

-- take 3: Identify the top 10 most rented films.
SELECT f.title, COUNT(r.rental_id) as count_of_rental
FROM film f 
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY count_of_rental DESC
LIMIT 10;


-- task 4:Determine which film categories have the highest number of rentals.

SELECT c.name as category_name, COUNT(r.rental_id) as Total_rental
FROM category c 
JOIN film_category fc
	ON c.category_id = fc.category_id
JOIN inventory i
	ON fc.film_id = i.film_id 
JOIN rental r
	ON i.inventory_id = r.inventory_id
GROUP BY c.name
ORDER BY Total_rental DESC;
 
 -- =========================
 -- 3. STORE PERFORMENCE:
 -- =========================
 
 -- task5:Identify which store generates the highest rental revenue.

SELECT s.store_id, SUM(p.amount) as Total_Revenue
FROM store s
JOIN inventory i
	ON s.store_id = i.store_id
JOIN rental r
	ON i.inventory_id = r.inventory_id
JOIN payment p 
	ON r.rental_id = p.rental_id
GROUP BY s.store_id
ORDER BY Total_Revenue DESC;

-- task 6: Determine the distribution of rentals by staff members to assess performance.

SELECT CONCAT(s.first_name," ", s.last_name) as staff_name, COUNT(r.rental_id) as Total_rentals
FROM staff s
JOIN rental r
	ON s.staff_id = r.staff_id
GROUP BY staff_name
ORDER BY Total_rentals DESC;







