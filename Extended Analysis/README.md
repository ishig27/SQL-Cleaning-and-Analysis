# Superstore SQL Cleaning & Analysis

I created and answered the following original questions to uncover marketing insights:

### 1. Which market and products were most returned?
- Identified regions and products with the highest return volumes.

### 2. Are heavily discounted items profitable?
- Analyzed the relationship between discounts and overall profit/loss.

### 3. Which salesperson had the highest profit margins?
- Calculated profit margins (profit/sales) by salesperson.

### 4. What is each salesperson’s “niche”?
- Determined the most-sold product for every salesperson.

### 5. Do regional preferences exist?
- Found the top-selling item in each customer region.

Each query is written with comments and focuses on interpretability and business value.

---

## Tools Used

- PostgreSQL
- SQL concepts: `JOIN`, `GROUP BY`, `CTE`, `CASE`, `RANK()`, `NULLIF`, `ROUND`, `SUM`, `AVG`, and `COUNT`
- Conditional logic using CASE WHEN to flag profitable vs. loss-making items
- Window functions (ROW_NUMBER()) to rank products by performance within regions or by salesperson
- Segmentation analysis to uncover patterns across markets, regions, and sales roles
---

## Key Takeaways
- SQL can be used not only for querying but also for critical thinking and data storytelling.
- Marketing and sales teams can use insights like return rates, discount profitability, and top-selling products by region to improve strategy.

---

## Attribution

This project is based on the [“Cleaning a PostgreSQL Database”](https://www.datacamp.com/) real-world project from DataCamp. All **extended queries, documentation, and business insights** were created independently by me.
