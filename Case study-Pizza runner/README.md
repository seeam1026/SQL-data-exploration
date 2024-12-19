# 🍕 Case Study #2 - Pizza Runner
<p align="center">
<img src="https://github.com/seeam1026/SQL-data-exploration/blob/main/IMG/org-2.png" width=40% height=40%>

## 📕 Table Of Contents
  - 🛠️ [Problem Statement](#problem-statement)
  - 📂 [Dataset](#-dataset)
  - ♻️ [Data Cleaning](#data-cleaning)
  - 🔍 [Data Exploration](#-data-exploration)

---

## Problem Statement

> Danny was scrolling through his Instagram feed when something really caught his eye - “80s Retro Styling and Pizza Is The Future!”
> 
> Danny was sold on the idea, but he knew that pizza alone was not going to help him get seed funding to expand his new Pizza Empire - so he had one more genius idea to combine with it - he was going to Uberize it - and so **Pizza Runner** was launched!
> 
> Danny started by recruiting “runners” to deliver fresh pizza from Pizza Runner Headquarters (otherwise known as Danny’s house) and also maxed out his credit card to pay freelance developers to build a mobile app to accept orders from customers.

---

## 📂 Dataset
Danny has shared with you 6 key datasets for this case study:

### **```runners```**
<details>
<summary>
View table
</summary>

The runners table shows the **```registration_date```** for each new runner.


|runner_id|registration_date|
|---------|-----------------|
|1        |1/1/2021         |
|2        |1/3/2021         |
|3        |1/8/2021         |
|4        |1/15/2021        |

</details>


### **```customer_orders```**

<details>
<summary>
View table
</summary>

Customer pizza orders are captured in the **```customer_orders```** table with 1 row for each individual pizza that is part of the order.

|order_id|customer_id|pizza_id|exclusions|extras|order_time        |
|--------|---------|--------|----------|------|------------------|
|1  |101      |1       |          |      |44197.75349537037 |
|2  |101      |1       |          |      |44197.79226851852 |
|3  |102      |1       |          |      |44198.9940162037  |
|3  |102      |2       |          |*null* |44198.9940162037  |
|4  |103      |1       |4         |      |44200.558171296296|
|4  |103      |1       |4         |      |44200.558171296296|
|4  |103      |2       |4         |      |44200.558171296296|
|5  |104      |1       |null      |1     |44204.87533564815 |
|6  |101      |2       |null      |null  |44204.877233796295|
|7  |105      |2       |null      |1     |44204.88922453704 |
|8  |102      |1       |null      |null  |44205.99621527778 |
|9  |103      |1       |4         |1, 5  |44206.47429398148 |
|10 |104      |1       |null      |null  |44207.77417824074 |
|10 |104      |1       |2, 6      |1, 4  |44207.77417824074 |

</details>

### **```runner_orders```**

<details>
<summary>
View table
</summary>

After each orders are received through the system - they are assigned to a runner - however not all orders are fully completed and can be cancelled by the restaurant or the customer.

The **```pickup_time```** is the timestamp at which the runner arrives at the Pizza Runner headquarters to pick up the freshly cooked pizzas. 

The **```distance```** and **```duration```** fields are related to how far and long the runner had to travel to deliver the order to the respective customer.



|order_id|runner_id|pickup_time|distance  |duration|cancellation      |
|--------|---------|-----------|----------|--------|------------------|
|1       |1        |1/1/2021 18:15|20km      |32 minutes|                  |
|2       |1        |1/1/2021 19:10|20km      |27 minutes|                  |
|3       |1        |1/3/2021 0:12|13.4km    |20 mins |*null*             |
|4       |2        |1/4/2021 13:53|23.4      |40      |*null*             |
|5       |3        |1/8/2021 21:10|10        |15      |*null*             |
|6       |3        |null       |null      |null    |Restaurant Cancellation|
|7       |2        |1/8/2020 21:30|25km      |25mins  |null              |
|8       |2        |1/10/2020 0:15|23.4 km   |15 minute|null              |
|9       |2        |null       |null      |null    |Customer Cancellation|
|10      |1        |1/11/2020 18:50|10km      |10minutes|null              |

</details>

### **```pizza_names```**

<details>
<summary>
View table
</summary>

|pizza_id|pizza_name|
|--------|----------|
|1       |Meat Lovers|
|2       |Vegetarian|

</details>

### **```pizza_recipes```**

<details>
<summary>
View table
</summary>

Each **```pizza_id```** has a standard set of **```toppings```** which are used as part of the pizza recipe.


|pizza_id|toppings |
|--------|---------|
|1       |1, 2, 3, 4, 5, 6, 8, 10| 
|2       |4, 6, 7, 9, 11, 12| 

</details>

### **```pizza_toppings```**

<details>
<summary>
View table
</summary>

This table contains all of the **```topping_name```** values with their corresponding **```topping_id```** value.


|topping_id|topping_name|
|----------|------------|
|1         |Bacon       | 
|2         |BBQ Sauce   | 
|3         |Beef        |  
|4         |Cheese      |  
|5         |Chicken     |     
|6         |Mushrooms   |  
|7         |Onions      |     
|8         |Pepperoni   | 
|9         |Peppers     |   
|10        |Salami      | 
|11        |Tomatoes    | 
|12        |Tomato Sauce|

</details>

## Data Cleaning
<details>
<summary>
Create table
</summary>

** **	
 ```sql
	DROP TABLE IF EXISTS runners;
	CREATE TABLE runners (
	  "runner_id" INTEGER,
	  "registration_date" DATE
	);
	INSERT INTO runners
	  ("runner_id", "registration_date")
	VALUES
	  (1, '2021-01-01'),
	  (2, '2021-01-03'),
	  (3, '2021-01-08'),
	  (4, '2021-01-15');
	
	
	DROP TABLE IF EXISTS customer_orders;
	CREATE TABLE customer_orders (
	  "order_id" INTEGER,
	  "customer_id" INTEGER,
	  "pizza_id" INTEGER,
	  "exclusions" VARCHAR(4),
	  "extras" VARCHAR(4),
	  "order_time" TIMESTAMP
	);
	
	INSERT INTO customer_orders
	  ("order_id", "customer_id", "pizza_id", "exclusions", "extras", "order_time")
	VALUES
	  ('1', '101', '1', '', '', '2020-01-01 18:05:02'),
	  ('2', '101', '1', '', '', '2020-01-01 19:00:52'),
	  ('3', '102', '1', '', '', '2020-01-02 23:51:23'),
	  ('3', '102', '2', '', NULL, '2020-01-02 23:51:23'),
	  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
	  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
	  ('4', '103', '2', '4', '', '2020-01-04 13:23:46'),
	  ('5', '104', '1', 'null', '1', '2020-01-08 21:00:29'),
	  ('6', '101', '2', 'null', 'null', '2020-01-08 21:03:13'),
	  ('7', '105', '2', 'null', '1', '2020-01-08 21:20:29'),
	  ('8', '102', '1', 'null', 'null', '2020-01-09 23:54:33'),
	  ('9', '103', '1', '4', '1, 5', '2020-01-10 11:22:59'),
	  ('10', '104', '1', 'null', 'null', '2020-01-11 18:34:49'),
	  ('10', '104', '1', '2, 6', '1, 4', '2020-01-11 18:34:49');
	
	
	DROP TABLE IF EXISTS runner_orders;
	CREATE TABLE runner_orders (
	  "order_id" INTEGER,
	  "runner_id" INTEGER,
	  "pickup_time" VARCHAR(19),
	  "distance" VARCHAR(7),
	  "duration" VARCHAR(10),
	  "cancellation" VARCHAR(23)
	);
	
	INSERT INTO runner_orders
	  ("order_id", "runner_id", "pickup_time", "distance", "duration", "cancellation")
	VALUES
	  ('1', '1', '2020-01-01 18:15:34', '20km', '32 minutes', ''),
	  ('2', '1', '2020-01-01 19:10:54', '20km', '27 minutes', ''),
	  ('3', '1', '2020-01-03 00:12:37', '13.4km', '20 mins', NULL),
	  ('4', '2', '2020-01-04 13:53:03', '23.4', '40', NULL),
	  ('5', '3', '2020-01-08 21:10:57', '10', '15', NULL),
	  ('6', '3', 'null', 'null', 'null', 'Restaurant Cancellation'),
	  ('7', '2', '2020-01-08 21:30:45', '25km', '25mins', 'null'),
	  ('8', '2', '2020-01-10 00:15:02', '23.4 km', '15 minute', 'null'),
	  ('9', '2', 'null', 'null', 'null', 'Customer Cancellation'),
	  ('10', '1', '2020-01-11 18:50:20', '10km', '10minutes', 'null');
	
	
	DROP TABLE IF EXISTS pizza_names;
	CREATE TABLE pizza_names (
	  "pizza_id" INTEGER,
	  "pizza_name" TEXT
	);
	INSERT INTO pizza_names
	  ("pizza_id", "pizza_name")
	VALUES
	  (1, 'Meatlovers'),
	  (2, 'Vegetarian');
	
	
	DROP TABLE IF EXISTS pizza_recipes;
	CREATE TABLE pizza_recipes (
	  "pizza_id" INTEGER,
	  "toppings" TEXT
	);
	INSERT INTO pizza_recipes
	  ("pizza_id", "toppings")
	VALUES
	  (1, '1, 2, 3, 4, 5, 6, 8, 10'),
	  (2, '4, 6, 7, 9, 11, 12');
	
	
	DROP TABLE IF EXISTS pizza_toppings;
	CREATE TABLE pizza_toppings (
	  "topping_id" INTEGER,
	  "topping_name" TEXT
	);
	INSERT INTO pizza_toppings
	  ("topping_id", "topping_name")
	VALUES
	  (1, 'Bacon'),
	  (2, 'BBQ Sauce'),
	  (3, 'Beef'),
	  (4, 'Cheese'),
	  (5, 'Chicken'),
	  (6, 'Mushrooms'),
	  (7, 'Onions'),
	  (8, 'Pepperoni'),
	  (9, 'Peppers'),
	  (10, 'Salami'),
	  (11, 'Tomatoes'),
	  (12, 'Tomato Sauce');
```		
</details>

<details>
<summary>
Cleaning Data
</summary>

## Clean customer_orders data:
**```customer_orders```**
- Converting ```null``` and ```NaN``` values into blanks ```''``` in ```exclusions``` and ```extras```
```sql
	UPDATE customer_orders
	SET exclusions = CASE WHEN exclusions = '' or exclusions LIKE '%null%' or exclusions LIKE '%nan%' THEN NULL ELSE exclusions END,
	    extras = CASE WHEN extras = '' or extras LIKE '%null%' or extras LIKE '%nan%' THEN NULL ELSE extras END;
```
## Clean runner_orders data:
**```runner_orders```**

- Converting ```'null'``` text values into null values for ```pickup_time```, ```distance``` and ```duration```
- Extracting only numbers and decimal spaces for the distance and duration columns
- Converting blanks, ```'null'``` and ```NaN``` into null values for cancellation 
  ```sql
   UPDATE runner_orders
   SET 	pickup_time = CASE WHEN pickup_time LIKE '%null%' THEN NULL ELSE pickup_time END,
  	distance = CASE WHEN distance LIKE '%null%' THEN NULL ELSE distance END,
  	duration = CASE WHEN duration LIKE '%null%' THEN NULL ELSE duration END,
  	cancellation = CASE WHEN cancellation LIKE '%null%' or cancellation LIKE '%nan%' or cancellation = '' THEN NULL ELSE cancellation END;

    UPDATE runner_orders
    SET	distance = replace(distance, 'km', ''),
  	duration = trim(regexp_replace(duration, 'minute|mins|min|minutes', ''));

    SELECT * FROM runner_orders;
  ```

## Clean pizza_recipes data:
**```pizza_recipes```**

```sql
   CREATE TEMP TABLE temp_pizza_recipe(pizza_id INT, pizza_topping TEXT);
   INSERT INTO temp_pizza_recipe(pizza_id, pizza_topping)
   SELECT pizza_id, unnest(string_to_array(toppings, ',')) 
   FROM pizza_recipes;
   TRUNCATE TABLE pizza_recipes;
   INSERT INTO pizza_recipes(pizza_id, toppings)
   SELECT pizza_id, pizza_topping FROM temp_pizza_recipe;
   SELECT * FROM pizza_recipes;
	
   DROP TABLE IF EXISTS temp_pizza_recipe;
	
   ALTER TABLE pizza_recipes 
   ALTER COLUMN toppings TYPE INT
   USING toppings::INT;
```
	
</details>


## 🔍 Data Exploration

<details>
<summary> 
Pizza Metrics
</summary>

### **Q1. How many pizzas were ordered?**
```sql
SELECT COUNT(pizza_id) as pizza_count
FROM customer_orders
```
|pizza_count|
|-----------|
|14         |

### **Q2. How many unique customer orders were made?**
```sql
SELECT COUNT(DISTINCT order_id) AS order_count
FROM customer_orders;
```
|order_count|
|-----------|
|10         |


### **Q3. How many successful orders were delivered by each runner?**
```sql
 SELECT runner_id,
	COUNT(order_id) AS successful_orders
 FROM runner_orders
 WHERE cancellation is NULL
 GROUP BY runner_id;
```

| runner_id | successful_orders |
|-----------|-------------------|
| 1         | 4                 |
| 2         | 3                 |
| 3         | 1                 |


### **Q4. How many of each type of pizza was delivered?**
```SQL
SELECT  pizza_names.pizza_name,
	cte.pizza_type_count
FROM pizza_names
JOIN	
	(SELECT co.pizza_id,
		COUNT(co.order_id) AS pizza_type_count
	FROM runner_orders AS ru
	JOIN customer_orders AS co 
	ON co.order_id = ru.order_id 
	WHERE ru.cancellation is NULL
	GROUP BY co.pizza_id) AS cte
ON cte.pizza_id = pizza_names.pizza_id
```

| pizza_name | pizza_type_count |
|------------|------------------|
| Meatlovers | 9                |
| Vegetarian | 3                |


### **Q5. How many Vegetarian and Meatlovers were ordered by each customer?**
```SQL
SELECT 	customer_id, 
	SUM(CASE WHEN pizza_id = 1 THEN 1 ELSE 0 END) AS meat_lovers,
	SUM(CASE WHEN pizza_id = 2 THEN 1 ELSE 0 END) AS vegetarian
FROM customer_orders
GROUP BY customer_id;
```

| customer_id | meat_lovers | vegetarian |
|-------------|-------------|------------|
| 101         | 2           | 1          |
| 103         | 3           | 1          |
| 104         | 3           | 0          |
| 105         | 0           | 1          |
| 102         | 2           | 1          |

### **Q6. What was the maximum number of pizzas delivered in a single order?**
```SQL
SELECT MAX(pizza_count_per_order) AS max_count
FROM (
  SELECT
	co.order_id,
	COUNT(co.pizza_id) AS pizza_count_per_order
  FROM runner_orders AS ru
  JOIN customer_orders AS co
  	ON co.order_id = ru.order_id
  WHERE ru.cancellation is NULL
  GROUP BY co.order_id) AS cte;
 ``` 

| max_count |
|-----------|
| 3         |


### **Q7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?**
```SQL
SELECT
  co.customer_id,
  SUM(CASE WHEN co.exclusions IS NOT NULL OR co.extras IS NOT NULL THEN 1 ELSE 0 END) AS changes,
  SUM(CASE WHEN co.exclusions is NULL AND co.extras is NULL THEN 1 ELSE 0 END) AS no_change
FROM runner_orders AS ru
JOIN customer_orders AS co
  ON ru.order_id = co.order_id
WHERE ru.cancellation is NULL
GROUP BY co.customer_id
ORDER BY co.customer_id;
```

| customer_id | changes | no_change |
|-------------|---------|-----------|
| 101         | 0       | 2         |
| 102         | 0       | 3         |
| 103         | 3       | 3         |
| 104         | 2       | 2         |
| 105         | 1       | 1         |


### **Q8. How many pizzas were delivered that had both exclusions and extras?**
```SQL
SELECT
  SUM(CASE WHEN co.exclusions IS NOT NULL AND co.extras IS NOT NULL THEN 1 ELSE 0 END) AS pizza_count
FROM runner_orders AS ru
JOIN customer_orders AS co
  ON co.order_id = ru.order_id
WHERE ru.cancellation IS NULL;
```  

| pizza_count |
|-------------|
| 1           |


### **Q9. What was the total volume of pizzas ordered for each hour of the day?**
```SQL
SELECT
  DATE_PART('hour', order_time) AS hour_of_day,
  COUNT(pizza_id) as pizza_count
FROM customer_orders
GROUP BY hour_of_day
ORDER BY hour_of_day;
```

| hour_of_day | pizza_count |
|-------------|-------------|
| 11          | 1           |
| 12          | 2           |
| 13          | 3           |
| 18          | 3           |
| 19          | 1           |
| 21          | 3           |
| 23          | 1           |

### **Q10. What was the volume of orders for each day of the week?**
```SQL
SELECT
  TO_CHAR(order_time,'day') AS day_of_week,
  COUNT(pizza_id) AS pizza_count
FROM customer_orders
GROUP BY day_of_week, DATE_PART('dow', order_time)
ORDER BY DATE_PART('dow', order_time);
```

| day_of_week | pizza_count |
|-------------|-------------|
| Friday      | 1           |
| Saturday    | 5           |
| Thursday    | 3           |
| Wednesday   | 5           |

</details>

<details>
<summary>
Runner and Customer Experience
</summary>

### **Q1. How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)**
```SQL
WITH runner_signups AS (
  SELECT
    runner_id,
    registration_date,
    registration_date - ((registration_date - '2021-01-01') % 7)  AS start_of_week
  FROM pizza_runner.runners
)
SELECT
  start_of_week,
  COUNT(runner_id) AS signups
FROM runner_signups
GROUP BY start_of_week
ORDER BY start_of_week;
```

| start_of_week            | signups |
|--------------------------|---------|
| 2021-01-01T00:00:00.000Z | 2       |
| 2021-01-08T00:00:00.000Z | 1       |
| 2021-01-15T00:00:00.000Z | 1       |

### **Q2. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?**
```SQL
SELECT
  ru.runner_id,
  DATE_PART('minute', AVG(ru.pickup_time::timestamp - co.order_time)) AS avg_arrival_minutes
FROM runner_orders AS ru
JOIN customer_orders AS co 
 ON co.order_id = ru.order_id
WHERE ru.cancellation IS NULL
GROUP BY ru.runner_id;
```
| runner_id | avg_arrival_minutes |
|-----------|---------------------|
| 1         | 15                  |
| 2         | 23                  |
| 3         | 10                  |

### **Q3. Is there any relationship between the number of pizzas and how long the order takes to prepare?**
```SQL
SELECT
  ru.order_id,
  count(co.pizza_id) AS pizzas_count,
  ROUND(EXTRACT(EPOCH FROM (ru.pickup_time::TIMESTAMP - co.order_time))::DECIMAL/60, 2) AS avg_time,
  CASE  WHEN COUNT(co.pizza_id) = 1 THEN 'Takes more than 10 minutes to prepare'
	WHEN COUNT(co.pizza_id) > 1 THEN 'Preparation time is based on order quantity, approximately or more than 10 minutes per order' END AS relationship
FROM runner_orders AS ru
JOIN customer_orders AS co
  ON co.order_id = ru.order_id 
WHERE ru.pickup_time IS NOT NULL
GROUP BY ru.order_id, ru.pickup_time, co.order_time
ORDER BY ru.order_id;
```

|order_id| pizzas_count | avg_time |			relationship		                |
|--------|--------------|----------|------------------------------------------------|
|  1	 |	1	        |   10.53  |	Takes more than 10 minutes to prepare	    |
|  2	 |	1	        |   10.03  |	Takes more than 10 minutes to prepare	    |
|  3	 |	2	        |   21.23  |	Preparation time is based on order quantity |
|  4	 |	3	        |   29.28  |	Preparation time is based on order quantity |
|  5	 |	1	        |   10.47  |	Takes more than 10 minutes to prepare	    |
|  7	 |	1	        |   10.27  |	Takes more than 10 minutes to prepare	    |
|  8	 |	1	        |   20.48  |	Takes more than 10 minutes to prepare	    |
|  10	 |	2	        |   15.52  |	Preparation time is based on order quantity |

### **Q4. What was the average distance travelled for each runner?**
```SQL
SELECT  runner_id,
	ROUND(AVG(distance::DECIMAL), 2) AS avg_distance
FROM runner_orders
GROUP BY runner_id
ORDER BY runner_id;
```

| runner_id | avg_distance |
|-----------|--------------|
| 1         | 15.85        |
| 2         | 23.93        |
| 3         | 10.00        |

### **Q5. What was the difference between the longest and shortest delivery times for all orders?**
```SQL
SELECT MAX(duration::INT) - MIN(duration::INT) AS difference
FROM runner_orders;
```

| difference |
|------------|
| 30         |

### **Q6. What was the average speed for each runner for each delivery and do you notice any trend for these values?**
```SQL
SELECT
  ru.order_id,
  ru.runner_id,
  COUNT(co.pizza_id) AS pizza_count,
  ROUND(AVG(distance::DECIMAL), 1) AS distance,
  ROUND(AVG(duration::INT), 1) AS duration,
  ROUND(AVG(ru.distance::DECIMAL/ru.duration::INT)*60, 2) AS speed_kmh
FROM runner_orders AS ru
JOIN customer_orders AS co
  ON ru.order_id = co.order_id
WHERE ru.cancellation IS NULL
GROUP BY ru.order_id, ru.runner_id
ORDER BY speed_kmh DESC;
```

| order_id | runner_id | pizzas_count | distance | duration | speed_kmh |
|----------|-----------|--------------|----------|----------|-----------|
| 8        | 2         | 1            | 23.4     | 15       | 93.60 	|
| 7        | 2         | 1            | 25       | 25       | 60.00 	|
| 10       | 1         | 2            | 10       | 10       | 60.00 	|
| 2        | 1         | 1            | 20       | 27       | 44.44 	|
| 3        | 1         | 2            | 13.4     | 20       | 40.20 	|
| 5        | 3         | 1            | 10       | 15       | 40.00 	|
| 1        | 1         | 1            | 20       | 32       | 37.50 	|
| 4        | 2         | 3            | 23.4     | 40       | 35.10 	|

**Finding:**
- **Orders are listed in decreasing order of average speed:**
> *Although the fastest order delivered only 1 pizza and the slowest order delivered 3 pizzas, there is no clear trend indicating that more pizzas in an order result in slower delivery speeds.*


### **Q7. What is the successful delivery percentage for each runner?**
```sql
SELECT
  ru.runner_id,
  ROUND(100.0*cte.successful_order/COUNT(ru.order_id)) AS delivery_percent
FROM runner_orders AS ru
JOIN (
    SELECT
	runner_id,
	COUNT(order_id) AS successful_order
    FROM runner_orders
    WHERE pickup_time IS NOT NULL
    GROUP BY runner_id) AS cte
 ON cte.runner_id = ru.runner_id
GROUP BY ru.runner_id, cte.successful_order
ORDER BY ru.runner_id;
```

| runner_id | delivery_percent |
|-----------|------------------|
| 1         | 100              |
| 2         | 75               |
| 3         | 50               |


</details>
