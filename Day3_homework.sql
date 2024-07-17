


SELECT order_id, restaurant_name, day_of_the_week, delivery_time,
	   CASE WHEN day_of_the_week='Weekday' THEN IF(delivery_time>=25, 'Late', 'On-time')
			WHEN day_of_the_week='Weekend' THEN IF(delivery_time>=30, 'Late', 'On-time')
			END '지연여부'
FROM food_orders