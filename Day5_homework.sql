SELECT cuisine_type,
		max(IF(age_group = 10, cnt_orders, 0)) '10',
		max(IF(age_group = 20, cnt_orders, 0)) '20',
		max(IF(age_group = 30, cnt_orders, 0)) '30',
		max(IF(age_group = 40, cnt_orders, 0)) '40',
		max(IF(age_group = 50, cnt_orders, 0)) '50'
FROM
(
SELECT f.cuisine_type, 
	   CASE WHEN c.age BETWEEN 10 AND 19 THEN 10
	   		WHEN c.age BETWEEN 20 AND 29 THEN 20
	   		WHEN c.age BETWEEN 30 AND 39 THEN 30
	   		WHEN c.age BETWEEN 40 AND 49 THEN 40
	   		WHEN c.age BETWEEN 50 AND 59 THEN 50 END age_group,
	   	count(1) AS cnt_orders
FROM food_orders f INNER JOIN customers c ON f.customer_id = c.customer_id 
WHERE c.age BETWEEN 10 AND 59
GROUP BY cuisine_type, age_group
) a
GROUP BY cuisine_type