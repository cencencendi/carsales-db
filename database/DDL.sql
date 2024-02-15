-- 12th February 2024

DROP TABLE IF EXISTS bids;
DROP TABLE IF EXISTS product_onsales;
DROP TABLE IF EXISTS sellers;
DROP TABLE IF EXISTS buyers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS cities;


-- Create City table.
CREATE TABLE cities(
	city_id SERIAL PRIMARY KEY,
	name VARCHAR(50) UNIQUE NOT NULL,
	longitude DECIMAL(10,7) NOT NULL,
	latitude DECIMAL(10,7) NOT NULL
);

-- Create Seller table.
CREATE TABLE sellers(
	seller_id SERIAL PRIMARY KEY,
	name VARCHAR(50) UNIQUE NOT NULL,
	phone VARCHAR(15) NOT NULL,
	city_id INT,
	CONSTRAINT fk_city
		FOREIGN KEY(city_id)
			REFERENCES cities(city_id)
);

-- Create Buyer table.
CREATE TABLE buyers(
	buyer_id SERIAL PRIMARY KEY,
	name VARCHAR(50) UNIQUE NOT NULL,
	phone VARCHAR(15),
	city_id INT,
	CONSTRAINT fk_city
		FOREIGN KEY(city_id)
			REFERENCES cities(city_id)
);

-- Create Products table.
CREATE TABLE products(
	product_id SERIAL PRIMARY KEY,
	merk VARCHAR(50) NOT NULL,
	model VARCHAR(50) NOT NULL,
	body_type VARCHAR(50) NOT NULL,
	transmission_type VARCHAR(50) NOT NULL,
	year INT NOT NULL
);

-- Create Product on Sales table.
CREATE TABLE product_onsales(
	sales_id SERIAL PRIMARY KEY,
	seller_id INT NOT NULL,
	product_id INT NOT NULL,
	price INT NOT NULL,
	is_negotiable BOOLEAN NOT NULL,
	date_post DATE NOT NULL,
	CONSTRAINT fk_seller
		FOREIGN KEY(seller_id)
			REFERENCES sellers(seller_id),
	CONSTRAINT fk_product
		FOREIGN KEY(product_id)
			REFERENCES products(product_id)
);

-- Create Bids table.
CREATE TABLE bids(
	bid_id SERIAL PRIMARY KEY,
	sales_id INT NOT NULL,
	buyer_id INT NOT NULL,
	date_bid DATE NOT NULL,
	bid_price INT NOT NULL,
	CONSTRAINT fk_sale
		FOREIGN KEY(sales_id)
			REFERENCES product_onsales(sales_id),
	CONSTRAINT fk_buyer
		FOREIGN KEY(buyer_id)
			REFERENCES buyers(buyer_id)
)
