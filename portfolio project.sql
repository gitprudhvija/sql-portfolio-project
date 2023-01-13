create table orders1(row_id int,order_id int primary key,order_date date,ship_date date ,ship_mode varchar(30),customer_id varchar(30),customer_name varchar(50),
segment varchar(30),country_region varchar(50),city varchar(50),state varchar(50),postal_code int,region varchar(20),product_id varchar(30),
category varchar(50),sub_category varchar(50),product_name varchar(100),sales float,quantity float,discount float,profit float)

load data local infile  "C:/Users/prudhvija/Downloads/Sample - Superstore.csv " into table orders1
CHARACTER SET 'latin1'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
ignore 1 rows

select * from orders1

create table people(person varchar(20),region varchar(10))

load data local infile  "C:/Users/prudhvija/Downloads/people.csv" into table people
CHARACTER SET 'latin1'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
ignore 1 rows

select * from people


create table returns(returned varchar(10),orderid varchar(30) references orders1(order_id))


load data local infile  "C:/Users/prudhvija/Downloads/returns.csv" into table returns
CHARACTER SET 'latin1'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
ignore 1 rows

select * from returns

--------------Top 10 Customers-------------
select * from orders1 limit 1,9 


------------- Sales By Region-----------
select country_region,sales  from  orders1     group by country_region order by sales desc


-------------------- Sales By Segment---------
select segment,sales from  orders1     group by segment  order by sales desc

--------------Sales By State-------------
select state,sales   from  orders1     group by state order by sales desc

---------------- Sales By Quantity---------
select quantity,sales  from  orders1     group by quantity  order by sales desc

---------------- Sales By Category--------------
select category,salesas  from  orders1     group by category order by sales desc

----------------- Profit By Category------------------
select profit,category from  orders1      group by profit order by sales desc

----------------- Profit By State----------------------
select profit,state from  orders1      group by profit order by profit desc

-------------------Profit by Segment----------------------
select profit,segment from  orders1      group by segment  order by profit desc

--------------------- Discount By Category-------------------
select discount,category from  orders1      group by category  order by discount desc
------------------Checking For Null Values----------------------
SELECT CustomerName, ContactName, Address
FROM orders1
WHERE order_id IS NULL;
----------------------Checking For Duplicate Values----------------------
WITH cte AS (
SELECT order_id,ROW_NUMBER() OVER (
PARTITION BY order_id
ORDER BY order_id) AS row_num
FROM orders1
)  
SELECT * 
FROM cte  
WHERE row_num > 1;
----------------------Calculating Number of Shipping Days---------------------
select order_date,ship_date,(ship_date-order_date)as no.of.shipping days from orders1 order by no.of.shipping days desc

-----------------------Calculating Total Profit--------------------------
select city,state,segment,region,category,(sales*quantity)as total_profit  from orders1 group by city,state,segment,region,category order by total_profit desc

--------------------------Knowing The Shipping days-----------------
SELECT order_id,order_date,ship_date, State, City FROM orders1  (
CASE 
WHEN no.of.shipping days<=2  THEN fast shipping
WHEN no.of.shipping days between 3 and 5  THEN fast moderate shipping
ELSE late shipping
END);

---------------------Count Of Returns-------------------
select count(returned)from  returns

----------------------------------Joining The Tables-------------------------
CREATE  TABLE CUST_SALES_ORDER_TBL AS
  SELECT A.*,B.returned ,C.person,C.region
  FROM SALES_ORDER A
  INNER JOIN returns B ON A.order_id = B.orderid
  full outer join people C on A.regoin = C.region





                              ----------------------------Analysis of the above dataset----------------------

  
  (1) We can clearly see that phones, storage and binders get sold the most by yielding maximum sales and profit to the megastore. So, let the sales team know how important those products are for our annual revenue.

(2) On the other hand, we can see a large volume of tables and machines getting sold but their profit seems to be surprisingly lower than the peers. Are we underselling? Should we increase the price of the products?

(3) Not many Appliances are getting sold from the mega store  their profit margin seems to be really high. Hence, let the sales team know that it would be good if the team can come up with more innovative measures to drive up the sales of those appliances.

(4) Finally, revisit our sales and marketing strategy to ensure that an adequate number of furnishings, bookcases and art get sold with a revised markup price.

Conclusion:

 we have a glance into  the  insights from similar & dissimilar data . From here, we can proceed with the exploratory data analysis either in R or Python to identify other significant components in the dataset that actually drive sales for furthe correlation.




  
  
  