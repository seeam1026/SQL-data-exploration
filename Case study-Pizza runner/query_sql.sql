/* --------------------
   Case Study Questions:
   Pizza Metrics
   --------------------*/

-- How many pizzas were ordered?
SELECT COUNT(pizza_id) as pizza_count
FROM customer_orders;
   
-- How many unique customer orders were made?
SELECT COUNT(DISTINCT order_id) AS order_count
FROM customer_orders;

-- How many successful orders were delivered by each runner?
 SELECT runner_id,
	COUNT(order_id) AS successful_orders
 FROM runner_orders
 WHERE cancellation is NULL
 GROUP BY runner_id;

--How many of each type of pizza was delivered?
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
ON cte.pizza_id = pizza_names.pizza_id;

-- How many Vegetarian and Meatlovers were ordered by each customer?
SELECT 	customer_id, 
	SUM(CASE WHEN pizza_id = 1 THEN 1 ELSE 0 END) AS meat_lovers,
	SUM(CASE WHEN pizza_id = 2 THEN 1 ELSE 0 END) AS vegetarian
FROM customer_orders
GROUP BY customer_id;

-- What was the maximum number of pizzas delivered in a single order?
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

--For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
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

-- How many pizzas were delivered that had both exclusions and extras?
SELECT
  SUM(CASE WHEN co.exclusions IS NOT NULL AND co.extras IS NOT NULL THEN 1 ELSE 0 END) AS pizza_count
FROM runner_orders AS ru
JOIN customer_orders AS co
  ON co.order_id = ru.order_id
WHERE ru.cancellation IS NULL;

-- What was the total volume of pizzas ordered for each hour of the day?
SELECT
  DATE_PART('hour', order_time) AS hour_of_day,
  COUNT(pizza_id) as pizza_count
FROM customer_orders
GROUP BY hour_of_day
ORDER BY hour_of_day;

-- What was the volume of orders for each day of the week?
SELECT
  TO_CHAR(order_time,'day') AS day_of_week,
  COUNT(pizza_id) AS pizza_count
FROM customer_orders
GROUP BY day_of_week, DATE_PART('dow', order_time)
ORDER BY DATE_PART('dow', order_time);

/* --------------------
   Case Study Questions:
   Runner and Customer Experience
   --------------------*/

-- How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)


-- What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
SELECT
  ru.runner_id,
  DATE_PART('minute', AVG(ru.pickup_time::timestamp - co.order_time)) AS avg_arrival_minutes
FROM runner_orders AS ru
JOIN customer_orders AS co 
 ON co.order_id = ru.order_id
WHERE ru.cancellation IS NULL
GROUP BY ru.runner_id;

-- Is there any relationship between the number of pizzas and how long the order takes to prepare?
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

-- What was the average distance travelled for each customer?
SELECT  runner_id,
	ROUND(AVG(distance::DECIMAL), 2) AS avg_distance
FROM runner_orders
GROUP BY runner_id
ORDER BY runner_id;

-- What was the difference between the longest and shortest delivery times for all orders?
SELECT MAX(duration::INT) - MIN(duration::INT) AS difference
FROM runner_orders;

-- What was the average speed for each runner for each delivery and do you notice any trend for these values?
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

/*Finding:
Orders shown in decreasing order of average speed:
While the fastest order only carried 1 pizza and the slowest order carried 3 pizzas,
there is no clear trend that more pizzas slow down the delivery speed of an order.  
*/

-- What is the successful delivery percentage for each runner?
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


