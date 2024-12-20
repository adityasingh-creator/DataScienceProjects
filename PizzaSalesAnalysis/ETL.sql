#ETL 
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
