CREATE TABLE NikeSales (
    invoice_date VARCHAR(100),
    product VARCHAR(100),
    region VARCHAR(100),
    retailer VARCHAR(100),
    sales_method VARCHAR(100),
    states VARCHAR(100),
    price_per_unit INT, 
    total_sales INT, 
    units_sold INT
);

select * from NikeSales;

-- What is the total sales revenue for Nike products in each region?
SELECT  region,SUM(total_sales) as total_sales_revenue
FROM NikeSales
GROUP BY region

-- Which product has the highest sales volume across all regions?
SELECT product, SUM(units_sold) as sales_volume
FROM NikeSales
GROUP BY product 
ORDER BY SUM(units_sold) DESC limit 1

-- What is the average price per unit for Nike products in each state?
SELECT states, AVG(price_per_unit) as average_price
FROM NikeSales
GROUP BY states
ORDER BY AVG(price_per_unit) DESC

-- How does the sales method ( online, retail) affect total sales revenue?
SELECT sales_method , sum(total_sales) as total_sales
FROM NikeSales 
GROUP BY sales_method

-- Which retailer sells the most Nike products?
SELECT retailer, SUM(units_sold)
FROM NikeSales
GROUP BY retailer
ORDER BY  SUM(units_sold) DESC limit 1

-- Is there a correlation between the price per unit and the total sales revenue?
SELECT product, CORR(price_per_unit, total_sales) as Correlation
FROM NikeSales
GROUP BY product
Order BY Correlation DESC

-- How does the distribution of sales differ between states?
SELECT states, retailer, sales_method, count(sales_method) as sales_count
FROM NikeSales
GROUP BY states, retailer,sales_method
ORDER BY  states, retailer

-- Which store locations have the lowest sales for each state? Shut down store if sales is lower than 15 units.
SELECT states, retailer, sales_method, min(units_sold) as lowest_units_sold,
	CASE
		WHEN min(units_sold)<15 Then 'Shut Down'
		ELSE 'Keep Open'
	END as store_status
FROM NikeSales
WHERE sales_method ='In-store'
GROUP BY states, retailer,sales_method
ORDER BY  states, retailer

