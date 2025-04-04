# Superstore SQL Cleaning & Analysis

In this project, I worked with a fictional Superstore dataset to perform SQL-based data cleaning and business analysis. The database contained inconsistent data types, missing values, and untidy structures — making it a great case study for real-world SQL work.

## Goals
- Clean and convert text-based dates and numeric fields
- Impute missing values logically
- Identify top-performing products by category based on sales and profit
- Join multiple tables to derive deeper business insights

## Tables Used
- `orders`
- `products`
- `people`
- `returned_orders`

## Key Skills Demonstrated
- SQL JOINs
- CTEs and window functions (`RANK`)
- `TO_DATE()` and `CAST()` for cleaning
- Filtering, aggregation, and sorting for business KPIs
- Handling missing values and schema mismatches

## Files
- `DataCamp.sql`
        DataCamp: Contains SQL queries from the original [DataCamp Real-World Project](https://www.datacamp.com/), focusing on data cleaning and basic analysis of the Superstore dataset. Included here for completeness and context.
- `ExtendedAnalysis.sql`  
        Original queries created by me to explore deeper business questions, such as:
          - Return trends by market and product
          - Discount impact on profitability
          - Salesperson specialization and profit margins
          - Regional product preferences

## Insights, based on extended analysis
- Staples was the most returned product, with a total of 17 returns, 
    - This may indicate quality or suitability issues with Staples products. It’s worth investigating what these returns are driven by (region or customer expectations)to improve customer satisfaction.
- Nicole Hansen had the highest profit margin
    - Nicole’s performance could signal effective sales strategies - which can be replicated by other sales people. 

> This project is based on a dataset and outline from a DataCamp real-world project. All analysis and enhancements are my own. The dataset used in this project comes from the [DataCamp Real-World Project: Cleaning a PostgreSQL Database](https://www.datacamp.com/). The data is not publicly downloadable outside the platform, so it is not included in this repository.

