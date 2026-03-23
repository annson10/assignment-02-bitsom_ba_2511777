-- CUSTOMERS TABLE
CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100) NOT NULL UNIQUE,
    customer_city VARCHAR(50) NOT NULL
);

-- PRODUCTS TABLE
CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
	CONSTRAINT chk_products_unit_price CHECK (unit_price > 0)
);

-- SALES REPRESENTATIVES
CREATE TABLE sales_reps (
    sales_rep_id VARCHAR(10) PRIMARY KEY,
    sales_rep_name VARCHAR(100) NOT NULL,
    sales_rep_email VARCHAR(100) NOT NULL UNIQUE,
    office_address VARCHAR(200) NOT NULL
);

-- ORDERS TABLE
CREATE TABLE orders (
    order_id VARCHAR(10) PRIMARY KEY,
    customer_id VARCHAR(10) NOT NULL,
    sales_rep_id VARCHAR(10) NOT NULL,
    order_date DATE NOT NULL,

    CONSTRAINT fk_orders_customer_id FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_orders_sales_rep_id FOREIGN KEY (sales_rep_id) REFERENCES sales_reps(sales_rep_id)
);

-- ORDER ITEMS TABLE
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id VARCHAR(10) NOT NULL,
    product_id VARCHAR(10) NOT NULL,
    quantity INTEGER NOT NULL,

	CONSTRAINT chk_order_items_quantity CHECK (quantity > 0),
    CONSTRAINT fk_order_items_order_id FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT fk_order_items_product_id FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- customers
INSERT INTO customers (customer_id, customer_name, customer_email, customer_city) VALUES
('C001', 'Rohan Mehta', 'rohan@gmail.com', 'Mumbai'),
('C002', 'Priya Sharma', 'priya@gmail.com', 'Delhi'),
('C003', 'Amit Verma', 'amit@gmail.com', 'Bangalore'),
('C004', 'Sneha Iyer', 'sneha@gmail.com', 'Chennai'),
('C005', 'Vikram Singh', 'vikram@gmail.com', 'Mumbai');

-- products
INSERT INTO products (product_id, product_name, category, unit_price) VALUES
('P001', 'Laptop', 'Electronics', 55000.00),
('P003', 'Desk Chair', 'Furniture', 8500.00),
('P005', 'Headphones', 'Electronics', 3200.00),
('P006', 'Standing Desk', 'Furniture', 22000.00),
('P007', 'Pen Set', 'Stationery', 250.00);


-- sales_reps
INSERT INTO sales_reps (sales_rep_id, sales_rep_name, sales_rep_email, office_address) VALUES
('SR01', 'Deepak Joshi', 'deepak@corp.com', 'Mumbai HQ, Nariman Point, Mumbai - 400021'),
('SR02', 'Anita Desai', 'anita@corp.com', 'Delhi Office, Connaught Place, New Delhi - 110001'),
('SR03', 'Ravi Kumar', 'ravi@corp.com', 'South Zone, MG Road, Bangalore - 560001'),
('SR04', 'Mehul Kapoor', 'mehul@corp.com', 'West Zone, Andheri East, Mumbai - 400069'),
('SR05', 'Sana Ali', 'sana@corp.com', 'North Zone, Sector 18, Noida - 201301');

-- orders
INSERT INTO orders (order_id, customer_id, sales_rep_id, order_date) VALUES
('ORD1114', 'C001', 'SR01', '2023-08-06'),
('ORD1002', 'C002', 'SR02', '2023-01-17'),
('ORD1132', 'C003', 'SR02', '2023-03-07'),
('ORD1076', 'C004', 'SR03', '2023-05-16'),
('ORD1075', 'C005', 'SR03', '2023-04-18'),
('ORD2001', 'C001', 'SR01', '2023-08-07'),
('ORD2002', 'C002', 'SR02', '2023-01-18'),
('ORD2003', 'C005', 'SR02', '2023-03-07');

-- order_items
INSERT INTO order_items (order_id, product_id, quantity) VALUES
('ORD1114', 'P007', 2),
('ORD1002', 'P005', 1),
('ORD1132', 'P007', 5),
('ORD1076', 'P006', 5),
('ORD1075', 'P003', 3),
('ORD2001', 'P005', 3),
('ORD2002', 'P005', 2),
('ORD2003', 'P006', 6);

