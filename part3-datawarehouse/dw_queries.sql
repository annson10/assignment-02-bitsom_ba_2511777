-- Q1: Total sales revenue by product category for each month
select dp.category,dd.month_num,sum(fs.total_amount) as total_sales_revenue from fact_sales as fs inner join dim_product as dp on dp.product_id=fs.product_id inner join dim_date as dd on dd.date_id=fs.date_id group by dp.category,dd.month_num order by dp.category,dd.month_num;

-- Q2: Top 2 performing stores by total revenue
select  ds.store_name,sum(fs.total_amount) as total_revenue from fact_sales  as fs inner join dim_store as ds on fs.store_id=ds.store_id group by ds.store_name order by total_revenue desc limit 2;


-- Q3: Month-over-month sales trend across all stores
SELECT 
    dd.year_num,
    dd.month_num,
    ifnull(SUM(fs.total_amount),0) AS monthly_revenue,
    ifnull(LAG(SUM(fs.total_amount)) OVER (ORDER BY dd.year_num, dd.month_num),0) AS previous_month_revenue,
    ifnull(SUM(fs.total_amount) 
      - LAG(SUM(fs.total_amount)) OVER (ORDER BY dd.year_num, dd.month_num),0) AS revenue_change
FROM fact_sales fs
inner join dim_date dd ON fs.date_id = dd.date_id
GROUP BY dd.year_num, dd.month_num
ORDER BY dd.year_num, dd.month_num;