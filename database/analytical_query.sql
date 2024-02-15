-- Creating Analytical Query.
-- Rank of car's popularity based on count of bid.
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

-- Compare the car's price with average price per city
SELECT 
	cities.name,
	merk,
	model,
	year,
	price,
	CAST(AVG(price) OVER(PARTITION BY cities.name)AS INT) AS avg_car_city 
FROM product_onsales
JOIN products USING (product_id)
JOIN sellers USING (seller_id)
JOIN cities USING (city_id);

-- Comparison of the date the user made a bid with the next bid and the bid price given.
WITH bid_info AS (
    SELECT 
        model,
        buyer_id,
        date_bid AS first_bid_date,
        LEAD(date_bid) OVER (PARTITION BY buyer_id ORDER BY date_bid) AS next_bid_date,
        bid_price AS first_bid_price,
        LEAD(bid_price) OVER (PARTITION BY buyer_id ORDER BY date_bid) AS next_bid_price
    FROM bids
	JOIN product_onsales USING (sales_id)
	JOIN products USING (product_id)
)
SELECT
    model,
    buyer_id,
    first_bid_date,
    next_bid_date,
    first_bid_price,
    next_bid_price
FROM bid_info
WHERE next_bid_date IS NOT NULL
ORDER BY 1;

-- Comparing the percentage difference between the average car price by model and the average bid price
-- offered by customers in the last 6 months.
WITH avg_bid_last_6month AS (
	SELECT
		model,
		CAST(AVG(bid_price) AS INT) AS avg_bid_6month
	FROM bids
	JOIN product_onsales USING (sales_id)
	JOIN products USING (product_id)
	WHERE EXTRACT('month' FROM date_bid) BETWEEN 1 AND 6
	GROUP BY 1
),
avg_price AS(
	SELECT 
		model,
		CAST(AVG(price) AS INT) AS avg_price
	FROM product_onsales
	JOIN products USING (product_id)
	GROUP BY 1
)
SELECT 
	model,
	avg_price,
	avg_bid_6month,
	(avg_price - avg_bid_6month) AS difference,
	CAST((avg_price - avg_bid_6month)::FLOAT/avg_price * 100 AS DECIMAL(10,2)) AS difference_percent
FROM avg_price
JOIN avg_bid_last_6month USING (model)
ORDER BY 1;

-- Create a window function of the average bid price of a car brand and model for the last 6 months
WITH window_function AS (
	SELECT 
		model,
		bid_price,
		DENSE_RANK() OVER(PARTITION BY model ORDER BY EXTRACT('month' FROM date_bid)) AS ranks
	FROM bids
	JOIN product_onsales USING (sales_id)
	JOIN products USING (product_id)
	WHERE model = 'Daihatsu Alya'
)
SELECT
	model,
	(SELECT AVG(bid_price) 
	 	FROM window_function 
	 	WHERE ranks BETWEEN 1 AND 6) AS m_min_6,
	(SELECT AVG(bid_price) 
	 	FROM window_function 
	 	WHERE ranks BETWEEN 1 AND 5) AS m_min_5,
	(SELECT AVG(bid_price) 
	 	FROM window_function 
	 	WHERE ranks BETWEEN 1 AND 4) AS m_min_4,
	(SELECT AVG(bid_price) 
	 	FROM window_function 
	 	WHERE ranks BETWEEN 1 AND 3) AS m_min_3,
	(SELECT AVG(bid_price) 
	 	FROM window_function 
	 	WHERE ranks BETWEEN 1 AND 2) AS m_min_2,
	(SELECT AVG(bid_price) 
	 	FROM window_function 
	 	WHERE ranks = 1) AS m_min_1
FROM window_function
GROUP BY 1;