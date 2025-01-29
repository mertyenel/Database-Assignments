--1
CREATE PROCEDURE ListCustomersUsingExcept
    @Store1ID INT,
    @Store2ID INT
AS
BEGIN
    SELECT DISTINCT c.customer_id, c.first_name, c.last_name
    FROM sales.customers c
    INNER JOIN sales.orders o ON c.customer_id = o.customer_id
    WHERE o.store_id = @Store1ID

    EXCEPT

    -- İkinci mağazadan sipariş veren müşteriler
    SELECT DISTINCT c.customer_id, c.first_name, c.last_name
    FROM sales.customers c
    INNER JOIN sales.orders o ON c.customer_id = o.customer_id
    WHERE o.store_id = @Store2ID;
END;
GO


EXEC ListCustomersUsingExcept @Store1ID = 1, @Store2ID = 2;


--2.soru
CREATE PROCEDURE GetMaxOrderByCustomerName
    @CustomerName VARCHAR(50)
AS
BEGIN
    SELECT TOP 1 o.order_id, o.order_date, SUM(oi.quantity * oi.list_price) AS TotalOrderValue
    FROM sales.orders o
    INNER JOIN sales.order_items oi ON o.order_id = oi.order_id
    INNER JOIN sales.customers c ON o.customer_id = c.customer_id
    WHERE c.first_name = @CustomerName
    GROUP BY o.order_id, o.order_date
    ORDER BY TotalOrderValue DESC;
END;
GO

EXEC GetMaxOrderByCustomerName @CustomerName = 'Garry';



--3
CREATE PROCEDURE GetCustomerOrdersByStore
    @CustomerID INT
AS
BEGIN
    SELECT s.store_id, s.store_name, SUM(oi.quantity * oi.list_price) AS TotalOrderValue
    FROM sales.orders o
    INNER JOIN sales.order_items oi ON o.order_id = oi.order_id
    INNER JOIN sales.stores s ON o.store_id = s.store_id
    WHERE o.customer_id = @CustomerID
    GROUP BY s.store_id, s.store_name;
END;
GO

EXEC GetCustomerOrdersByStore @CustomerID = 1;


--4
CREATE PROCEDURE GetCategoriesWithSalesOver
    @MinSales INT = 100
AS
BEGIN
    SELECT 
        c.category_id,
        c.category_name,
        p.product_name,
        SUM(oi.quantity) AS TotalQuantitySold
    FROM sales.order_items oi
    INNER JOIN production.products p ON oi.product_id = p.product_id
    INNER JOIN production.categories c ON p.category_id = c.category_id
    GROUP BY c.category_id, c.category_name, p.product_name
    HAVING SUM(oi.quantity) > @MinSales;
END;
GO

EXEC GetCategoriesWithSalesOver @MinSales = 100;


--5
CREATE PROCEDURE GetProductsByPriceAndStock
    @MinPrice DECIMAL(10, 2),
    @MinStock INT
AS
BEGIN
    SELECT DISTINCT 
        p.product_id,
        p.product_name,
        p.list_price,
        s.store_id,
        st.quantity AS stock_quantity 
    FROM production.products p
    INNER JOIN production.stocks st ON p.product_id = st.product_id
    INNER JOIN sales.stores s ON st.store_id = s.store_id
    WHERE p.list_price > @MinPrice
      AND st.quantity > @MinStock; 
END;
GO

EXEC GetProductsByPriceAndStock @MinPrice = 500, @MinStock = 10;

--6
DROP PROCEDURE GetProductsByPriceAndStock
