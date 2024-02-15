-- Transactional Query
-- Cars from 2015 and above
SELECT 
	sales_id,
	product_id,
	model,
	year,
	price
FROM products
JOIN product_onsales USING(product_id)
WHERE year >= 2015
ORDER BY 3,4;

-- Add 1 bid for a product
-- INSERT INTO bids(bid_id, sales_id, buyer_id, date_bid, bid_price)
-- VALUES(216, 46, 75, '2023-03-01', 119100000);

SELECT * FROM bids;

-- All cars sold by Henry Best
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


-- Find the cheapest car based on search keyword "Alya"
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

-- Find the closest sold car based on city_id (Samarinda => city_id = 6472)
-- Create function first to calculate the distance
CREATE OR REPLACE FUNCTION calculate_distance(
    lat1 DOUBLE PRECISION,
    lon1 DOUBLE PRECISION,
    lat2 DOUBLE PRECISION,
    lon2 DOUBLE PRECISION
) RETURNS DOUBLE PRECISION AS $$
DECLARE
    distance DOUBLE PRECISION;
BEGIN
    distance := SQRT((lat2 - lat1)^2 + (lon2 - lon1)^2);
    RETURN distance;
END;
$$ LANGUAGE plpgsql;

-- Get the longitude and latitude of Kota Samarinda
WITH city_location AS (
	SELECT 
		latitude,
		longitude
	FROM cities
	WHERE city_id = 6472
), 
nearest_city AS (
	SELECT
		city_id,
		name,
		calculate_distance(
			(SELECT latitude FROM city_location),
			(SELECT longitude FROM city_location),
			latitude,
			longitude
		) AS distance
	FROM cities
	WHERE city_id <> 6472
	ORDER BY 3
	LIMIT 1
)
SELECT 
	sales_id,
	product_id,
	merk,
	model,
	year,
	price,
	(SELECT distance FROM nearest_city)
FROM product_onsales
JOIN sellers USING (seller_id)
JOIN products USING (product_id)
WHERE city_id = (SELECT city_id FROM nearest_city);

