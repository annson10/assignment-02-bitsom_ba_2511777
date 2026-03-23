## ETL Decisions

### Decision 1 — Standardized mixed date formats
Problem: The `retail_transactions.csv` dataset contained inconsistent date formats such as `29/08/2023`, `12-12-2023`, and `2023-02-05`. These variations make it difficult to perform reliable time-based analysis and can cause errors during data loading into the data warehouse.  

Resolution: I transformed all dates into a standardized ISO format (`YYYY-MM-DD`) before loading them into dim_date table, so values like `29/08/2023`, `20-02-2023`, and `15/08/2023` became `2023-08-29`, `2023-02-20`, and `2023-08-15`. Additionally, derived attributes such as `year_num`, `month_num`, and `day_of_month` were extracted from the cleaned date to support efficient analytical queries.

### Decision 2 — Normalized category values
Problem: The raw product category field contained inconsistent casing and formatting (e.g., `electronics`, `Electronics`, `ELECTRONICS`, `Grocery`, `Groceries`). This would lead to incorrect aggregations when grouping data by category.  

​Resolution: I standardized category names before loading `dim_product`, mapping lowercase `electronics` to `Electronics` and consolidating both `Grocery` and `Groceries` into a single warehouse value, `Groceries`, so reporting by category would not split the same business concept into multiple groups.  

### Decision 3 — Fixed missing store city values
Problem: Some rows had blank `store_city` values even though the `store_name` was present, such as `Mumbai Central` in TXN5033, `Chennai Anna` in TXN5044, and `Delhi South` in TXN5082.  

Resolution: I filled missing city values using the repeated store-to-city pattern already visible elsewhere in the dataset, such as `Mumbai Central` -> `Mumbai`, `Chennai Anna` -> `Chennai`, `Delhi South` -> `Delhi`, `Pune FC Road` -> `Pune`, and `Bangalore MG` -> `Bangalore`.
