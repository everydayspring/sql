SELECT *
FROM food_orders

SELECT *
FROM payments

SELECT *
FROM customers

SELECT restaurant_name,
	   CASE when avg_price <=5000 then 'price_group1'
	   		when avg_price <=10000 then 'price_group2'
	   		when avg_price <=30000 then 'price_group3'
	   ELSE 'price_group4' end price_group,
	   CASE when avg_age <30 then 'age_group1'
	   		when avg_age <40 then 'age_group2'
	   		when avg_age <50 then 'age_group3'
	   		ELSE 'age_group4'end age_group
FROM 
(
SELECT f.restaurant_name ,
	   AVG(f.price) avg_price,
	   AVG(c.age) avg_age
FROM food_orders f left join customers c on f.customer_id =c.customer_id 
GROUP BY 1
ORDER BY f.restaurant_name 
) a