# Retails Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis    
**Software**: MySQL    
**Database**: `retail_sales`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the data.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The Project starts with creating a database named `Retail_sales`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes coulums for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
create database Retail_sales;

create table retail_sales(
transactions_id int not null primary key,
sales_date date,
sales_time time,
customer_id int,
gender text,
age int,
category text,
quantity int,
price_per_unit float,
cogs float,
total_sales float

);
```

### 2. Data Exploration and Cleaning

- **Record Count**: Determine the total number of records in the dataset.
  ```sql
  select count(*) from retail_sales;
  ```
- **Customer Count**: Find out how many unique customers are in the dataset.
  ```sql
  select count(distinct customer_id) as total_sales from retail_sales;
  ```
- **Category Count**: Identify all unique product categories in the dataset.
  ```sql
  select distinct category from retail_sales;
  ```
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.
  ```sql
  delete from retail_sales where
  transactions_id is null or sales_date is null or sales_time is null
  or gender is null or category is null or quantity is null
  or cogs is null or total_sales is null;
  ```

### 3. Data Analysis and Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05'**:
```sql
SELECT 
    *
FROM
    retail_sales
WHERE
    sales_date = '2022-11-05';
```

2. **Write a SQl query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of NOV-2022**:
```sql
SELECT 
    *
FROM
    retail_sales
WHERE
    category = 'Clothing' AND quantity >= 4
        AND sales_date BETWEEN '2022-11-01' AND '2022-11-30';
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category**:
```sql
SELECT 
    category, SUM(total_sales) as net_sales
    , COUNT(*) AS total_orders
FROM
    retail_sales
GROUP BY category;
```

4. **Write a SQL query to find average age of customers who purchased items from the 'Beauty' category**:
```sql
SELECT 
    AVG(age) AS Avg_age
FROM
    retail_sales
WHERE
    category = 'Beauty';
```

5. **Write a SQL query to find all transcations where the total sales is greater than 1000**:
```sql
SELECT 
    *
FROM
    retail_sales
WHERE
    total_sales > 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category**:
```sql
SELECT 
    category, gender, COUNT(*) AS total_transactions
FROM
    retail_sales
GROUP BY 1 , 2
ORDER BY 1;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
select years,months,Avg_sales from (
select year(sales_date) as years,
       monthname(sales_date) as months,
       round(avg(total_sales),2) as Avg_sales, 
       rank() over(partition by year(sales_date) order by Avg(total_sales) desc) as Ranks
       from
 retail_sales
 group by 1,2) as rank_table
 where ranks =1 ;
```

8. **Write a Sql query to find the top 5 customers based on the higest total sales**:
```sql
SELECT 
    customer_id, SUM(total_sales) AS total_spend
FROM
    retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category**: 
```sql
SELECT 
    category, COUNT(DISTINCT (customer_id)) AS Total_customer
FROM
    retail_sales
GROUP BY 1;
```

10. **Write a SQL query to create each shift and number of orders**:
```sql
SELECT 
    CASE
        WHEN HOUR(sales_time) <= 12 THEN 'Morning'
        WHEN HOUR(sales_time) BETWEEN 12 AND 16 THEN 'Afternoon'
        ELSE 'Evening'
    END AS Shift,
    COUNT(*) AS total_orders
FROM
    retail_sales
GROUP BY Shift;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.


## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.


Thank you....
