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
|1	    |3        |4      |2020-01-02  |2020-01-03 |
|2	    |3        |5      |2020-01-03  |2020-01-17 |
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
>Output

|unique_nodes|
|------------|
|5	     |

*There are 5 unique nodes in the Data Bank system.*

### **Q2. What is the number of nodes per region?**
```sql
SELECT regions.region_name, COUNT(customer_nodes.node_id) AS nodes
    FROM data_bank.customer_nodes
    JOIN data_bank.regions
    ON customer_nodes.region_id = regions.region_id
    GROUP BY regions.region_name
    ORDER BY nodes DESC;
```
>Output

| region_name | nodes |
| ----------- | ----- |
| Australia   | 770   |
| America     | 735   |
| Africa      | 714   |
| Asia        | 665   |
| Europe      | 616   |

*Australia has the highest number of nodes (770), while Europe has the lowest (616), highlighting a significant disparity in node distribution across regions.*

### **Q3. How many customers are allocated to each region?**
```sql
    SELECT regions.region_name, COUNT(DISTINCT customer_nodes.customer_id) AS num_of_customer
    FROM data_bank.customer_nodes
    JOIN data_bank.regions
    ON regions.region_id = customer_nodes.region_id
    GROUP BY regions.region_name
    ORDER BY num_of_customer DESC;
```
>Output

| region_name | num_of_customer |
| ----------- | --------------- |
| Australia   | 110             |
| America     | 105             |
| Africa      | 102             |
| Asia        | 95              |
| Europe      | 88              |

*Australia has the highest number of customers allocated (110), while Europe has the lowest (88)*

### **Q4. How many days on average are customers reallocated to a different node?**
```SQL
    WITH CTE AS (
      SELECT customer_id, node_id, start_date, end_date,
      	LEAD(node_id) OVER(PARTITION BY customer_id ORDER BY start_date) AS next_node_id, 
      	LEAD(start_date) OVER(PARTITION BY customer_id ORDER BY start_date) AS next_start_date
      FROM data_bank.customer_nodes)
    
    SELECT 
    ROUND(AVG(CASE WHEN node_id <> next_node_id THEN (next_start_date - start_date) END), 2) AS avg_days_reallocated
    FROM CTE
    WHERE next_node_id IS NOT NULL;
```
>Output

| avg_days_reallocated |
| -------------------- |
| 15.63                |

*On average approximately 15.63 days, customers are reallocated to a different node*

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

>Output

| txn_type   | total_count | total_amount |
| ---------- | ----------- | ------------ |
| withdrawal | 1580        | 793003       |
| purchase   | 1617        | 806537       |
| deposit    | 2671        | 1359168      |

*The query reveals that deposit transactions have the highest total count (2671) and total amount (1,359,168), followed by purchase and withdrawal transactions, indicating that deposit transactions constitute the majority of customer activities.*

### **Q2. What is the average total historical deposit counts and amounts for all customers?**
```SQL
    SELECT ROUND(AVG(deposit_count), 2) AS avg_deposit_count,
    ROUND(AVG(sum_amount), 2) AS avg_amount
    FROM (
      SELECT customer_id, COUNT(txn_type) AS deposit_count, SUM(txn_amount) AS sum_amount
      FROM data_bank.customer_transactions
      WHERE txn_type = 'deposit'
      GROUP BY customer_id) AS cte_customer_avg_amount;
```
>Output

| avg_deposit_count | avg_amount |
| ----------------- | ---------- |
| 5.34              | 2718.34    |

*The query shows that, on average, customers have made approximately 5.34 deposits, with an average total amount of 2,718.34 per customer.*
### **Q3. For each month - how many Data Bank customers make more than 1 deposit and either 1 purchase or 1 withdrawal in a single month?**
```SQL
    WITH activity_count AS (
    SELECT 
      customer_id, 
      DATE_PART('month', txn_date) AS txn_month, 
      TO_CHAR(txn_date, 'month') AS month_name, 
      SUM(CASE WHEN txn_type = 'deposit' THEN 1 ELSE 0 END) AS total_deposit_monthly, 
      SUM(CASE WHEN txn_type = 'withdrawal' THEN 1 ELSE 0 END) AS total_withdrawal_monthly, 
      SUM(CASE WHEN txn_type = 'purchase' THEN 1 ELSE 0 END) AS total_purchase_monthly
    FROM data_bank.customer_transactions
    GROUP BY customer_id, txn_month, month_name)
    
    SELECT month_name, COUNT(customer_id) AS customer_count
    FROM activity_count
    WHERE total_deposit_monthly > 1 AND (total_withdrawal_monthly >= 1 OR total_purchase_monthly >= 1)
    GROUP BY txn_month, month_name
    ORDER BY txn_month;
```
>Output

