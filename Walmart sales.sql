create database Walmart;

CREATE TABLE sales (
    Invoice_ID VARCHAR(30),
    Branch VARCHAR(15) NOT NULL,
    City VARCHAR(30) NOT NULL,
    Customer_type VARCHAR(30) NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    Product_line VARCHAR(100) NOT NULL,
    Unit_price DECIMAL(10 , 2 ) NOT NULL,
    Quantity INT NOT NULL,
    Tax FLOAT(6 , 4 ) NOT NULL,
    Total DECIMAL(10 , 2 ) NOT NULL,
    Date DATE NOT NULL,
    Time time not null,
    Payment VARCHAR(30) NOT NULL,
    cogs DECIMAL(10 , 2 ) NOT NULL,
    gross_margin_percentage FLOAT(11 , 9 ) NOT NULL,
    gross_income DECIMAL(10 , 2 ) NOT NULL,
    Rating FLOAT(2 , 1 ) NOT NULL
);



select
 time,
(case
		when `time` Between "00:00:00" and "12:00:00" then "Morning"
when `time` Between "12:00:01" and "16:00:00" then "Afternoon"
else "Evening"
end) as Time_of_day
from sales;

Alter table sales add column Time_of_day varchar(20);

Update sales 
set	Time_of_day = (case
		when `time` Between "00:00:00" and "12:00:00" then "Morning"
when `time` Between "12:00:01" and "16:00:00" then "Afternoon"
else "Evening"
end);


select date, dayname(Date)
 from Sales;

Alter table sales add column day_Name varchar(20);

Update sales 
set	day_name = dayname(date);

select date, monthname(date) from sales;

Alter table sales add column Month_Name varchar(20);

Update sales 
set	Month_name = monthname(date);



-- How many unique cities does the data have?

select distinct city from sales;

-- In which city is each branch?
select distinct city, branch from sales ;

-- How many unique product lines does the data have?
select distinct product_line from sales;

-- What is the most common payment method?
select payment, count(payment) as Count from sales
 group by payment order by count Desc;
 
 -- What is the most selling product line?
select Product_line, count(Product_line) as count_product_line from sales
 group by Product_line order by count_Product_line Desc; 
 
 -- What is the total revenue by month?
select  month_name as month,sum(total) as revenue  from sales 
group by month
order by revenue desc;

-- What month had the largest COGS?
select  month_name as month,sum(cogs) as Cogs  from sales 
group by month
order by cogs desc;

-- What product line had the largest revenue? 
select  Product_line as product,sum(total) as revenue  from sales 
group by product
order by revenue desc;

-- What is the city with the largest revenue?
select  City ,sum(total) as revenue  from sales 
group by city
order by revenue desc;

-- What product line had the largest VAT?
select product_line as Product, round(avg(Tax),2) as tax from sales
group by Product_line
order by tax desc;

-- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
SELECT
	product_line,
	CASE
		WHEN AVG(Total) > 322.49 THEN "Good"
        ELSE "Bad"
    END AS remark
FROM sales
GROUP BY product_line;

-- Which branch sold more products than average product sold?
select branch,sum(Quantity) as QTY from sales
 group by branch 
 having sum(Quantity) > avg(Quantity)
 order by qty desc;


-- What is the most common product line by gender?
select gender, Product_line, count(gender) as count from sales
group by gender, Product_line
order by count desc ;


-- What is the average rating of each product line?

select  Product_line, round(avg(rating), 2) as rating from sales group by Product_line
order by rating;

-- Number of sales made in each time of the day per weekday

select time_of_day, count(*) as total_sales
from sales
where day_name = "Monday"
group by Time_of_day
order by  total_sales desc;

-- Which of the customer types brings the most revenue?
select customer_type, sum(total) as Revenue from sales
group by Customer_type
order by  Revenue desc;

-- Which city has the largest tax percent/ VAT (Value Added Tax)?
select city, round(Avg(tax), 2) as tax from Sales 
group by city
order by Tax desc;

-- Which customer type pays the most in VAT?
select customer_type, round(sum(tax), 2) as Vat from sales
group by Customer_type
order by vat desc;

-- How many unique customer types does the data have?
select distinct count(invoice_id) from sales;

-- How many unique payment methods does the data have?
select distinct payment from sales;

-- What is the most common customer type?
select customer_type, count(*) from sales
group by Customer_type;

-- Which customer type buys the most?
select customer_type, sum(total) from sales
group by Customer_type;

-- What is the gender of most of the customers?
select gender, count(gender) as Count_of_Gender
from sales group by gender order by Count_of_Gender Desc;

-- What is the gender distribution per branch?
select Gender, count(*) as count from sales
where	Branch = "a"
group by gender
order by count desc;


-- Which time of the day do customers give most ratings?
select time_of_day, round(avg(rating), 2) 
from sales group by Time_of_day;


-- time of the day do customers give most ratings per branch?
select time_of_day, Avg(rating) as rating from sales
where	Branch = "B"
group by Time_of_day
order by rating;


-- Which day of the week has the best avg ratings?
select day_name, round(Avg(rating), 2) as rating from sales
group by day_name
order by rating desc;


-- Which day of the week has the best average ratings per branch?
select day_name, round(Avg(rating), 2) as rating from sales
where	Branch = "c"
group by day_name
order by rating desc;


