CREATE TABLE sales(
	transactions_id INT PRIMARY KEY,
	sale_date	DATE,
	sale_time TIME,
	customer_id	 INT,
	gender VARCHAR (10),
	age	INT,
	category VARCHAR (20), 	
	quantiy	INT,
	price_per_unit INT,
	cogs FLOAT, 
	total_sale INT
	);
--
SELECT * from sales
limit (10);
--
SELECT * FROM sales
where 
	transactions_id is NULL
	OR
	sale_date is NULL
	OR 
	sale_time IS NULL
	OR
	customer_id is NULL	
	OR
	gender is NULL
	OR
	age is NULL
 	OR
	category is NULL
	OR
	quantiy is NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale Is NULL ;
---
DELETE FROM sales
where 
	transactions_id is NULL
	OR
	sale_date is NULL
	OR 
	sale_time IS NULL
	OR
	customer_id is NULL	
	OR
	gender is NULL
	OR
	age is NULL
 	OR
	category is NULL
	OR
	quantiy is NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale Is NULL ;

--
SELECT * FROM sales;
--

-- Q1  Write a SQL query to retrieve all columns for sales made on '2022-11-05:

SELECT * from sales where sale_date = '2022-11-05';

-- Q2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

Select * from sales;
where category = 'Clothing' and quantiy >= 4 and  sale_date >= '2022-11-01' and sale_date <'2022-12-01'; ;

-- Q3 Write a SQL query to calculate the total sales (total_sale) for each category

Select  category, sum(total_sale) AS Total_sales
from sales
GROUP BY category;

-- Q4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

SELECT Round (avg (age),2)  
from sales
where category = 'Beauty';

-- Q5 Write a SQL query to find all transactions where the total_sale is greater than 1000.:

select * from sales
where total_sale > 1000;

-- Q6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

Select category,gender,
 	count (*) AS transactions from sales
	 Group BY category,gender;
-- Q7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT YEAR , MONTH , avg_sale
FROM (
	select 
	Extract (YEAR FROM sale_date) as year ,
	Extract (MONTH FROM sale_date)as month ,
	AVG(total_sale) as avg_sale,
	Rank () OVER  (PARTITION by Extract (YEAR FROM sale_date) ORDER BY AVG(total_sale)DESC) as rank
from sales
GROUP BY  Extract (YEAR FROM sale_date),Extract (MONTH FROM sale_date)
) as ranked_sales
WHERE rank = 1;

-- Q8 Write a SQL query to find the top 5 customers based on the highest total sales **:

SELECT customer_id,
		SUM (total_sale) AS top_sales
		FROM sales
		GROUP BY customer_id
		ORDER BY top_sales DESC
		LIMIT (5)

-- Q9 Write a SQL query to find the number of unique customers who purchased items from each category.:

SELECT 	
	   category, 
      COUNT(DISTINCT(customer_id))
FROM sales
GROUP BY category;

-- Q10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
WITH hourly_sale 
AS (
SELECT *,
	CASE
	WHEN EXTRACT (HOUR from sale_time) <12 THEN 'MORNING'
	WHEN EXTRACT (HOUR from sale_time) BETWEEN 12  AND 17 THEN 'AFTERNOON'
	ELSE 'EVENING'
	END AS shift
FROM sales
) 
SELECT 
 shift ,
 Count (*)
 from hourly_sale
 GROUP BY shift

-- END OF PROJECT ___



	