| month_name | customer_count |
| ---------- | -------------- |
| january    | 168            |
| february   | 181            |
| march      | 192            |
| april      | 70             |

*The query shows the number of customers making more than 1 deposit along with either 1 withdrawal or 1 purchase varies. There is a noticeable decline in the customer count from March to April, suggesting a decrease in such activity.*
### **Q4. What is the closing balance for each customer at the end of the month?**
**Step**

* CTE_balance:
Selects customer_id, txn_month, and calculates balance_amount based on transaction type.
Deposits increase the balance, while withdrawals and purchases decrease it.
Groups by customer_id and txn_month.

* SELECT:
Calculates the cumulative ending_balance for each customer by summing balance_amount across all previous months, partitioned by customer_id.
Uses the window function SUM(balance_amount) OVER(PARTITION BY customer_id ORDER BY txn_month) to achieve this.

```SQL
    WITH CTE_balance AS (
    SELECT 
      customer_id, 
      EXTRACT(MONTH FROM txn_date) AS txn_month,
      SUM(CASE WHEN txn_type = 'deposit' THEN txn_amount
          WHEN txn_type IN ('withdrawal', 'purchase') THEN -txn_amount 
          ELSE 0 END) AS balance_amount
    FROM data_bank.customer_transactions
    GROUP BY customer_id, txn_month)
    
    SELECT 
      customer_id,
      txn_month,
      SUM(balance_amount) OVER(PARTITION BY customer_id ORDER BY txn_month) AS ending_balance
    FROM CTE_balance;
```
>Output

* Not all output is displayed, considering the number of results that will take up space
  
| customer_id | txn_month | ending_balance |
| ----------- | --------- | -------------- |
| 1           | 1         | 312            |
| 1           | 3         | -640           |
| 2           | 1         | 549            |
| 2           | 3         | 610            |
| 3           | 1         | 144            |
| 3           | 2         | -821           |
| 3           | 3         | -1222          |
| 3           | 4         | -729           |
| 4           | 1         | 848            |
| 4           | 3         | 655            |

### **Q5. What is the percentage of customers who increase their closing balance by more than 5%?**
**Step**

* The goal is to calculate the percentage of customers whose closing balance increases by more than 5% between consecutive months.

* Use generate_series to create a continuous list of monthly dates for each customer. This ensures we have a row for every month, even if there are no transactions in that month.

* For each monthly date, calculate the closing_balance using deposits and withdrawals/purchases.

* Compute cumulative balances using the SUM window function. This represents the balance from the start of all previous months.

* Use the LEAD function to get the next month's balance for comparison

* Calculate the percentage increase between the current month’s balance and the next month’s balance.

* Finally, calculate the percentage of customers with a balance increase of more than 5%.

```SQL
    WITH all_month AS (
      SELECT customer_id, 
      	generate_series(DATE_TRUNC('month', MIN(txn_date)), DATE_TRUNC('month', MAX(txn_date)), '1 month')::DATE AS txn_month
      FROM data_bank.customer_transactions
      GROUP BY customer_id),
    
    CTE_monthly_balance AS (
      SELECT all_month.customer_id, all_month.txn_month,
      	COALESCE (SUM(CASE WHEN c.txn_type = 'deposit' THEN c.txn_amount 
                      WHEN c.txn_type IN('withdrawal', 'purchase') THEN -c.txn_amount
                      ELSE 0 END), 0) AS closing_balance
      FROM data_bank.customer_transactions c
      RIGHT JOIN all_month
      ON all_month.txn_month = DATE_TRUNC('month', c.txn_date) AND all_month.customer_id = c.customer_id
      GROUP BY all_month.customer_id, all_month.txn_month),
    
    closing_balance AS (
      SELECT 
      	customer_id, 
      	txn_month, 
      	SUM(closing_balance) OVER(PARTITION BY customer_id ORDER BY txn_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ending_balance
      FROM CTE_monthly_balance),
    
    balance_with_lead AS (
      SELECT 
      	customer_id, 
      	txn_month, 
      	ending_balance, 
      	LEAD(ending_balance) OVER(PARTITION BY customer_id ORDER BY txn_month) AS next_month_balance
      FROM closing_balance),
    
    filter_customer AS (
      SELECT customer_id, (next_month_balance - ending_balance)/NULLIF(ending_balance, 0) AS pct_increase_5
      FROM balance_with_lead
      WHERE (next_month_balance - ending_balance)/NULLIF(ending_balance, 0) > 0.05
      GROUP BY customer_id, next_month_balance, ending_balance)
    
    SELECT ROUND(100.0*COUNT(DISTINCT customer_id)/
      (SELECT COUNT(DISTINCT customer_id) 
      FROM data_bank.customer_transactions), 2) AS pct_customers
    FROM filter_customer;
```

