
#Generating all the Necessary KPIS 
select * from pizza_sales ;
select sum(total_price) as total_order_value 
from pizza_sales ; 
select sum(total_price)/count(distinct(order_id)) as avg_order_value
from pizza_sales ;
select  sum(quantity)  as Total_Pizzas_sold 
from pizza_sales ; 
select count(distinct(order_id)) as number_of_order
from pizza_sales ; 
select cast(sum(quantity) as decimal(10,2))/cast(count(distinct(order_id)) as decimal(10,2)) as Avg_Pizza_Order 
from Pizza_sales ;


