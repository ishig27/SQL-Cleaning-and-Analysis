-------------------------------------------------------
-- Return Trends: Which Market & Products Were Most Returned?
-- Goal: Identify which markets and products have the highest number of returned orders
SELECT
    r.market,
    p.product_name,
    COUNT(*) AS num_returns -- Count how many times each product was returned in each market
FROM returned_orders r
JOIN orders o ON r.order_id = o.order_id -- Join returned orders with the original order data
JOIN products p ON o.product_id = p.product_id -- Get product info
WHERE r.returned = 'Yes' -- Only include returned orders
GROUP BY r.market, p.product_name -- Group by market and product
ORDER BY num_returns DESC; -- Show the most returned combinations first

-- UNITED STATES had the highest number of returns for Staples

-------------------------------------------------------
-- Discount Strategy: Which Items Had the Highest Discounts?
-- Did They Still Generate Profit or Lead to Losses?
-- Goal: Analyze discount-heavy items and whether they were profitable
SELECT
    p.product_name,
    AVG(o.discount) AS avg_discount, -- Average discount applied to each product
    SUM(o.profit) AS total_profit, -- Total profit made on each product
    CASE
        WHEN SUM(o.profit) < 0 THEN 'Loss' -- Flag as 'Loss' if overall profit is negative
        ELSE 'Profit'
    END AS profit_status
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name -- Analyze by product
ORDER BY avg_discount DESC; -- Focus on products with the highest discounting
-- Eureka Disposable Bags for Sanitaire Vibra Groomer I Upright Vac: highest discount with a loss

-------------------------------------------------------
-- Sales Performance: Which Salesperson Had the Best Profit Margins?
-- Goal: Compare salespeople by how profitable their sales are
SELECT
    pe.person,
    SUM(o.sales) AS total_sales, -- Total sales made by each person
    SUM(o.profit) AS total_profit, -- Total profit made by each person
    ROUND((SUM(o.profit) / NULLIF(SUM(o.sales), 0))::numeric, 2) AS profit_margin -- Profit margin = profit / sales
FROM orders o
JOIN people pe ON o.region = pe.region -- Link orders to salespeople by region
GROUP BY pe.person
ORDER BY profit_margin DESC; -- Rank by profitability

-------------------------------------------------------
-- Salesperson Specialization: What Was Each Person's “Niche” Product?
-- (Most Sold Item Per Salesperson)
-- Goal: Find each salesperson's most-sold product
WITH sales_rank AS (
    SELECT
        pe.person,
        p.product_name,
        SUM(o.quantity) AS total_quantity, -- Total units sold by this person for this product
        ROW_NUMBER() OVER (
            PARTITION BY pe.person
            ORDER BY SUM(o.quantity) DESC
        ) AS rnk -- Rank products for each salesperson by quantity sold
    FROM orders o
    JOIN people pe ON o.region = pe.region
    JOIN products p ON o.product_id = p.product_id
    GROUP BY pe.person, p.product_name
)
SELECT *
FROM sales_rank
WHERE rnk = 1;

-- (mutiple but) Alejandro Ballentine, product: Advantus Stacking Tray, Erganomic

-- Final output: most-sold product per salesperson
SELECT *
FROM sales_rank
WHERE rnk = 1;

-------------------------------------------------------
-- Regional Preferences: What Was the Top-Selling Product in Each Region?
-- Goal: Discover if certain products are especially popular in specific regions
WITH region_favorites AS (
    SELECT
        o.region,
        p.product_name,
        SUM(o.quantity) AS total_quantity, -- Total quantity sold per product per region
        ROW_NUMBER() OVER (
            PARTITION BY o.region
            ORDER BY SUM(o.quantity) DESC
        ) AS rnk -- Rank products within each region
    FROM orders o
    JOIN products p ON o.product_id = p.product_id
    GROUP BY o.region, p.product_name
)

-- Final output: top-selling product per region
SELECT *
FROM region_favorites
WHERE rnk = 1;