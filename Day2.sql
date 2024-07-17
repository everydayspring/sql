SELECT *
FROM food_orders

SELECT *
FROM payments

-- 연산 합계 평균 갯수 최대 최소

SELECT food_preparation_time,
       delivery_time,
       food_preparation_time + delivery_time as total_time
FROM food_orders


select sum(food_preparation_time) total_food_preparation_time,
       avg(delivery_time) avg_delivery_time
from food_orders


SELECT AVG(age) AS average_of_age
FROM customers


-- distinct 중복제거
select count(1) count_of_orders,
       count(distinct customer_id) count_of_customers
from food_orders


SELECT COUNT(1) as total_count 
FROM payments


SELECT COUNT(DISTINCT pay_type) ad count_of_pay_type
FROM payments


select min(price) min_price,
       max(price) max_price
from food_orders


SELECT min(quantity) as min_quantity,
		max(quantity) as max_quantity
FROM food_orders


SELECT COUNT(1) cnt_orders
FROM food_orders
WHERE  price >=30000


SELECT AVG(price) average_price 
FROM food_orders
WHERE cuisine_type = 'Korean'


-- group by

select cuisine_type,
       sum(price) sum_of_price
from food_orders
group by cuisine_type


SELECT restaurant_name ,
		max(price) max_price
FROM food_orders
group by restaurant_name 


SELECT pay_type,
		MAX(`date`) recent_date 
FROM payments
group by pay_type 


-- order by / desc

select cuisine_type,
       sum(price) sum_of_price
from food_orders
group by cuisine_type
order by sum(price)


SELECT restaurant_name,
		MAX(price) max_price 
FROM food_orders
group by restaurant_name
order by max(price) DESC 


SELECT *
FROM customers
order by gender, name



