use [Pizza DB]

select * from pizza_sales;


SELECT SUM(total_price) AS Total_Revenue from pizza_sales; 


SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_Value from pizza_sales;


SELECT SUM(quantity) AS Total_Pizza_Revanue from pizza_sales;


SELECT COUNT(DISTINCT order_id) AS Total_order from pizza_sales;


SELECT CAST(CAST (SUM(quantity) AS DECIMAL (10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL (10,2)) AS DECIMAL(10,2)) 
AS Avg_pizza_per_Oreder from pizza_sales;



--Daily Trend
SELECT DATENAME(DW, order_date) as order_day, count(DISTINCT order_id) AS Total_Order 
From pizza_sales
GROUP BY DATENAME(DW, order_date);



--Hourly Trend
SELECT DATEPART(HOUR, order_time) AS order_hours, count(DISTINCT order_id) AS Total_Order 
from pizza_sales
group by DATEPART(HOUR, order_time)
order by DATEPART(HOUR, order_time)



--Percentage of Sales by Pizza Category
SELECT pizza_category, sum(total_price) as Total_Sales, SUM(total_price)*100 / (SELECT SUM(total_price)
from pizza_sales where Month(order_date) = 1) AS Percentage_of_Total_Sales from pizza_sales
where Month(order_date) = 1
group by pizza_category;

--Percentage of sales by pizza size 
SELECT pizza_size, CASt(sum(total_price) as decimal (10,2)) as Total_Sales, CAST(SUM(total_price)*100 / (SELECT SUM(total_price)
from pizza_sales where datepart(quarter, order_date) = 1) AS DECIMAL (10,2)) AS Percentage_of_Total_Sales from pizza_sales
where datepart(quarter, order_date) = 1
group by pizza_size
order by Percentage_of_Total_Sales DESC


--Total Pizza Sold by Pizza Category
SELECT pizza_category, sum(quantity) as Total_Pizza_Sold
from pizza_sales Group by pizza_category;


--Top 5 best seller to sold pizza
SELECT top 5 pizza_name, sum(quantity) as total_pizzas_sold from pizza_sales
group by pizza_name
order by sum(quantity) desc

--Bottom 5 best seller to sold pizza
SELECT top 5 pizza_name, sum(quantity) as total_pizzas_sold from pizza_sales
where month(order_date) = 8
group by pizza_name
order by sum(quantity) 



