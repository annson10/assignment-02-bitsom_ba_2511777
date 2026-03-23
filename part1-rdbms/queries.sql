-- Q1: List all customers from Mumbai along with their total order value
select c.customer_id,c.customer_name,c.customer_city,sum(p.unit_price*oi.quantity) as total_order_value from customers c 
left join orders o on o.customer_id=c.customer_id 
inner join order_items oi on oi.order_id=o.order_id 
inner join products p on p.product_id=oi.product_id
where c.customer_city='Mumbai'
group by c.customer_id,c.customer_name,c.customer_city;

-- Q2: Find the top 3 products by total quantity sold
select  p.product_id,p.product_name,sum(oi.quantity) as total_quantity_sold from products p inner join order_items oi on oi.product_id=p.product_id group by p.product_id,p.product_name order by total_quantity_sold desc limit 3;

-- Q3: List all sales representatives and the number of unique customers they have handled
select  s.sales_rep_id,s.sales_rep_name,count(distinct o.customer_id) as number_of_unique_customers_handled from sales_reps s left join orders o on o.sales_rep_id=s.sales_rep_id group by s.sales_rep_id,s.sales_rep_name;

-- Q4: Find all orders where the total value exceeds 10,000, sorted by value descending
select oi.order_id,o.order_date,o.customer_id,o.sales_rep_id,sum(oi.quantity*p.unit_price) as Total_value from order_items oi inner join products p on oi.product_id=p.product_id inner join orders o on o.order_id=oi.order_id  group by oi.order_id,o.order_date,o.customer_id,o.sales_rep_id having sum(oi.quantity*p.unit_price)>10000 order by Total_value desc;

-- Q5: Identify any products that have never been ordered
select p.product_id,p.product_name,p.category,p.unit_price from products p left join order_items oi on oi.product_id=p.product_id where oi.product_id is null;
