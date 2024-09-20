select * from retail_sales;

select count(*) from retail_sales;

select * from retail_sales
where transactions_id is null;

select * from retail_sales 
where sales_date is null;

delete from retail_sales where
transactions_id is null
or
sales_date is null
or
sales_time is null
or
gender is null
or
category is null
or 
quantity is null
or
cogs is null
or 
total_sales is null;


select count(*) as total_sales from retail_sales;

select count(distinct customer_id) as total_sales from retail_sales;

select distinct category from retail_sales;



-- Q1 Write a SQl query to retrieve all columns for sales made on '2022-11-05'
SELECT 
    *
FROM
    retail_sales
WHERE
    sales_date = '2022-11-05';
    
-- Q2 Write a SQl query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of NOV-2022
SELECT 
    *
FROM
    retail_sales
WHERE
    category = 'Clothing' AND quantity >= 4
        AND sales_date BETWEEN '2022-11-01' AND '2022-11-30';
        
        
        
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
    category, SUM(total_sales) as net_sales
    , COUNT(*) AS total_orders
FROM
    retail_sales
GROUP BY category;


-- Q.4 Write a SQL query to find average age of customers who purchased items from the 'Beauty' category. 

SELECT 
    AVG(age) AS Avg_age
FROM
    retail_sales
WHERE
    category = 'Beauty'; 
    
-- Q.5 Write a SQL query to find all transcations where the total sales is greater than 1000. 

SELECT 
    *
FROM
    retail_sales
WHERE
    total_sales > 1000;
    
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category. 

SELECT 
    category, gender, COUNT(*) AS total_transactions
FROM
    retail_sales
GROUP BY 1 , 2
ORDER BY 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year. 

select years,months,Avg_sales from (
select year(sales_date) as years,
       monthname(sales_date) as months,
       round(avg(total_sales),2) as Avg_sales, 
       rank() over(partition by year(sales_date) order by Avg(total_sales) desc) as Ranks
       from
 retail_sales
 group by 1,2) as rank_table
 where ranks =1 ;
 
 -- Q.8 Write a Sql query to find the top 5 customers based on the higest total sales
 
SELECT 
    customer_id, SUM(total_sales) AS total_spend
FROM
    retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category. 

SELECT 
    category, COUNT(DISTINCT (customer_id)) AS Total_customer
FROM
    retail_sales
GROUP BY 1;


-- Q 10 Write a SQL query to create each shift and number of orders 

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
 




