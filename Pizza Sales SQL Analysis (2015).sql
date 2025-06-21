/** Creating the Pizza Table **/
Create table pizza_sales (
pizza_id int primary key, order_id int, pizza_name_id varchar, quantity int, order_date date, order_time time,
unit_price decimal(10,2), total_price decimal(10,2), pizza_size varchar, pizza_category varchar, pizza_ingredients varchar,
pizza_name varchar
);

/**Importing the pizza_sales table **/
copy pizza_sales
from 'C:\Program Files\PostgreSQL\pizza_sales.csv' delimiter ',' csv header

/** KPIs **/
/** Total Revenue **/
select sum(total_price) as Revenue
from pizza_sales

/** Avg. Unit Price **/
select cast(avg(unit_price) as decimal(10,2)) as Avg_Unit_Price
from pizza_sales

/** Total Orders **/
select count(pizza_id) as total_orders
from pizza_sales

/** Average Order Value **/
select cast(sum(total_price)/count(pizza_id) as decimal(10,2)) as AOV
from pizza_sales

/** Other Charts **/
/** Revenue by Order Hour **/
select 
extract(hour from order_time) as hour,
count(pizza_id) as num_of_orders
from pizza_sales
group by extract(hour from order_time)
order by num_of_orders desc

/** Revenue by Veg. Vs  Non Veg. Orders **/
select
	case 
		when pizza_category = 'Veggie' then 'Vegetarian'
		else 'Non-Vegetarian'
	end as Preference_group,
	sum(total_price) as Revenue
from pizza_sales
group by preference_group
order by Revenue desc

/** Revenue by Weekday **/
select
to_char(order_date, 'Day') as Weekday,
sum(total_price) as Revenue
from pizza_sales
group by to_char(order_date, 'Day') 
order by Revenue desc

/** Revenue by Pizza size **/
select pizza_size,
sum(total_price) as Revenue,
count(pizza_id) as num_of_orders
from pizza_sales
group by pizza_size
order by revenue desc

/** Revenue by Pizza Category **/
select pizza_category,
sum(total_price) as Revenue,
count(pizza_id) as num_of_orders
from pizza_sales
group by pizza_category
order by Revenue desc

/** Top earning pizza flavours **/
select pizza_name,
count(pizza_id) as num_of_orders,
sum(total_price) as Revenue
from pizza_sales
group by pizza_name
order by Revenue desc
limit 10

/** aov by pizza_name **/
select pizza_name,
sum(total_price) as Revenue,
count(pizza_id) as num_of_orders,
cast(sum(total_price)/count(pizza_id) as decimal(10,2)) as aov
from pizza_sales
group by pizza_name
order by aov desc

/** aov by month **/
select
extract(month from order_date) as month,
sum(total_price) as revenue,
count(pizza_id) as Orders,
cast(sum(total_price)/count(pizza_id) as decimal(10,2)) as aov_month
from pizza_sales
group by extract(month from order_date)
order by month

/** Revenue by Month **/
select
extract (month from order_date) as month,
count(pizza_id) as num_of_orders,
sum(total_price) as Revenue
from pizza_sales
group by extract (month from order_date)
order by month


























