SELECT product_name, list_price
FROM production.products
WHERE category_id = 3;
 
SELECT DISTINCT city
FROM sales.customers
WHERE state = 'CA';

SELECT first_name, last_name, phone, city, state
FROM sales.customers
WHERE state = 'CA'
  AND city NOT IN ('Los Angeles', 'Campbell');

  INSERT INTO sales.customers (first_name, last_name, email, phone, street, city, state, zip_code)
VALUES ('John', 'Doe', 'john.doe@email.com', NULL, NULL, NULL, NULL, NULL);

UPDATE sales.customers
SET phone = '559-329-7915'
WHERE first_name = 'John' AND last_name = 'Doe';

DELETE FROM sales.customers
WHERE customer_id = 1446;

SELECT * 
FROM sales.customers
WHERE first_name = 'John' AND last_name = 'Doe';