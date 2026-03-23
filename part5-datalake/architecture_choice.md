## Architecture Recommendation  
For this case, I would recommend a Data Lakehouse architecture. A food delivery startup deals with diverse data types, including structured data (`payment transactions`), semi-structured data (`GPS logs`), and unstructured data (`customer reviews` and `menu images`). A traditional data warehouse is not well-suited for handling unstructured data, while a pure data lake lacks strong governance and query performance. A lakehouse combines the strengths of both.  

1. **First Reason:**  
    A lakehouse can store and process multi-format data, allowing the system to store structured, semi-structured, and unstructured data in a single platform. This is essential for handling GPS logs, text reviews, and images without requiring separate systems.  

2. **Second Reason:**  
    It is more scalable and cost-efficient, thus combining the strengths of both data lake and data warehouse, because lakehouses use low-cost object storage while avoiding the need to maintain separate lake and warehouse systems.  

3. **Third Reason:**  
    A lakehouse enables efficient BI analytics and AI/ML workflows. Data scientists can use the same platform to analyze `customer reviews` (for sentiment analysis), process `GPS data` (for route optimization), and `train models` for demand forecasting. It eliminates the need to move data between systems, improving performance and reducing complexity.        
