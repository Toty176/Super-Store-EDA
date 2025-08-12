select distinct state,Round(sum(sales),0) as total_sum
from super_store
where order_date>='2015-01-01'
group by state
order by total_sum desc
limit 1
;



select distinct city,round(sum(profit),2) as total_profit
from super_store
where order_date>='2017-01-01'
group by city
order by total_profit desc
limit 5
;

select distinct category,round((sum(profit)/sum(sales))*100,2) as profit_margin
from super_store
where year(order_date)='2017'
group by category
order by profit_margin desc;

select *
from super_store;





select distinct sub_category,round(sum(profit),0) as loss
from super_store
where year(order_date)='2017'
group by sub_category
having loss<0
order by loss ;



select distinct Product_ID,round(sum(sales),0) as sales_sum,round(avg(discount),3) as Avg_discount,sum(Quantity) as Quantity_sold
from super_store
group by Product_ID
order by sales_sum desc;


select *
from super_store;
select  customer_id, customer_name,round(sum(sales),0) as user_sales
from super_store
group by customer_ID,customer_name
order by user_sales desc 
limit 1;


select distinct ship_mode,round(avg(datediff(ship_date,order_date)),0) as AVG_delivery_time
from super_store
group by ship_mode
;



with product_sales as(
select
product_id,
Product_name,
round(sum(sales),0) as total_sales
from super_store
group by Product_ID,Product_Name
),
ranked as(
select 
product_id,
Product_name,
total_sales,
round(sum(total_sales) over(order by total_sales desc),0) as running_sales,
round(sum(total_sales) over(),0) as grand_total
from product_sales),
classified as(
select
Product_ID,
        Product_Name,
        total_sales,
        running_sales,
        grand_total,
        ROUND((running_sales / grand_total) * 100, 2) AS cumulative_percent,
        CASE
            WHEN (running_sales / grand_total) <= 0.80 THEN 'A'
            WHEN (running_sales / grand_total) <= 0.95 THEN 'B'
            ELSE 'C'
        END AS abc_class
    FROM ranked
    )
    select *
    from classified
    order by total_sales desc;
    
    
    select *
    from super_store;
    
    
    WITH category_year AS (
 
   SELECT 
        YEAR(Order_Date) AS order_year,
        Category,
        ROUND(SUM(Sales), 2) AS total_sales,
        ROUND(SUM(Profit), 2) AS total_profit
    FROM super_store
    WHERE YEAR(Order_Date) >='2014'
      AND YEAR(Order_Date) < '2018'-- exclude current partial year
    GROUP BY YEAR(Order_Date), Category
    order by year(order_date)  desc
)
SELECT
    order_year,
    Category,
    total_sales,
    total_profit,
    ROUND(
        (total_sales - LAG(total_sales) OVER (PARTITION BY Category ORDER BY order_year))
        / LAG(total_sales) OVER (PARTITION BY Category ORDER BY order_year) * 100,
        2
    ) AS yoy_sales_percent,
    ROUND(
        (total_profit - LAG(total_profit) OVER (PARTITION BY Category ORDER BY order_year))
        / LAG(total_profit) OVER (PARTITION BY Category ORDER BY order_year) * 100,
        2
    ) AS yoy_profit_percent
FROM category_year
ORDER BY Category , order_year desc;


