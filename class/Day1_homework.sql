SELECT restaurant_name, customer_id 
FROM food_orders
WHERE food_preparation_time BETWEEN 20 AND 30
AND cuisine_type = 'Korean'