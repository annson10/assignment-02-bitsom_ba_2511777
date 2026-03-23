-- dim_date
CREATE TABLE dim_date (
    date_id INT PRIMARY KEY,             
    full_date DATE NOT NULL,
	year_num INT NOT NULL,
	month_num INT NOT NULL,
    day_of_month INT NOT NULL
);

-- dim_store
CREATE TABLE dim_store (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    store_city VARCHAR(50) NOT NULL
);

-- dim_product
CREATE TABLE dim_product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(30) NOT NULL
);


-- fact_sales
CREATE TABLE fact_sales (
    sales_id INT PRIMARY KEY,
    transaction_id VARCHAR(20) NOT NULL,
    date_id INT NOT NULL,
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    customer_id VARCHAR(20) NOT NULL,
    units_sold INT NOT NULL,
    unit_price DECIMAL(12,2) NOT NULL,
	total_amount DECIMAL(14,2) NOT NULL,

    CONSTRAINT chk_total_amount 
        CHECK (total_amount = units_sold * unit_price),
    CONSTRAINT FK_fact_sales_date
        FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    CONSTRAINT FK_fact_sales_store
        FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    CONSTRAINT FK_fact_sales_product
        FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);


-- insert dim_date
INSERT INTO dim_date (date_id, full_date,year_num,month_num, day_of_month)
VALUES
(1, '2023-01-15', 2023, 1, 15),
(2, '2023-02-05', 2023, 2, 5),
(3, '2023-02-20', 2023, 2, 20),
(4, '2023-03-31', 2023, 3, 31),
(5, '2023-06-04', 2023, 6, 4),
(6, '2023-08-09', 2023, 8, 9),
(7, '2023-08-15', 2023, 8, 15),
(8, '2023-08-29', 2023, 8, 29),
(9, '2023-10-20', 2023, 10, 20),
(10, '2023-10-26', 2023, 10, 26),
(11, '2023-12-08', 2023, 12, 8),
(12, '2023-12-12', 2023, 12, 12);

-- insert dim_store
INSERT INTO dim_store (store_id, store_name, store_city)
VALUES
(1, 'Chennai Anna', 'Chennai'),
(2, 'Delhi South', 'Delhi'),
(3, 'Bangalore MG', 'Bangalore'),
(4, 'Pune FC Road', 'Pune'),
(5, 'Mumbai Central', 'Mumbai');

-- insert dim_product
INSERT INTO dim_product (product_id, product_name, category)
VALUES
(1, 'Speaker', 'Electronics'),
(2, 'Tablet', 'Electronics'),
(3, 'Phone', 'Electronics'),
(4, 'Smartwatch', 'Electronics'),
(5, 'Atta 10kg', 'Groceries'),
(6, 'Jeans', 'Clothing'),
(7, 'Biscuits', 'Groceries'),
(8, 'Jacket', 'Clothing');


-- insert fact_sales
INSERT INTO fact_sales
(sales_id, transaction_id, date_id, store_id, product_id, customer_id, units_sold, unit_price,total_amount)
VALUES
(1,  'TXN5000', 8, 1, 1, 'CUST045',  3, 49262.78, 147788.34),
(2,  'TXN5001', 12, 1, 2, 'CUST021', 11, 23226.12, 255487.32),
(3,  'TXN5002', 2, 1, 3, 'CUST019', 20, 48703.39, 974067.80),
(4,  'TXN5003', 3, 2, 2, 'CUST007', 14, 23226.12, 325165.68),
(5,  'TXN5004', 1, 1, 4, 'CUST004', 10, 58851.01, 588510.10),
(6,  'TXN5005', 6, 3, 5, 'CUST027', 12, 52464.00, 629568.00),
(7,  'TXN5006', 4, 4, 4, 'CUST025',  6, 58851.01, 353106.06),
(8,  'TXN5007', 10, 4, 6, 'CUST041', 16,  2317.47, 37079.52),
(9,  'TXN5008', 11, 3, 7, 'CUST030',  9, 27469.99, 247229.91),
(10, 'TXN5009', 7, 3, 4, 'CUST020',  3, 58851.01, 176553.03),
(11, 'TXN5010', 5, 1, 8, 'CUST031', 15, 30187.24, 452808.60),
(12, 'TXN5011', 9, 5, 6, 'CUST045', 13,  2317.47, 30127.11);
