# 🍕 Case Study #1 - Danny's Diner
<p align="center">
<img src="https://github.com/seeam1026/SQL-data-exploration/blob/main/IMG/1.png" width=40% height=40%>

## 📕 Table Of Contents
  - 🛠️ [Problem Statement](#problem-statement)
  - 📂 [Dataset](#-dataset)
  - ♻️ [Data Cleaning](#data-cleaning)
  - 🔍 [Data Exploration](#-data-exploration)

---

## 🛠Problem Statement

>Danny wants to use the data to answer a few simple questions about his customers, especially about their visiting patterns, how much money they’ve spent and also which menu items are their favourite. Having this deeper connection with his customers will help him deliver a better and more personalised experience for his loyal customers.
>
>He plans on using these insights to help him decide whether he should expand the existing customer loyalty program - additionally he needs help to generate some basic datasets so his team can easily inspect the data without needing to use SQL.

---

## 📂 Dataset
<p align="center">
<img src="https://github.com/seeam1026/SQL-data-exploration/blob/main/Case%20study%20-%20Danny's%20Diner/Danny's%20Diner%20-%20erd.png">

Danny has shared with you 3 key datasets for this case study:

### **```sales```**
<details>
<summary>
View table
</summary>

The sales table captures all **```customer_id```** level purchases with an corresponding **```order_date```** and **```product_id```** information for when and what menu items were ordered.

| customer_id | order_date | product_id |
| ----------- | ---------- | ---------- |
| A           | 2021-01-01 | 1          |
| A           | 2021-01-01 | 2          |
| A           | 2021-01-07 | 2          |
| A           | 2021-01-10 | 3          |
| A           | 2021-01-11 | 3          |
| A           | 2021-01-11 | 3          |
| B           | 2021-01-01 | 2          |
| B           | 2021-01-02 | 2          |
| B           | 2021-01-04 | 1          |
| B           | 2021-01-11 | 1          |
| B           | 2021-01-16 | 3          |
| B           | 2021-02-01 | 3          |
| C           | 2021-01-01 | 3          |
| C           | 2021-01-01 | 3          |
| C           | 2021-01-07 | 3          |

</details>


### **```menu```**

<details>
<summary>
View table
</summary>

The menu table maps the **```product_id```** to the actual **```product_name```** and **```price```** of each menu item.

| product_id | product_name | price |
| ---------- | ------------ | ----- |
| 1          | sushi        | 10    |
| 2          | curry        | 15    |
| 3          | ramen        | 12    |

</details>

### **```members```**

<details>
<summary>
View table
</summary>

The final members table captures the **```join_date```** when a **```customer_id```** joined the beta version of the Danny’s Diner loyalty program.


| customer_id | join_date  |
| ----------- | ---------- |
| A           | 2021-01-07 |
| B           | 2021-01-09 |

</details>

## ♻Data Cleaning
<details>
<summary>
Create table
</summary>

** **	
 ```sql
CREATE SCHEMA dannys_diner;
SET search_path = dannys_diner;

CREATE TABLE sales (
  "customer_id" VARCHAR(1),
  "order_date" DATE,
  "product_id" INTEGER
);

INSERT INTO sales
  ("customer_id", "order_date", "product_id")
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
 

CREATE TABLE menu (
  "product_id" INTEGER,
  "product_name" VARCHAR(5),
  "price" INTEGER
);

INSERT INTO menu
  ("product_id", "product_name", "price")
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  

CREATE TABLE members (
  "customer_id" VARCHAR(1),
  "join_date" DATE
);

INSERT INTO members
  ("customer_id", "join_date")
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');
```		
</details>

<details>
<summary>
Cleaning Data
</summary>

## 🔍 Data Exploration

<details>
	
### ** Q1. What is the total amount each customer spent at the restaurant? **
```SQL
```
>Output

### ** Q2. How many days has each customer visited the restaurant?**
What was the first item from the menu purchased by each customer?
What is the most purchased item on the menu and how many times was it purchased by all customers?
Which item was the most popular for each customer?
Which item was purchased first by the customer after they became a member?
Which item was purchased just before the customer became a member?
What is the total items and amount spent for each member before they became a member?
If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
</details>
