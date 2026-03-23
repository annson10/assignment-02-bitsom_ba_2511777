## Anomaly Analysis
- Insert Anomaly

    A new product cannot be added independently unless an associated order row is also created, because product details (`product_id`, `product_name`, `category`, `unit_price`) exist only inside order records.
    
    For example, product P008 (`Webcam`, `Electronics`, `2100`) appears in row ORD1185, where it is stored together with customer C003, order date 2023-06-15, and sales rep SR03, so there is no separate place to insert a new product which hasn't been ordered yet, without inventing an order. This leads to invalid data insertion, resulting in creation of a fake order.


- Update Anomaly

    Sales representative SR01 (`Deepak Joshi`) has inconsistent office_address values across rows, which means changing one fact requires updating many rows and can leave the data inconsistent.
    
    For example, rows ORD1114 and ORD1091 store SR01 with office_address = "`Mumbai HQ, Nariman Point, Mumbai - 400021`", while rows ORD1180, ORD1173, ORD1170, ORD1183, ORD1181, ORD1178, ORD1174, ORD1177, and ORD1176 store the same SR01 with office_address = "`Mumbai HQ, Nariman Pt, Mumbai - 400021`".


- Delete Anomaly

    Deleting a row can unintentionally remove important unrelated data, that should continue to exist even if the order is gone. For example, row ORD1185 is the only visible row containing product P008 (`Webcam`) with category Electronics and unit price 2100, so if that row were deleted, the system would also lose the only stored details of that product.


## Normalization Justification
    Keeping everything in one table may look simpler at first, but this dataset shows why that approach quickly becomes unreliable and hard to maintain. In orders_flat.csv, customer details, product details, and sales representative details are repeated in every order row, even though they describe different business entities. For example, customer C001 (Rohan Mehta) appears in many rows with the same email and city, and customer C005 (Vikram Singh) is also repeated across multiple orders. If the customer updates their email address, it must be modified in every corresponding row. Missing even one update leads to inconsistent data.

    This design creates obvious update problems. Sales representative SR01 (Deepak Joshi) appears with two versions of the office address: "Mumbai HQ, Nariman Point, Mumbai - 400021" in rows such as ORD1114 and ORD1091, but "Mumbai HQ, Nariman Pt, Mumbai - 400021" in rows such as ORD1180, ORD1173, and ORD1170. That means one real-world fact is stored many times and can become inconsistent when only some rows are updated.

    It also creates insert and delete problems. Product P008 (Webcam) appears in row ORD1185, so if the company wanted to add that product before any order existed, the flat table would not provide a clean place to store it independently. Similarly, deleting the ORD1185 row would also remove the only stored record of that product’s name, category, and price.

    Because of these issues, I would refute the manager’s position. Normalization to 3NF is not over-engineering here; it is a practical way to separate customers, products, sales representatives, and orders so each fact is stored once and maintained correctly, thus eliminating redundancy and ensuring data integrity. Each entity is stored once and referenced via keys, making updates consistent, inserts flexible, and deletions safe.    