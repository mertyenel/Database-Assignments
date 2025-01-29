--1) Her bir y�neticinin (manager) kimli�i (staff_id), ad� (first_name), soyad� (last_name) ve
--y�netti�i �al��anlar�n (staff) say�s�n� i�eren sorguyu yaz�n�z (25p).

SELECT m.staff_id, m.first_name, m.last_name, COUNT(s.staff_id) AS employee_count
FROM sales.staffs m
LEFT JOIN sales.staffs s ON m.staff_id = s.manager_id
GROUP BY m.staff_id, m.first_name, m.last_name
HAVING COUNT(s.staff_id) > 0;



--2) Belirli bir ma�azada (stores) stokta (stocks) bulunan ve stok miktar� (quantity) tam olarak
--26 olan t�m �r�nlerin (products) isimlerini (product_name) listeleyiniz (15p).
--ALL kullanarak yap�n�z!

SELECT p.product_name
FROM production.products p
WHERE p.product_id = ALL (
    SELECT s.product_id
    FROM production.stocks s
    WHERE  s.store_id = 1 AND s.quantity = 26
);
--3) Belirli bir ma�azada (stores) stokta (stocks) bulunan miktar� (quantity) 26�dan fazla olan
--�r�nlerin (products) isimlerini (product_name) listeleyiniz (15p).
--ANY kullanarak yap�n�z!

SELECT p.product_name
FROM production.products p
WHERE p.product_id = ANY (
    SELECT s.product_id
    FROM production.stocks s
    WHERE s.quantity > 26
);
--4) Stokta (Stocks) miktar� (quantity) tam olarak 30 olan ve ayn� zamanda �r�n (products) fiyat�
--(list_price) 3000�den d���k olan en az bir �r�n�n (products) bulundu�u ma�azalar�n
--(stores) isimlerini (store_name) listeleyiniz (15p).
--EXISTS kullanarak yap�n�z!


SELECT DISTINCT st.store_name
FROM sales.stores st
WHERE EXISTS (
    SELECT 1
    FROM production.stocks s
    JOIN production.products p ON s.product_id = p.product_id
    WHERE st.store_id = s.store_id AND s.quantity = 30 AND p.list_price < 3000
);


--5) �Baldwin Bikes� adl� ma�azadan (stores) al��veri� (orders) yapan her bir �ehirdeki (city)
--m��teri (customers) say�s�n� hesaplay�n�z. M��teri (customers) say�s� 10�dan az olan
--�ehirleri (city) se�iniz ve bu �ehirleri (city) m��teri (customers) say�s�na g�re artan s�rayla
--listeleyiniz (15p).
--HAVING kullanarak yap�n�z!


SELECT c.city, COUNT(c.customer_id) AS customer_count
FROM sales.orders o
JOIN sales.customers c ON o.customer_id = c.customer_id
JOIN sales.stores s ON o.store_id = s.store_id
WHERE s.store_name = 'Baldwin Bikes'
GROUP BY c.city
HAVING COUNT(c.customer_id) < 10
ORDER BY customer_count ASC;


--6) �Santa Cruz Bikes� adl� ma�azadan (stores) sipari� (orders) vermeyen m��terilerin
--(customers) isimlerini (first_name) ve soyisimlerini (last_name) listeleyiniz (15p).
--EXCEPT kullanarak yap�n�z!


SELECT c.first_name, c.last_name
FROM sales.customers c
EXCEPT
SELECT c.first_name, c.last_name
FROM sales.orders o
JOIN sales.stores s ON o.store_id = s.store_id
JOIN sales.customers c ON o.customer_id = c.customer_id
WHERE s.store_name = 'Santa Cruz Bikes';
