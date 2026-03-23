-- Q1: List all customers along with the total number of orders they have placed
SELECT
    c.customer_id,
    c.name as customer_name,
    COUNT(o.order_id) AS total_orders
FROM read_csv_auto('D:\BitS\Assignments\assignment 2\datasets\customers.csv') c
LEFT JOIN read_json_auto('D:\BitS\Assignments\assignment 2\datasets\orders.json') o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.name
ORDER BY
    c.customer_id;


-- Q2: Find the top 3 customers by total order value
SELECT
    c.customer_id,
    c.name as customer_name,
    SUM(o.total_amount) AS total_order_value
FROM read_csv_auto('D:\BitS\Assignments\assignment 2\datasets\customers.csv') c
INNER JOIN read_json_auto('D:\BitS\Assignments\assignment 2\datasets\orders.json') o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.name
ORDER BY
    total_order_value DESC
LIMIT 3;


-- Q3: List all products purchased by customers from Bangalore
SELECT DISTINCT p.product_name
FROM read_csv_auto('D:\BitS\Assignments\assignment 2\datasets\customers.csv') c
INNER JOIN read_json_auto('D:\BitS\Assignments\assignment 2\datasets\orders.json') o
ON c.customer_id = o.customer_id
INNER JOIN read_parquet('D:\BitS\Assignments\assignment 2\datasets\products.parquet') p
ON o.order_id = p.order_id
WHERE c.city = 'Bangalore';


-- Q4: Join all three files to show: customer name, order date, product name, and quantity
SELECT 
    c.name as customer_name,
    o.order_date,
    p.product_name,
    p.quantity
FROM read_csv_auto('D:\BitS\Assignments\assignment 2\datasets\customers.csv') c
INNER JOIN read_json_auto('D:\BitS\Assignments\assignment 2\datasets\orders.json') o
ON c.customer_id = o.customer_id
INNER JOIN read_parquet('D:\BitS\Assignments\assignment 2\datasets\products.parquet') p
ON o.order_id = p.order_id
ORDER BY o.order_date;

