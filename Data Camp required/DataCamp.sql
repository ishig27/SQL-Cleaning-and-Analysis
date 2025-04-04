-------------------------------------------------------
 -- Data Camp Questions
-------------------------------------------------------
-- Find the top 5 products from each category based on highest total sales. The output should be sorted by category in ascending order and by sales in descending order within each category, i.e. within each category product with highest margin should sit on the top.
WITH product_sales AS (
    SELECT
        p.category,
        p.product_name,
        ROUND(SUM(o.sales)::numeric, 2) AS product_total_sales,
        ROUND(SUM(o.profit)::numeric, 2) AS product_total_profit,
        RANK() OVER (PARTITION BY p.category ORDER BY SUM(o.sales) DESC) AS product_rank
    FROM products p
    JOIN orders o ON p.product_id = o.product_id
    GROUP BY p.category, p.product_name
)

SELECT *
FROM product_sales
WHERE product_rank <= 5
ORDER BY category, product_rank;

-- Calculate the quantity for orders with missing values in the quantity column by determining the unit price for each product_id using available order data, considering relevant pricing factors such as discount, market, or region. Then, use this unit price to estimate the missing quantity values. The calculated values should be stored in the calculated_quantity column.
WITH avg_unit_price_per_product AS (
    SELECT
        product_id,
        AVG(sales / NULLIF(quantity * (1 - discount), 0)) AS avg_unit_price
    FROM orders
    WHERE quantity IS NOT NULL AND discount IS NOT NULL
    GROUP BY product_id
),

impute_missing_values AS (
    SELECT
        o.product_id,
        o.sales,
        o.discount,
        o.quantity, o.market, o.region,
        ROUND((o.sales / (a.avg_unit_price * (1 - o.discount)))::numeric, 2) AS calculated_quantity
    FROM orders o
    LEFT JOIN avg_unit_price_per_product a
        ON o.product_id = a.product_id
    WHERE o.quantity IS NULL
)

SELECT * FROM impute_missing_values;


