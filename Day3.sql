SELECT *
FROM food_orders

SELECT *
FROM payments

SELECT *
FROM customers


select restaurant_name "원래 상점명",
       replace(restaurant_name, 'Blue', 'Pink') "바뀐 상점명"
from food_orders
where restaurant_name like '%Blue Ribbon%'


SELECT addr, 
		REPLACE (addr, '문곡리', '문가리') "바뀐주소"
FROM food_orders
WHERE addr LIKE '%문곡리%'



-- substring

select addr "원래 주소",
       substr(addr, 1, 2) "시도"
from food_orders
where addr like '%서울특별시%'


select restaurant_name "원래 이름",   
       addr "원래 주소",
       concat('[', substring(addr, 1, 2), '] ', restaurant_name) "바뀐 이름"
from food_orders
where addr like '%서울%'


select restaurant_name "원래 이름",   
       addr "원래 주소",
       CONCAT(restaurant_name, '-', cuisine_type) "음식타입별 음식점" ,
       concat('[', substring(addr, 1, 2), '] ', restaurant_name) "바뀐 이름"
from food_orders
where addr like '%서울%'


SELECT SUBSTR(addr, 1, 2) "지역",
		cuisine_type ,
		AVG(price) "평균금액" 
FROM food_orders
WHERE addr LIKE '서울%'
GROUP BY 1,2


SELECT SUBSTR(email, 10) "도메인",
		COUNT(1) "고객수",
		AVG(age) "평균 연령" 
FROM customers
GROUP BY 1


SELECT CONCAT('[', SUBSTR(addr, 1, 2), ']', restaurant_name, '(', cuisine_type,')') "음식점",
		count(1)
FROM  food_orders
GROUP BY 1


select restaurant_name,
       cuisine_type "원래 음식 타입",
       if(cuisine_type='Korean', '한식', '기타') "음식 타입"
from food_orders


select addr "원래 주소",
       if(addr like '%평택군%', replace(addr, '문곡리', '문가리'), addr) "바뀐 주소"
from food_orders
where addr like '%문곡리%'


select substring(if(email like '%gmail%', replace(email, 'gmail', '@gmail'), email), 10) "이메일 도메인",
       count(customer_id) "고객 수",
       avg(age) "평균 연령"
from customers
group by 1

SELECT CASE WHEN cuisine_type ='Korean' THEN '한식'
			WHEN cuisine_type IN ('Japanese', 'Chinese') THEN '아시아'
			ELSE '기타' END "음식타입",
		cuisine_type 
FROM food_orders


select order_id,
       price,
       quantity,
       case when quantity=1 then price
            when quantity>=2 then price/quantity end "음식 단가"
from food_orders


select restaurant_name,
       addr,
       case when addr like '%경기도%' then '경기도'
            when addr like '%특별%' or addr like '%광역%' then substring(addr, 1, 5)
            else substring(addr, 1, 2) end "변경된 주소"
from food_orders

SELECT CASE when (age between 10 and 19) and gender ='male' THEN '10대 남성'
			when (age between 10 and 19) and gender ='female' THEN '10대 여성'
			when (age between 20 and 29) and gender ='male' THEN '20대 남성'
			when (age between 20 and 29) and gender ='female' THEN '20대 여성' END '고객 분류',
		name,
		age,
		gender
FROM customers
WHERE age BETWEEN 10 AND 29


select restaurant_name,
       price/quantity "단가",
       cuisine_type,
       order_id,
       case when (price/quantity <5000) and cuisine_type='Korean' then '한식1'
            when (price/quantity between 5000 and 15000) and cuisine_type='Korean' then '한식2'
            when (price/quantity > 15000) and cuisine_type='Korean' then '한식3'
            when (price/quantity <5000) and cuisine_type in ('Japanese', 'Chinese', 'Thai', 'Vietnamese', 'Indian') then '아시아식1'
            when (price/quantity between 5000 and 15000) and cuisine_type in ('Japanese', 'Chinese', 'Thai', 'Vietnamese', 'Indian') then '아시아식2'
            when (price/quantity > 15000) and cuisine_type in ('Japanese', 'Chinese', 'Thai', 'Vietnamese', 'Indian') then '아시아식3'
            when (price/quantity <5000) and cuisine_type not in ('Korean', 'Japanese', 'Chinese', 'Thai', 'Vietnamese', 'Indian') then '기타1'
            when (price/quantity between 5000 and 15000) and cuisine_type not in ('Korean', 'Japanese', 'Chinese', 'Thai', 'Vietnamese', 'Indian') then '기타2'
            when (price/quantity > 15000) and cuisine_type not in ('Korean', 'Japanese', 'Chinese', 'Thai', 'Vietnamese', 'Indian') then '기타3' end "식당 그룹"
from food_orders


SELECT CASE when delivery_time >30 then price*0.1*if(addr like '서울%', 1.1, 1)
			when delivery_time >25 then price*0.05*if(addr like '서울%', 1.1, 1)
			else 0 end '수수료',
		restaurant_name,
		order_id,
		price,
		delivery_time,
		addr
FROM food_orders


SELECT CASE when day_of_the_week='weekday' then 3000*if(quantity > 3, 1.2, 1)
			when day_of_the_week='weekend' then 3500*if(quantity > 3, 1.2, 1)
			end '배달할증료',
		restaurant_name,
		order_id,
		day_of_the_week,
		quantity
FROM food_orders
