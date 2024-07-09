
-- 1 KPI's

-- Finding Total Revenue

SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales

-- Determine Average Order Value

SELECT 
	SUM(total_price) / COUNT(DISTINCT(order_id)) AS Average_Order_Value
FROM pizza_sales

-- Total Pizza Sold

SELECT SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales

-- Total Orders

SELECT COUNT(DISTINCT(order_id)) AS Total_Orders
FROM pizza_sales

-- Average Pizzas Per Order

SELECT 
	CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
	CAST(COUNT(DISTINCT(order_id)) AS DECIMAL(10,2)) AS DECIMAL(10,2))
	AS Average_Pizzas_Per_Order
FROM pizza_sales

-- 2 Charts

-- Daily Trend for Total Orders

SELECT 
	DATENAME(DW, order_date) AS Order_Day
	,COUNT(DISTINCT(order_id)) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date) -- DW is day of week

-- Hourly Trend for Total Orders
SELECT 
	DATEPART(HOUR, order_time) AS Order_Hours
	,COUNT(DISTINCT(order_id)) AS Total_Orders
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)

-- Percentage of Sales by Pizza Category
SELECT 
	pizza_category
	,SUM(total_price) AS Total_Sales
	,SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales)
	AS Percentage_of_Sales_by_Pizza_Category
FROM pizza_sales
GROUP BY pizza_category

-- Percentage of Sales by Pizza Size
SELECT 
	pizza_size
	,CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales
	,CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2))
	AS Percentage_of_Sales_by_Pizza_Size
FROM pizza_sales
GROUP BY pizza_size
ORDER BY Percentage_of_Sales_by_Pizza_Size DESC

-- Total Pizzas Sold by Pizza Category
SELECT 
	pizza_category
	,SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_category

-- Top 5 Best Sellers by Total Pizzas Sold
SELECT TOP 5
	pizza_name
	,SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC

-- Bottom 5 Worst Sellers by Total Pizzas Sold
SELECT TOP 5
	pizza_name
	,SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC