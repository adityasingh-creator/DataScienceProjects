#ETL 
use pizzaanalysis;
select * from pizza_sales ;
SELECT 
    SUM(total_price) OVER() 
FROM 
    pizza_sales  ;

SELECT 
    SUM(total_price) AS total_revenue,
    dayofweek(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    pizza_sales
GROUP BY 
    dayofweek(STR_TO_DATE(order_date, '%d-%m-%Y')) 
    ;
SELECT 
    SUM(total_price) AS total_revenue,
    month(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_month,
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    pizza_sales
GROUP BY 
    month(STR_TO_DATE(order_date, '%d-%m-%Y'))  ;

select * 
from 
	pizza_sales 
where 
	STR_TO_DATE(order_date, '%d-%m-%Y') is NULL ;
Update pizza_sales 
set order_date = date_format(
str_to_date(Replace(order_date,'/','-'), '%d-%m-%Y'),
'%d-%m-%Y')
where str_to_date(Replace(order_date,'/','-'),'%d-%m-%Y') is not null ; 


select
	pizza_category,
	sum(quantity) * 100 /(select sum(quantity) from pizza_sales) as Percentage
from pizza_sales
group by 
	pizza_category ; 
    
select
	pizza_category,
	sum(quantity) * 100 /(select sum(quantity) from pizza_sales) as Percentage
from pizza_sales
where month(str_to_date(order_date, '%d-%m-%Y')) = 1 
group by 
	pizza_category ; 
select * 
from pizza_sales 
where month(str_to_date(order_date, '%d-%m-%Y')) = 1 ;
select
	pizza_size,
	sum(quantity) * 100 /(select sum(quantity) from pizza_sales where quarter(str_to_date(order_date, '%d-%m-%Y')) = 1) as Percentage
from pizza_sales 
where quarter(str_to_date(order_date, '%d-%m-%Y')) = 1
group by 
	pizza_size 
order by Percentage desc; 

    
create table pizzaanalysis.pizza_sales_staging
select * from pizzaanalysis.pizza_sales ; 

select pizza_name,sum(total_price) as Total_revenue
from pizza_sales 
group by pizza_name 
order by Total_revenue desc
limit 5 ;
    
select pizza_name,sum(quantity) as total_quantity
from pizza_sales 
group by pizza_name 
order by total_quantity desc
limit 5 ;
    
# GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'aznpsaznps07' WITH GRANT OPTION;
# FLUSH PRIVILEGES;

