# Car-Sales Database.

## Background.
This repository is a final project of Pacmann's SQL & Relational Database online class. The task given to the students was to design a relational database to track car sales that has the following features:
  1. Every seller on this database can offer more than one of their second-hand car.
  2. Before selling their cars, the seller must complete their data such as name, phone contact, and address (the city they live in).
  3. All sellers will offer their products through an advertisement, which will be shown on a website.
  4. The advertisement will contain a title, detailed product information, and the seller's phone contact.
  5. The advertisement must include the brand, model, body type, transmission type, car production year, and price.
  6. Buyers can search for products based on the seller's location, car brand, or body type.
  7. If the buyer is interested in purchasing a car, they can bid on the price if the seller allows it.
  8. Purchase transaction is done outside the application, so it is not in the project's scope.

## Entity Relationship Diagram (ERD).
I proposed a relational database consisting of multiple tables (sellers, buyers, cities, products, product_onsales, and bids) as the optimal solution to meet the required features. The tables' Entity Relationship Diagram (ERD) can be seen below.
![ERD](https://github.com/cencencendi/carsales-db/assets/85205431/e7e4f112-222f-4f9a-9619-a6356ae81d28)


## DBMS.
I used PostgreSQL 16 and pgAdmin4 8.3.

## How to use this database?
* Step 1.
  Clone the repository by copy and paste the provided code into your terminal or command prompt. Once done, you can just run the code to complete the process. And don't forget to make sure you have installed git on your PC.
  
  `git clone https://github.com/cencencendi/carsales-db.git`
* Step 2.
  Install [PostgreSQL](https://www.postgresql.org/download/) and [pgAdmin4](https://www.pgadmin.org/download/).
* Step 3.
  Open pgAdmin4 and create a database.
* Step 4.
  To create the tables, run `DDL.sql` on the query tool (by clicking the database and triangle icon next to the 'Object Explorer' text at the top left corner).
* Step 5.
  Import the CSV files into each table as its name. If you want to create another dummy data, I have provided Python code to generate those dummy data for each table (dummy_data/Dummy_data_Final_Project_SQL.ipynb) and then import it to the tables.
* Step 6.
  Now you are free to make queries with `carsales-db`.

## Query Samples.
### 1. Find the most affordable car by searching for "Alya" as the keyword.
```
SELECT 
	product_id,
	merk,
	model,
	year,
	price
FROM product_onsales
JOIN products USING (product_id)
WHERE model LIKE '%Alya'
ORDER BY price;
```
`Output`: <img width="1215" alt="Query 1" src="https://github.com/cencencendi/carsales-db/assets/85205431/817706ee-9a09-4ace-991b-117107ac5ce1">

### 2. Find all cars that are sold by Henry Best.
```
SELECT 
	sales_id,
	merk,
	model,
	year,
	price,
	date_post
FROM product_onsales
JOIN sellers USING(seller_id)
JOIN products USING(product_id)
WHERE sellers.name = 'Henry Best'
ORDER BY date_post;
```
`Output`: <img width="1215" alt="Screenshot 2024-02-15 at 21 35 53" src="https://github.com/cencencendi/carsales-db/assets/85205431/9dcc8d72-2170-4045-8932-8c4c8dfa5fce">

### 3. Sort all car models based on their popularity, which should be determined by the number of bids received.
```
WITH product_counts AS (
    SELECT
        model,
        COUNT(product_id) AS count_product
    FROM product_onsales
	JOIN products USING (product_id)
    GROUP BY model
),
bid_counts AS (
    SELECT
        model,
        COUNT(product_id) AS count_bid
    FROM bids
	JOIN product_onsales USING (sales_id)
	JOIN products USING (product_id)
    GROUP BY model
)
SELECT
    pc.model,
    pc.count_product,
    bc.count_bid
FROM product_counts pc
JOIN bid_counts bc USING (model)
ORDER BY pc.count_product DESC;
```
`Output`: <img width="1215" alt="Screenshot 2024-02-15 at 21 40 49" src="https://github.com/cencencendi/carsales-db/assets/85205431/72a405de-09a2-4458-bc46-b3fb06c58bc7">
