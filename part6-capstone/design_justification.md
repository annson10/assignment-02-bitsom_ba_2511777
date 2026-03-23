## Storage Systems
(Which databases/storage systems did you choose for each of the 4 goals and why)  

1. For `predicting patient readmission risk`, I would use a data lake for raw historical treatment data and a data warehouse for cleaned, integrated, analysis-ready patient history, billing, diagnosis, and discharge data. The lake allows the hospital to retain detailed raw records at scale, while the warehouse supports consistent feature engineering and model training on trusted datasets.  

2. For `plain-English patient history queries`, I would use a vector database fed from doctor notes, discharge summaries, and other clinical text. A vector store enables semantic retrieval, which is useful when a doctor asks questions like whether a patient had a prior cardiac event without knowing the exact wording in the notes.  

3. For `monthly management reports`, I would use the data warehouse as the reporting source. Bed occupancy, department-wise costs, and financial summaries are classic OLAP workloads that depend on clean dimensions, historical facts, and stable business definitions. Warehouses are specifically designed for reporting, dashboards, and executive analytics across hospital operations.  

4. For `real-time ICU vitals`, I would use a streaming pipeline into a time-series store for hot operational monitoring, plus downstream storage in the lake for long-term analysis. ICU data arrives continuously and benefits from timestamp-oriented storage, alerting, and fast retrieval over recent windows. Real-time monitoring systems are commonly built around persistent streaming capture and time-indexed access.


## OLTP vs OLAP Boundary
(Where does the transactional system end and the analytical system begin in your design)  

In this design, the OLTP boundary ends at the operational systems: the EHR, billing system, ICU devices, Doctor notes and the hospital’s core patient-record database. These systems support day-to-day transactions such as updating charts, recording treatments, posting charges, and capturing live device readings.   

The OLAP boundary begins once data is ingested into the analytical platform through batch ingestion or streaming. From that point onward, the data lake, warehouse, feature engineering layer, reporting stack, and AI services are analytical components meant for insight generation, model training, retrieval, and decision support rather than transaction processing.  

​
## Trade-offs
(Identify one significant trade-off in your design and how you would mitigate it)  

A major trade-off in this design is `architectural complexity`, due to the use of multiple storage systems (`OLTP database`, `data lake`, `data warehouse`, and `vector databases` and `time-series store`) gives strong workload fit, but it also increases operational overhead, data synchronization effort, and maintenance.  

I would mitigate this by enforcing a well-defined data pipeline strategy:
This is implemented using ETL/ELT processes to ensure data consistency across systems. Data validation and monitoring mechanisms can be added to detect inconsistencies early. Additionally, using orchestration tools (such as Airflow) can help automate data workflows and reduce operational complexity. This approach ensures that the benefits of a modular architecture are achieved without compromising reliability and maintainability.
