use mavenmovies;

-- Basic Aggregate Functions: 

-- Question 1: Retrieve the total number of rentals made in the Sakila database. 
-- Hint: Use the COUNT() function. 

select * from rental;
select count(rental_id) from rental;

-- Question 2: Find the average rental duration (in days) of movies rented from the Sakila database.
-- Hint: Utilize the AVG() function.

select avg(datediff(return_date,rental_date)) from rental;

-- String Functions:

-- Question 3: Display the first name and last name of customers in uppercase.
-- Hint: Use the UPPER () function.

select * from customer;
select upper(first_name), upper(last_name) from customer;

-- Question 4: Extract the month from the rental date and display it alongside the rental ID.
-- Hint: Employ the MONTH() function.

select rental_id, month(rental_date) from rental;

-- GROUP BY:
 
-- Question 5: Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
-- Hint: Use COUNT () in conjunction with GROUP BY.

select customer_id, count(rental_id) from rental group by customer_id;

-- Question 6: Find the total revenue generated by each store.
-- Hint: Combine SUM() and GROUP BY.

select * from store;
select * from staff;
select* from payment;
select store.store_id, sum(amount) as total_revenue from store left join staff on store.store_id 
left join payment on staff.staff_id group by store.store_id;

-- Joins: 

-- Question 7: Display the title of the movie, customer's first name, and last name who rented it.
-- Hint: Use JOIN between the film, inventory, rental, and customer tables.

select * from film;
select * from inventory;
select film.title, customer.first_name , customer.last_name from rental 
join inventory on rental.inventory_id = inventory.inventory_id
join film on inventory.film_id = film.film_id
join customer on rental.customer_id = customer.customer_id;

-- Question 8: Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
-- Hint: Use JOIN between the film actor, film, and actor tables.

select * from film_actor; 
select * from actor;
select actor.first_name, actor.last_name from film_actor
join film on film_actor.film_id = film.film_id
join actor on film_actor.actor_id = actor.actor_id
where film.title = 'Gone with the Wind';

-- GROUP BY:

-- Question 1: Determine the total number of rentals for each category of movies.
-- Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.

select film_category.category_id, Count(*) as RentalCount from rental
join inventory on rental.inventory_id = inventory.inventory_id
join film on inventory.film_id = film.film_id
join film_category on film.film_id = film_category.film_id
group by film_category.category_id;

-- Question 2: Find the average rental rate of movies in each language.
-- Hint: JOIN film and language tables, then use AVG () and GROUP BY.

select * from language;
select language.name, avg(rental_rate) from film
join language on film.language_id = language.language_id
group by language.name;

-- Joins:

-- Question 3: Retrieve the customer names along with the total amount they've spent on rentals.
-- Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.

select customer.customer_id, customer.first_name, customer.last_name, sum(payment.amount) as TotalAmountSpent from customer
join payment on customer.customer_id = payment.customer_id
group by customer.customer_id, customer.first_name, customer.last_name;

-- Question 4: List the titles of movies rented by each customer in a particular city (e.g., 'London').
-- Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.

select film.title, customer.customer_id, customer.first_name, customer.last_name from customer 
join address on customer.address_id = address.address_id
join city on address.city_id = city.city_id
join rental on customer.customer_id = rental.customer_id
join inventory on rental.inventory_id = inventory.inventory_id
join film on inventory.film_id = film.film_id
where city.city = 'London'
order by film.title,customer.customer_id;

-- Advanced Joins and GROUP BY:

-- Question 5: Display the top 5 rented movies along with the number of times they've been rented.
-- Hint: JOIN film, inventory, and rental tables, then use cOUNT() and GROUP BY, and limit the results.

Select film.title as MovieTitle, count(rental.rental_id) as RentalCount from film
join inventory on film.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
group by film.title 
order by RentalCount desc 
limit 5;

-- Question 6: Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
-- Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.

Select customer.customer_id,customer.first_name,customer.last_name from customer
join rental on customer.customer_id = rental.customer_id
join inventory on rental.inventory_id = inventory.inventory_id
join store on inventory.store_id = store.store_id
where store.store_id in (1, 2)
group by customer.customer_id, customer.first_name, customer.last_name
having COUNT(distinct store.store_id) = 2;