| pct_customers |
| ------------- |
| 75.80         |

</details>

<details>
	<summary>
		Data Allocation Challenge
	</summary>
	
### To test out a few different hypotheses - the Data Bank team wants to run an experiment where different groups of customers would be allocated data using 3 different options:

**Option 1:** data is allocated based off the amount of money at the end of the previous month

**Option 2:** data is allocated on the average amount of money kept in the account in the previous 30 days

**Option 3:** data is updated real-time

*For this multi-part challenge question - you have been requested to generate the following data elements to help the Data Bank team estimate how much data will need to be provisioned for each option:*

>**OPTION 1**
```SQL
    WITH cte_running_balance AS (SELECT customer_id, EXTRACT(MONTH FROM txn_date) AS txn_month, SUM(CASE WHEN txn_type = 'deposit' THEN txn_amount
    WHEN txn_type IN ('withdrawal', 'purchase') THEN -txn_amount ELSE 0 END) AS running_balance_monthly
    FROM data_bank.customer_transactions
    GROUP BY customer_id, txn_month
    ORDER BY customer_id),
    end_balance_monthly AS (SELECT customer_id, txn_month, running_balance_monthly, SUM(running_balance_monthly) OVER(PARTITION BY customer_id ORDER BY txn_month) AS end_running_balance
    FROM cte_running_balance)
    
    SELECT txn_month, SUM(end_running_balance) AS total_end_running_balance_month
    FROM end_balance_monthly
    GROUP BY txn_month
    ORDER BY txn_month;
```
>Output
*Insight:*
| txn_month | total_end_running_balance_month |
| --------- | ------------------------------- |
| 1         | 126091                          |
| 2         | -34350                          |
| 3         | -194916                         |
| 4         | -180855                         |

>**OPTION 2**
```SQL
    WITH running_balance AS (SELECT customer_id, txn_date, txn_amount, EXTRACT(MONTH FROM txn_date) AS txn_month,
    CASE WHEN txn_type = 'deposit' THEN txn_amount
    WHEN txn_type IN ('withdrawal', 'purchase') THEN -txn_amount ELSE 0 END AS running_balance
    FROM data_bank.customer_transactions
    ORDER BY customer_id, txn_date),
    
    month_balance AS (
      SELECT customer_id, txn_date, txn_month, txn_amount, running_balance, SUM(running_balance) OVER(PARTITION BY customer_id ORDER BY txn_date) AS end_running_balance
    FROM running_balance),
    
    avg_rolling_balance AS (SELECT customer_id, txn_date, txn_month, txn_amount, running_balance, end_running_balance,
    ROUND(AVG(end_running_balance) OVER(PARTITION BY customer_id ORDER BY txn_date RANGE BETWEEN INTERVAL '30 DAYS' PRECEDING AND CURRENT ROW)) AS avg_rolling_30days_running_balance
    FROM month_balance)
    
    SELECT txn_month, SUM(avg_rolling_30days_running_balance) AS total_avg_rolling_balance
    FROM avg_rolling_balance
    GROUP BY txn_month
    ORDER BY txn_month;
```
>Output
*Insight:*

| txn_month | total_avg_rolling_balance |
| --------- | ------------------------- |
| 1         | 548719                    |
| 2         | 311818                    |
| 3         | -564995                   |
| 4         | -361023                   |


>**OPTION 3**
```SQL
    WITH running_balances AS (SELECT customer_id, txn_date, txn_type, txn_amount, EXTRACT(MONTH FROM txn_date) AS txn_month,
    CASE WHEN txn_type = 'deposit' THEN txn_amount
    WHEN txn_type IN ('withdrawal', 'purchase') THEN -txn_amount ELSE 0 END AS running_balance
    FROM data_bank.customer_transactions),
    
    running_balance_within_month AS (SELECT customer_id, txn_date, txn_month, SUM(running_balance) OVER(PARTITION BY customer_id, txn_month ORDER BY txn_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS transaction_running_balance
    FROM running_balances)
    
    SELECT txn_month, SUM(transaction_running_balance) AS total_running_balance
    FROM running_balance_within_month
    GROUP BY txn_month
    ORDER BY txn_month;
```
>Output
*Insight*

| txn_month | total_running_balance |
| --------- | --------------------- |
| 1         | 392122                |
| 2         | -382800               |
| 3         | -498557               |
| 4         | -115770               |
</details>
