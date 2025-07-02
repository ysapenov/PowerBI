❄️ Snowflake is great, but without monitoring, performance drops and costs climb fast.
If you are running a SF + Power BI stack, here is my lightweight Power BI template to track two critical metrics:
⏱️ Queued Time: Spot warehouse-sizing and concurrency bottlenecks.
🧊 Spilled Data: Catch queries that overflow memory and hit storage.
⚙️ Quick start parameters:
1) Snowflake server
2) Warehouse name
3) Look-back window (days)
📥 The report is based on data from system tables:
- snowflake.account_usage.warehouse_load_history
- snowflake.account_usage.query_history
🧠 Want to go deeper on optimization?
Here is the Snowflake’s guide, which was my aspiration:
https://docs.snowflake.com/en/user-guide/performance-query-warehouse