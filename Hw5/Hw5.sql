--1. Soru
SELECT production.products.product_name, production.brands.brand_name, categories.category_name
FROM production.products 
INNER JOIN production.brands 
ON production.products.brand_id = production.brands.brand_id
INNER JOIN production.categories 
ON  production.products.category_id = production.categories.category_id
WHERE  production.products.model_year = 2016 AND  production.products.list_price > 500;


--2. Soru
SELECT COUNT( production.products.product_id) AS siparis_edilmemis_urun_sayisi
FROM  production.products
LEFT JOIN sales.order_items 
ON Products.product_id = order_items.product_id
WHERE sales.order_items.product_id IS NULL;


--3. Soru
SELECT MAX(sales.order_items.list_price * sales.order_items.quantity) as max_siparis_ucreti
FROM sales.order_items
RIGHT JOIN sales.orders 
ON sales.order_items.order_id = sales.orders.order_id
RIGHT JOIN sales.customers 
ON sales.orders.customer_id = sales.customers.customer_id
WHERE sales.customers.first_name = 'Mercy' and sales.customers.last_name = 'Brown';


--4. Soru
SELECT sales.stores.store_name
FROM sales.stores
FULL JOIN sales.orders
ON Stores.store_id = orders.store_id
WHERE orders.order_id IS NULL;


--5. Soru
SELECT DISTINCT(p1.product_name)
FROM production.products p1
JOIN production.products p2 
ON p1.category_id = p2.category_id
WHERE p1.product_name <> p2.product_name 
AND p1.category_id = (SELECT category_id FROM production.categories WHERE category_name = 'Cruisers Bicycles');


--6. Soru
SELECT COUNT(DISTINCT production.products.product_id) AS toplam_trek
FROM production.products
WHERE brand_id = (SELECT brand_id FROM production.brands WHERE brand_name = 'Trek');
