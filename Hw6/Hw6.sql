--1) Her bir yöneticinin (manager) kimliði (staff_id), adý (first_name), soyadý (last_name) ve
--yönettiði çalýþanlarýn (staff) sayýsýný içeren sorguyu yazýnýz (25p).

SELECT m.staff_id, m.first_name, m.last_name, COUNT(s.staff_id) AS employee_count
FROM sales.staffs m
LEFT JOIN sales.staffs s ON m.staff_id = s.manager_id
GROUP BY m.staff_id, m.first_name, m.last_name
HAVING COUNT(s.staff_id) > 0;



--2) Belirli bir maðazada (stores) stokta (stocks) bulunan ve stok miktarý (quantity) tam olarak
--26 olan tüm ürünlerin (products) isimlerini (product_name) listeleyiniz (15p).
--ALL kullanarak yapýnýz!

SELECT p.product_name
FROM production.products p
WHERE p.product_id = ALL (
    SELECT s.product_id
    FROM production.stocks s
    WHERE  s.store_id = 1 AND s.quantity = 26
);
--3) Belirli bir maðazada (stores) stokta (stocks) bulunan miktarý (quantity) 26’dan fazla olan
--ürünlerin (products) isimlerini (product_name) listeleyiniz (15p).
--ANY kullanarak yapýnýz!

SELECT p.product_name
FROM production.products p
WHERE p.product_id = ANY (
    SELECT s.product_id
    FROM production.stocks s
    WHERE s.quantity > 26
);
--4) Stokta (Stocks) miktarý (quantity) tam olarak 30 olan ve ayný zamanda ürün (products) fiyatý
--(list_price) 3000’den düþük olan en az bir ürünün (products) bulunduðu maðazalarýn
--(stores) isimlerini (store_name) listeleyiniz (15p).
--EXISTS kullanarak yapýnýz!


SELECT DISTINCT st.store_name
FROM sales.stores st
WHERE EXISTS (
    SELECT 1
    FROM production.stocks s
    JOIN production.products p ON s.product_id = p.product_id
    WHERE st.store_id = s.store_id AND s.quantity = 30 AND p.list_price < 3000
);


--5) “Baldwin Bikes” adlý maðazadan (stores) alýþveriþ (orders) yapan her bir þehirdeki (city)
--müþteri (customers) sayýsýný hesaplayýnýz. Müþteri (customers) sayýsý 10’dan az olan
--þehirleri (city) seçiniz ve bu þehirleri (city) müþteri (customers) sayýsýna göre artan sýrayla
--listeleyiniz (15p).
--HAVING kullanarak yapýnýz!


SELECT c.city, COUNT(c.customer_id) AS customer_count
FROM sales.orders o
JOIN sales.customers c ON o.customer_id = c.customer_id
JOIN sales.stores s ON o.store_id = s.store_id
WHERE s.store_name = 'Baldwin Bikes'
GROUP BY c.city
HAVING COUNT(c.customer_id) < 10
ORDER BY customer_count ASC;


--6) “Santa Cruz Bikes” adlý maðazadan (stores) sipariþ (orders) vermeyen müþterilerin
--(customers) isimlerini (first_name) ve soyisimlerini (last_name) listeleyiniz (15p).
--EXCEPT kullanarak yapýnýz!


SELECT c.first_name, c.last_name
FROM sales.customers c
EXCEPT
SELECT c.first_name, c.last_name
FROM sales.orders o
JOIN sales.stores s ON o.store_id = s.store_id
JOIN sales.customers c ON o.customer_id = c.customer_id
WHERE s.store_name = 'Santa Cruz Bikes';
