use customer;
select * from df_orders;


select distinct(product_id),sum(quantity*sales_price) as revenue 
from df_orders
group by product_id 
order by revenue desc limit 10;



WITH cte AS (
    SELECT 
        MONTH(order_date) AS mont,
        YEAR(order_date) AS yea,
        SUM(sales_price) AS TotalSale
    FROM df_orders
    GROUP BY mont, yea
)
SELECT 
    mont,
    SUM(CASE WHEN yea = 2022 THEN TotalSale ELSE 0 END) AS sales2022,
    SUM(CASE WHEN yea = 2023 THEN TotalSale ELSE 0 END) AS sales2023
FROM cte 
GROUP BY mont
ORDER BY mont;

#For Each Cateory which month had highest Sale
with cte as (
SELECT
    category,
    EXTRACT(MONTH  FROM order_date) AS Month_,
    EXTRACT(YEAR   FROM order_date) AS Year_,
    SUM(sales_price)               AS Total_sales,
    ROW_NUMBER() OVER (
      PARTITION BY category
      ORDER   BY SUM(sales_price) DESC
    ) AS rn
  FROM df_orders
  GROUP BY category,
           EXTRACT(MONTH  FROM order_date),
           EXTRACT(YEAR   FROM order_date)
           )
select * 
from cte 
where rn=1 ;

#Which sub category had the highest growth by profit in 2023 compare to 2022
with cte as (
select sub_category, year(order_date) as year_pur,
sum(profit) as Total_profit 
from df_orders
group by sub_category , year_pur) 
select sub_category,
sum(case when year_pur = 2022 then Total_profit else 0 end) as profit_2022,
sum(case when year_pur = 2023 then Total_profit else 0 end)  as profit_2023,
sum(case when year_pur = 2022 then Total_profit else 0 end) - sum(case when year_pur = 2023 then Total_profit else 0 end)  as profit_diff
from cte
group by sub_category
order by profit_diff
limit 1 ;

    




	