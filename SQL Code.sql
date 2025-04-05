Create database Retail_sales_Analysis;
use Retail_sales_Analysis;

select * from retail_sales;
select count(*) from retail_sales;

-- Data Exploration --

-- How many sale we have?--
select count(*) as total_sales from retail_sales;

-- How many unique customers we have --
select count(distinct customer_id) from retail_sales;

-- How many Distinct Categories we have --
select distinct category from retail_sales;


-- Data Analysis & Business key problems and Answers

-- Write a SQL query to retrieve all columns for sales made on '2022-11-05 --
select * from retail_sales
where sale_date = '05-11-22';

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:--

SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantiy >= 4
  AND DATE_FORMAT(sale_date, '%m-%Y') = '11-2022';
  
  
  -- Write a SQL query to calculate the total sales (total_sale) for each category. --
  
  select category,sum(total_sale) 
  from retail_sales
  group by 1;
  
  
-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category. --

SELECT
    ROUND(AVG(age), 2) as Avg_age
FROM retail_sales
WHERE category = 'Beauty';
    
    
-- Write a SQL query to find all transactions where the total_sale is greater than 1000. --

SELECT * FROM retail_sales
WHERE total_sale > 1000;

--  Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category. -- 

Select  
    category,
    gender,
    COUNT(*) as Total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1;   

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year. --

SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as Rn
FROM retail_sales
GROUP BY 1, 2
) as t1;

-- Write a SQL query to find the top 5 customers based on the highest total sales. --

SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Write a SQL query to find the number of unique customers who purchased items from each category. --

SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category;

-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17). --

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;


                                                       -- This is the end of the projects --