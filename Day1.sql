SELECT *
FROM food_orders

SELECT *
FROM payments

SELECT *
FROM customers

-- 컬럼명 변경

SELECT restaurant_name, addr 
FROM food_orders

SELECT restaurant_name as "음식점", addr address
FROM food_orders

SELECT order_id as ord_no, restaurant_name "식당 이름"
FROM food_orders

SELECT order_id as ord_no,
	price "가격",
	quantity "수량"
FROM food_orders

SELECT name "이름", email "e-mail"
FROM customers

-- where

SELECT *
FROM customers
WHERE age=21

SELECT *
FROM customers c 
WHERE gender='male'

SELECT *
FROM food_orders
WHERE cuisine_type='Korean'

SELECT *
FROM payments 
WHERE pay_type ='card'

-- 비교연산자

SELECT *
FROM customers
WHERE age >= 21

SELECT *
FROM customers
WHERE gender <> 'male'

SELECT *
FROM customers
WHERE age BETWEEN 21 AND 23

SELECT *
FROM customers
WHERE age IN (21, 25, 27)

SELECT *
FROM customers
WHERE name IN ('윤주아', '정현준')

SELECT * 
FROM customers
WHERE name LIKE '김%'

SELECT *
FROM customers c 
WHERE age >= 40

SELECT *
FROM food_orders
WHERE price < 15000

SELECT * 
FROM food_orders
WHERE price BETWEEN 20000 AND 30000

SELECT *
FROM food_orders fo 
WHERE fo.restaurant_name LIKE 'B%'

SELECT *
FROM customers
WHERE age >=21 
AND gender ='male'
	
SELECT *
FROM food_orders
WHERE cuisine_type ='Korean' AND price>=30000

SELECT *
FROM payments
WHERE pay_type = 'card' OR vat <=0.2
