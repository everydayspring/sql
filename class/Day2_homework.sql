SELECT *
FROM food_orders

SELECT *
FROM payments

SELECT cuisine_type ,
		MIN(price) min_price,
		MAX(price) max_price
FROM food_orders
group by cuisine_type 
order by MIN(price) DESC 