-- 1. Display all tables with their names and row count in the sales schema. 
SELECT Table_schema, Table_name, Table_rows
FROM Information_schema.Tables 
WHERE Table_schema = 'sales'; 

-- 2. Display all records of customers. 
SELECT * 
FROM customers ;

-- 3. Display the transactions related to Delhi market. 
SELECT * 
FROM transactions t
JOIN markets m ON t.market_code = m.markets_code
WHERE markets_name LIKE '%delhi%' ;

-- 4. Display a list of unique product codes that were sold in the Delhi market. 
SELECT distinct p.product_code 
FROM markets m
JOIN transactions t ON  m.markets_code = t.market_code 
JOIN products p ON t.product_code = p.product_code
WHERE markets_name LIKE '%delhi%' ;

-- 5. Display the period for which sales transactions are available.
SELECT 'First Date', Min(Order_Date)  
FROM transactions  
UNION  
SELECT 'Last Date', Max(Order_Date)  
FROM transactions ;

-- 6. Display the sales transactions for the year 2020.
SELECT t.*, d.* 
FROM transactions t 
JOIN date d ON t.order_date = d.date 
WHERE d.year=2020 ;

-- 7. Display the list of different currencies with their count in which transactions happened for AtliQ Hardware. 
SELECT currency, COUNT(currency)
FROM transactions 
GROUP BY currency ;

-- 8. Display the total revenue for the year 2020. 
WITH CTE1 AS
(SELECT *
FROM transactions t 
JOIN date d ON t.order_date = d.date
WHERE d.year = 2020),
CTE2 AS
(SELECT 
CASE WHEN currency = 'INR' then sales_amount ELSE sales_amount * 82 End as final_price
FROM CTE1) 
SELECT SUM(final_price) AS total_revenue
FROM CTE2 ;

-- 9. Display total revenue for the year 2020 in the month of January.
WITH CTE1 AS
(SELECT *
FROM transactions t 
JOIN date d ON t.order_date = d.date
WHERE d.year = 2020 AND d.month_name = "January" ),
CTE2 AS
(SELECT 
CASE WHEN currency = 'INR' then sales_amount ELSE sales_amount * 82 End as final_price
FROM CTE1) 
SELECT SUM(final_price) AS total_revenue
FROM CTE2 ;

-- 10. Display total revenue for the Delhi market in 2020.
WITH CTE1 AS
(SELECT *
FROM date d  
JOIN transactions t ON d.date = t.order_date
JOIN markets m ON t.market_code = m.markets_code
WHERE d.year = 2020 AND markets_name LIKE "%DELHI%"),
CTE2 AS
(SELECT 
CASE WHEN currency = 'INR' then sales_amount ELSE sales_amount * 82 End as final_price
FROM CTE1) 
SELECT SUM(final_price) AS total_revenue
FROM CTE2 ;

