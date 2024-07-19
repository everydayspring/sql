SELECT *
FROM food_orders

SELECT *
FROM payments

SELECT *
FROM customers


select order_id, restaurant_name, if(over_time>=0, over_time, 0) over_time
from 
(
select order_id, restaurant_name, food_preparation_time-25 over_time
from food_orders
) a


SELECT price/quantity 
FROM 
(
SELECT price, quantity 
FROM food_orders
) a


select restaurant_name,
       price_per_plate*ratio_of_add "수수료"
from 
(
select restaurant_name,
       case when price_per_plate<5000 then 0.005
            when price_per_plate between 5000 and 19999 then 0.01
            when price_per_plate between 20000 and 29999 then 0.02
            else 0.03 end ratio_of_add,
       price_per_plate
from 
(
select restaurant_name, avg(price/quantity) price_per_plate
from food_orders
group by 1
) a
) b

SELECT restaurant_name,
		sido,
		CASE when avg_delivery_time <= 20 then '<=20'
			 when avg_delivery_time > 20 and avg_delivery_time <= 30 then '20<x<=30'
			 else '>30' end delivery_time_segment
FROM 
(
SELECT restaurant_name,
	SUBSTR(addr, 1, 2) sido,
	AVG(delivery_time) avg_delivery_time 
FROM food_orders
GROUP BY 1,2
) a


SELECT cuisine_type,
	   total_quantity,
	   count_res,
	   CASE WHEN count_res>=5 AND total_quantity>=30 THEN 0.005
	   		WHEN count_res>=5 AND total_quantity<30 THEN 0.008
	   		WHEN count_res<5 AND total_quantity>=30 THEN 0.01
	   		WHEN count_res<5 AND total_quantity<30 THEN 0.02 END rate
FROM 
(
SELECT cuisine_type,
	   SUM(quantity) total_quantity,
	   COUNT(DISTINCT restaurant_name) count_res
FROM food_orders
GROUP BY 1
) a



SELECT restaurant_name,
	   sum_price,
	   sum_quantity,
	   CASE WHEN sum_quantity<=5 THEN 0.1
	   		WHEN sum_quantity>15 AND sum_price>=30000 THEN 0.005
	   		ELSE 0.01 end discount_rate 
FROM 
(
SELECT restaurant_name,
	   SUM(price) sum_price,
	   SUM(quantity) sum_quantity 
FROM food_orders
GROUP BY 1
) a


SELECT *
FROM food_orders left join payments on food_orders.order_id=payments.order_id 


SELECT fo.order_id,
	  fo.customer_id , 
	  fo.restaurant_name , 
	  fo.price, 
	  c.name, 
	  c.age, 
	  c.gender 
FROM food_orders fo left join customers c on fo.customer_id = c.customer_id 


SELECT fo.order_id ,
	   fo.restaurant_name,
	   fo.price ,
	   p.pay_type ,
	   p.vat
FROM food_orders fo left join payments p on fo.order_id = p.order_id 
WHERE cuisine_type ='Korean'


SELECT DISTINCT c.name ,
	   c.age ,
	   c.gender ,
	   f.restaurant_name 
FROM customers c left join food_orders f on c.customer_id = f.customer_id
ORDER BY c.name 


SELECT f.order_id ,
	   f.restaurant_name ,
	   f.price ,
	   p.vat ,
	   f.price * p.vat vat2
FROM food_orders f inner join payments p on f.order_id =p.order_id 


SELECT cuisine_type,
	   SUM(price) price,
	   SUM(price*discount_rate) discounted_price 
FROM 
(
SELECT f.cuisine_type,
	   f.price,
	   c.age,
	   (c.age-50)*0.005 discount_rate
FROM food_orders f left join customers c on f.customer_id =c.customer_id 
WHERE c.age>=50
) a
group by 1
order by SUM(price*discount_rate) desc 

