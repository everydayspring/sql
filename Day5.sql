SELECT *
FROM food_orders

SELECT *
FROM payments

SELECT *
FROM customers

SELECT restaurant_name ,
	   AVG(rating) avg_rating,
	   AVG(IF(rating <> 'Not given', rating, null)) avg_rating2 
FROM food_orders
group by 1


select a.order_id,
       a.customer_id,
       a.restaurant_name,
       a.price,
       b.name,
       b.age,
       b.gender
from food_orders a left join customers b on a.customer_id=b.customer_id
where b.customer_id is not null 


select a.order_id,
       a.customer_id,
       a.restaurant_name,
       a.price,
       b.name,
       b.age,
       coalesce(b.age, 20) "null 제거",
       b.gender
from food_orders a left join customers b on a.customer_id=b.customer_id
where b.age is null


SELECT name ,
	   age ,
	   CASE when age<15 then 15
	   		when age >=80 then 80
	   		else age end re_age
FROM customers


SELECT f.restaurant_name ,
	   SUBSTR(p.time, 1,2) hh,
	   COUNT(1) cnt_oider 
FROM food_orders f inner join payments p on f.order_id = p.order_id 
WHERE SUBSTR(p.time, 1,2) BETWEEN 15 and 20
GROUP By 1,2


select restaurant_name,
       max(if(hh='15', cnt_order, 0)) "15",
       max(if(hh='16', cnt_order, 0)) "16",
       max(if(hh='17', cnt_order, 0)) "17",
       max(if(hh='18', cnt_order, 0)) "18",
       max(if(hh='19', cnt_order, 0)) "19",
       max(if(hh='20', cnt_order, 0)) "20"
from 
(
select a.restaurant_name,
       substring(b.time, 1, 2) hh,
       count(1) cnt_order
from food_orders a inner join payments b on a.order_id=b.order_id
where substring(b.time, 1, 2) between 15 and 20
group by 1, 2
) a
group by 1
order by 7 desc



select age,
       max(if(gender='male', order_count, 0)) male,
       max(if(gender='female', order_count, 0)) female
from 
(
select b.gender,
       case when age between 10 and 19 then 10
            when age between 20 and 29 then 20
            when age between 30 and 39 then 30
            when age between 40 and 49 then 40
            when age between 50 and 59 then 50 end age,
       count(1) order_count
from food_orders a inner join customers b on a.customer_id=b.customer_id
where b.age between 10 and 59
group by 1, 2
) t
group by 1
order by age

SELECT age,
	   max(if(gender='male', cnt_order, 0)) 'male',
	   max(if(gender='female', cnt_order, 0)) 'female'
FROM 
(
SELECT gender ,
	   CASE when age between 10 and 19 then 10
	   		when age between 20 and 29 then 20
	   		when age between 30 and 39 then 30
	   		when age between 40 and 49 then 40
	   		when age between 50 and 59 then 50 end age,
	   	COUNT(1) cnt_order 
FROM food_orders f inner join customers c on f.customer_id = c.customer_id 
WHERE age BETWEEN 10 and 59
GROUP BY 1,2
) a 
GROUP by 1
order by 1 DESC 




select cuisine_type,
       restaurant_name,
       order_count,
       rn "순위"
from
(
select cuisine_type,
       restaurant_name,
       rank() over (partition by cuisine_type order by order_count desc) rn,
       order_count
from
(
select cuisine_type, restaurant_name, count(1) order_count
from food_orders
group by 1, 2
) a
) b
where rn<=3
order by 1, 4



SELECT cuisine_type,
	   restaurant_name,
	   cnt_order,
	   ranking
FROM 
(
SELECT cuisine_type,
	   restaurant_name,
	   cnt_order,
	   RANK() over (partition by cuisine_type order by cnt_order desc) ranking
FROM 
(
SELECT cuisine_type ,
	   restaurant_name ,
	   COUNT(1) cnt_order 
FROM food_orders f
group by 1,2 
) a
) b
WHERE ranking<=3



SELECT cuisine_type,
	   restaurant_name,
	   cnt_order,
	   sum(cnt_order) over (partition by cuisine_type) sum_cuisine,
	   sum(cnt_order) over (partition by cuisine_type order by cnt_order) cum_cuisine
FROM 
(
SELECT cuisine_type ,
	   restaurant_name ,
	   COUNT(1) cnt_order 
FROM food_orders f
group by 1,2 
) a
order by cuisine_type, cnt_order



SELECT date,
	   date(date) change_date
FROM payments



select date(date) date_type,
       date_format(date(date), '%Y') "년",
       date_format(date(date), '%m') "월",
       date_format(date(date), '%d') "일",
       date_format(date(date), '%w') "요일"
from payments



select date_format(date(date), '%Y') y,
       date_format(date(date), '%m') m,
       count(1) order_count
from food_orders a inner join payments b on a.order_id=b.order_id
where date_format(date(date), '%m')='03'
group by 1, 2
order by 1


select date_format(date(date), '%Y') y,
       date_format(date(date), '%m') m,
       date_format(date(date), '%Y%m') ym,
       count(1) order_count
from food_orders a inner join payments b on a.order_id=b.order_id
where date_format(date(date), '%m')='03'
group by 1, 2 
order by 1




