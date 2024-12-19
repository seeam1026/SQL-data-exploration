# 💰 Case Study #4 💰 Data Bank
<p align="center">
<img src="https://github.com/seeam1026/SQL-data-exploration/blob/main/IMG/Data%20Bank%20png.png" width=40% height=40%>

## 📕 Table Of Contents
  - 🛠️ [Problem Statement](#problem-statement)
  - ♻️[Entity Relationship Diagram](#entity-relationship-diagram)
  - 📂 [Dataset](#-dataset)
  - 🔍 [Data Exploration](#-data-exploration)

---

## 🛠Problem Statement

There is a new innovation in the financial industry called Neo-Banks: new aged digital only banks without physical branches.

Danny thought that there should be some sort of intersection between these new age banks, cryptocurrency and the data world…so he decides to launch a new initiative - Data Bank!

Data Bank runs just like any other digital bank - but it isn’t only for banking activities, they also have the world’s most secure distributed data storage platform!

Customers are allocated cloud data storage limits which are directly linked to how much money they have in their accounts. There are a few interesting caveats that go with this business model, and this is where the Data Bank team need your help!

The management team at Data Bank want to increase their total customer base - but also need some help tracking just how much data storage their customers will need.

This case study is all about calculating metrics, growth and helping the business analyse their data in a smart way to better forecast and plan for their future developments!

---
## ♻Entity Relationship Diagram

The Data Bank team have prepared a data model for this case study as well as a few example rows from the complete dataset below to get you familiar with their tables.

<p align="center">
<img src="https://github.com/seeam1026/SQL-data-exploration/blob/main/Case%20study%20-%20Data%20Bank/Data%20Bank.png">

---
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

|customer_id|txn_date    |txn_type|txn_amount |
|-----------|------------|--------|-----------|
|429	    |2020-01-21  |deposit |  82       |  
|155	    |2020-01-10  |deposit |  712      |
|398	    |2020-01-01  |deposit |  196      |    
|255	    |2020-01-14  |deposit |  563      |
|185	    |2020-01-29  |deposit |  626      |
|309	    |2020-01-13  |deposit |  995      |
|312	    |2020-01-20  |deposit |  485      |
|376	    |2020-01-03  |deposit |  706      |
|188	    |2020-01-13  |deposit |  601      |
|138	    |2020-01-11  |deposit |  520      |

</details>

---
## 🔍 Data Exploration

<details>
<summary> 
Customer Nodes Exploration
</summary>

### **Q1. How many unique nodes are there on the Data Bank system?**
```sql
SELECT COUNT(DISTINCT node_id) AS unique_nodes
FROM data_bank.customer_nodes;
```
|unique_nodes|
|------------|
|5	     |

### **Q2. What is the number of nodes per region?**
```sql
SELECT regions.region_name, COUNT(customer_nodes.node_id) AS nodes
    FROM data_bank.customer_nodes
    JOIN data_bank.regions
    ON customer_nodes.region_id = regions.region_id
    GROUP BY regions.region_name
    ORDER BY nodes DESC;
```

| region_name | nodes |
| ----------- | ----- |
| Australia   | 770   |
| America     | 735   |
| Africa      | 714   |
| Asia        | 665   |
| Europe      | 616   |

### **Q3. How many customers are allocated to each region?**
```sql
    SELECT regions.region_name, COUNT(DISTINCT customer_nodes.customer_id) AS num_of_customer
    FROM data_bank.customer_nodes
    JOIN data_bank.regions
    ON regions.region_id = customer_nodes.region_id
    GROUP BY regions.region_name
    ORDER BY num_of_customer DESC;
```

| region_name | num_of_customer |
| ----------- | --------------- |
| Australia   | 110             |
| America     | 105             |
| Africa      | 102             |
| Asia        | 95              |
| Europe      | 88              |

### **Q4. How many days on average are customers reallocated to a different node?**
```SQL
    WITH CTE AS (
      SELECT customer_id, node_id, start_date, end_date, LEAD(node_id) OVER(PARTITION BY customer_id ORDER BY start_date) AS next_node_id, LEAD(start_date) OVER(PARTITION BY customer_id ORDER BY start_date) AS next_start_date
      FROM data_bank.customer_nodes)
    
    SELECT 
    ROUND(AVG(CASE WHEN node_id <> next_node_id THEN (next_start_date - start_date) END), 2) AS avg_days_reallocated
    FROM CTE
    WHERE next_node_id IS NOT NULL;
```
| avg_days_reallocated |
| -------------------- |
| 15.63                |


### **Q5. What is the median, 80th and 95th percentile for this same reallocation days metric for each region?**
```SQL
```


</details>

<details>
<summary>
Customer Transactions
</summary>

### **Q1. What is the unique count and total amount for each transaction type?**
```SQL
    SELECT txn_type, COUNT(*) AS total_count, SUM(txn_amount) AS total_amount
    FROM data_bank.customer_transactions
    GROUP BY txn_type
    ORDER BY total_amount;
```
| txn_type   | total_count | total_amount |
| ---------- | ----------- | ------------ |
| withdrawal | 1580        | 793003       |
| purchase   | 1617        | 806537       |
| deposit    | 2671        | 1359168      |

### **Q2. What is the average total historical deposit counts and amounts for all customers?**
```SQL


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
