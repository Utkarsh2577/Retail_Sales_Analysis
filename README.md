# Retail_Sales_Analysis
Project Overview
Project Title: Retail Sales Analysis

Database: Retail_Sales_Analysis

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

Objectives : 
Set up a retail sales database: Create and populate a retail sales database with the provided sales data.

Data Cleaning: Identify and remove any records with missing or null values.

Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.

Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.

Project Structure
1. Database Setup
Database Creation: The project starts by creating a database named p0_retail_db.

Table Creation: A table named sales is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

'''SQL
CREATE TABLE sales(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);'''

2. Data Exploration & Cleaning
Record Count: Determine the total number of records in the dataset.

Customer Count: Find how many unique customers are in the dataset.

Category Count: Identify all unique product categories in the dataset.

Null Value Check: Check for any null values in the dataset and delete records with missing data.

'''SQL
SELECT * FROM sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
DELETE FROM sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL; '''
	
3. Data Analysis & Findings
The following SQL queries were developed to answer specific business questions:

Q1 Write a SQL query to retrieve all columns for sales made on '2022-11-05':

'''SQL
SELECT * from sales where sale_date = '2022-11-05';'''

Q2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

'''SQL 
Select * from sales;
where category = 'Clothing' and quantiy >= 4 and  sale_date >= '2022-11-01' and sale_date <'2022-12-01'; '''

Q3 Write a SQL query to calculate the total sales (total_sale) for each category:
'''SQL
Select  category, sum(total_sale) AS Total_sales
from sales
GROUP BY category;'''

Q4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category:
'''SQL
SELECT Round (avg (age),2)  
from sales
where category = 'Beauty'; 
'''

Q5 Write a SQL query to find all transactions where the total_sale is greater than 1000:
'''SQL
select * from sales
where total_sale > 1000;
'''

Q6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category:
'''SQL
Select category,gender,
 	count (*) AS transactions from sales
	 Group BY category,gender;
'''

Q7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
'''SQL
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
'''

Q8 Write a SQL query to find the top 5 customers based on the highest total sales:
'''SQL
SELECT customer_id,
		SUM (total_sale) AS top_sales
		FROM sales
		GROUP BY customer_id
		ORDER BY top_sales DESC
		LIMIT (5)
 '''   
 
Q9 Write a SQL query to find the number of unique customers who purchased items from each category:
'''SQL
SELECT 	
	   category, 
      COUNT(DISTINCT(customer_id))
FROM sales
GROUP BY category;
'''

Q10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
'''SQL
WITH hourly_sale 
AS (
SELECT *,
	CASE
	WHEN EXTRACT (HOUR from sale_time) <12 THEN 'MORNING'
	WHEN EXTRACT (HOUR from sale_time) BETWEEN 12  AND 17 THEN 'AFTERNOON'
	ELSE 'EVENING'
	END AS shift
FROM sales
'''
4. Findings
Customer Demographics: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing, Cosmetics, and Electronics.

High-Value Transactions: Several transactions had a total sale amount greater than 1000, indicating premium purchases.

Sales Trends: Monthly analysis helps identify peak shopping periods and popular categories.

Customer Insights: The analysis identifies the top-spending customers and the most popular product categories.

5. Reports
Sales Summary: A detailed report summarizing total sales, customer demographics, and category performance.

Trend Analysis: Insights into sales trends across different months and shifts.

Customer Insights: Reports on top customers and unique customer counts per category.

6. Conclusion
This project serves as a comprehensive introduction to SQL for data analysis, covering database setup, data cleaning, exploratory data analysis, and business-driven queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.
