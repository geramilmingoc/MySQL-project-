-- Exploratory data analysis using univariate,bivariate and multivariate --

create database eda_supermarket;
use EDA_supermarket;

-- display the first 5 rows from the dataset --
SELECT * 
	FROM eda_supermarket.supermarket
		limit 5;
        
-- display the last 5 rows from the dataset --
SELECT * 
	FROM eda_supermarket.supermarket
		order by `Invoice ID`desc limit 5;
        
-- display random 5 rows from the data set -- 
SELECT * 
	FROM eda_supermarket.supermarket
		order by rand() limit 5;
        
        
        -- using univariate / multivariate /bivariate analysis --
	-- Display count, min, max, avg, and std values for a column in the data set --
SELECT count(`gross income`),
		min(`gross income`),
        max(`gross income`),
        avg(`gross income`),
        std(`gross income`)
	FROM eda_supermarket.supermarket;
    
-- Find the number of missing values eg.('branch' column)--
SELECT count(*)
	FROM eda_supermarket.supermarket
		where Branch is null;
        
--  Count the number of occurences of each city -- 
 SELECT City , count(city)
	FROM eda_supermarket.supermarket
		group by City;
        
-- find the mostfrequently used payment metod -- 
SELECT payment,  count(*)
	FROM eda_supermarket.supermarket
    group by Payment order by count(*) desc;
    
-- Does the cost of goods sold affect the ratings that the customer provides -- 
--  (numerical - numerical)

SELECT cogs, Rating
	FROM eda_supermarket.supermarket;
    
-- find the most profitable branch as per gross income -- 
SELECT branch,round(sum(`gross income`),2)as sum_gross_income
	FROM eda_supermarket.supermarket
    group by Branch order by sum_gross_income desc;
 
SELECT city, Branch, round(sum(`gross income`),2) as income
	FROM eda_supermarket.supermarket  
    group by city, branch order by income;
    
-- find the most used payment method -- 
select *
	from supermarket;
select city,
    sum(case when payment ='cash' then 1 else 0 end) as "cash",
     sum(case when payment ='Ewallet' then 1 else 0 end) as "Ewallet",
      sum(case when payment ='Credit card' then 1 else 0 end) as "credit card"
        from supermarket
				group by City;
                
-- Find the product line purchased in the highest quantity -- 
select `Product line`, sum(Quantity) 
	from supermarket
    group by `Product line`
    order by sum(Quantity)desc;
    
-- Display the daily sales by day of the week --
SELECT * 
	FROM supermarket
    ;
update supermarket
  set date = str_to_date(date,'%m/%d/%Y');
  
  select dayname(date),dayofweek(date), round(Sum(total),2)
   from supermarket
	group by dayofweek(date),dayname(date) 
	 order by round(Sum(total),2) desc;
     
	-- find the month with the highest sales -- 
select monthname(date)as month_name, month(date) as month, round(sum(Total),2)as total
	from supermarket
		group by month_name,month 
			order by total  desc;
            
-- find the Time with the highest sales --
select hour(Time) as HOUR, round(sum(Total),2) as Sales
	from supermarket
		group by HOUR order by Sales desc;
-- which gender spends more on average --
select Gender, avg(`gross income`)
	from supermarket
		group by Gender;

    
    
    
    