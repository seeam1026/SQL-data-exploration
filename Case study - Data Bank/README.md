# 💰 Case Study #4 💰 Data Bank
<p align="center">
<img src="https://github.com/seeam1026/SQL-data-exploration/blob/main/IMG/org-2.png" width=40% height=40%>

## 📕 Table Of Contents
  - 🛠️ [Problem Statement](#problem-statement)
  - [Entity Relationship Diagram]
  - 📂 [Dataset](#dataset)
  - 🔍 [Data Exploration](#data-exploration)

---

## 🛠️ Problem Statement

There is a new innovation in the financial industry called Neo-Banks: new aged digital only banks without physical branches.

Danny thought that there should be some sort of intersection between these new age banks, cryptocurrency and the data world…so he decides to launch a new initiative - Data Bank!

Data Bank runs just like any other digital bank - but it isn’t only for banking activities, they also have the world’s most secure distributed data storage platform!

Customers are allocated cloud data storage limits which are directly linked to how much money they have in their accounts. There are a few interesting caveats that go with this business model, and this is where the Data Bank team need your help!

The management team at Data Bank want to increase their total customer base - but also need some help tracking just how much data storage their customers will need.

This case study is all about calculating metrics, growth and helping the business analyse their data in a smart way to better forecast and plan for their future developments!

---
## Entity Relationship Diagram

The Data Bank team have prepared a data model for this case study as well as a few example rows from the complete dataset below to get you familiar with their tables.

<p align="center">
<img src="https://github.com/Chisomnwa/SQL-Challenge-Case-Study-4---Data-Bank/blob/main/Images/ERD%20-%20%20Data%20Bank.png">

## 📂 Dataset
Danny has shared with you 3 key datasets for this case study:

### **```Regions```**
<details>
<summary>
View table
</summary>

The runners table contains the **```region_id```** and their respective **```region_name```** values


|region_id|region_name|
|---------|-----------|
|1        |Africa     |
|2        |America    |
|3        |Asia       |
|4        |Europe     |
|5        |Oceania    |

</details>


### **```Customer Nodes```**

<details>
<summary>
View table
</summary>

Below is a sample of the top 10 rows of the **```data_bank.customer_nodes```**

|customer_id|region_id|node_id|start_date  | end_date  |
|-----------|---------|-------|------------|-----------|
|1	        |3        |4	    |2020-01-02  |2020-01-03 |
|2	        |3        |5      |2020-01-03  |2020-01-17 |
|3          |5        |4      |2020-01-27  |2020-02-18 |
|4          |5        |4      |2020-01-07  |2020-01-19 |
|5          |3        |3      |2020-01-15  |2020-01-23 |
|6          |1        |1      |2020-01-11  |2020-02-06 |
|7          |2        |5      |2020-01-20  |2020-02-04 |
|8          |1        |2      |2020-01-15  |2020-01-28 |
|9          |4        |5      |2020-01-21  |2020-01-25 |
|10         |3        |4      |2020-01-13  |2020-01-14 |

</details>

### **```Customer Transactions```**
*This table stores all customer deposits, withdrawals and purchases made using their Data Bank debit card.*

<details>
<summary>
View table
</summary>

Below is a sample of the top 10 rows of the **```data_bank.customer_transactions```**

|customer_id|txn_date    |txn_type	|txn_amount |
|-----------|------------|----------|-----------|
|429	      |2020-01-21  |	deposit	|  82       |  
|155	      |2020-01-10  |	deposit	|  712      |
|398	      |2020-01-01  |	deposit	|  196      |    
|255	      |2020-01-14  |	deposit	|  563      |
|185	      |2020-01-29  |	deposit	|  626      |
|309	      |2020-01-13  |	deposit	|  995      |
|312	      |2020-01-20  |	deposit	|  485      |
|376	      |2020-01-03  |	deposit	|  706      |
|188	      |2020-01-13  |	deposit	|  601      |
|138	      |2020-01-11  |	deposit	|  520      |

</details>
---

## 🔍 Data Exploration

<details>
<summary> 
Customer Nodes Exploration
</summary>

### **Q1. How many unique nodes are there on the Data Bank system?**
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

|order_id| pizzas_count | avg_time |			relationship		    |
|--------|--------------|----------|------------------------------------------------|
|  1	 |	1	|   10.53  |	Takes more than 10 minutes to prepare	    |
|  2	 |	1	|   10.03  |	Takes more than 10 minutes to prepare	    |
|  3	 |	2	|   21.23  |	Preparation time is based on order quantity |
|  4	 |	3	|   29.28  |	Preparation time is based on order quantity |
|  5	 |	1	|   10.47  |	Takes more than 10 minutes to prepare	    |
|  7	 |	1	|   10.27  |	Takes more than 10 minutes to prepare	    |
|  8	 |	1	|   20.48  |	Takes more than 10 minutes to prepare	    |
|  10	 |	2	|   15.52  |	Preparation time is based on order quantity |

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
