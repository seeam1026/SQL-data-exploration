# 🥑 Case Study #3 - Foodie-Fi
<p align="center">
<img src="https://github.com/seeam1026/SQL-data-exploration/blob/main/IMG/case%20study%203.png" width=40% height=40%>

## 📕 Table Of Contents
  - 🛠️ [Problem Statement](#problem-statement)
  - ♻️ [Entity Relationship Diagram](#entity-relationship-diagram)
  - 📂 [Dataset](#-dataset)
  - 🔍 [Data Exploration](#-data-exploration)

---

## 🛠Problem Statement

>Subscription based businesses are super popular and Danny realised that there was a large gap in the market - he wanted to create a new streaming service that only had food related content - something like Netflix but with only cooking shows!
>
>Danny finds a few smart friends to launch his new startup Foodie-Fi in 2020 and started selling monthly and annual subscriptions, giving their customers unlimited on-demand access to exclusive food videos from around the world!
>
>Danny created Foodie-Fi with a data driven mindset and wanted to ensure all future investment decisions and new features were decided using data. This case study focuses on using subscription style digital data to answer important business questions.

---

## ♻Entity Relationship Diagram

<p align="center">
<img src="https://github.com/seeam1026/SQL-data-exploration/blob/main/Case%20Study%20-%20Foodie-Fi/case-study-3-erd.png">
  
## 📂 Dataset

Danny has shared the data design for Foodie-Fi and also short descriptions on each of the database tables - this case study focuses on only 2 tables but there will be a challenge to create a new table for the Foodie-Fi team.

### **```plans```**
<details>
<summary>
View table
</summary>

Customers can choose which plans to join Foodie-Fi when they first sign up.

Basic plan customers have limited access and can only stream their videos and is only available monthly at $9.90

Pro plan customers have no watch time limits and are able to download videos for offline viewing. Pro plans start at $19.90 a month or $199 for an annual subscription.

Customers can sign up to an initial 7 day free trial will automatically continue with the pro monthly subscription plan unless they cancel, downgrade to basic or upgrade to an annual pro plan at any point during the trial.

When customers cancel their Foodie-Fi service - they will have a churn plan record with a null **```price```** but their plan will continue until the end of the billing period.

| plan_id | plan_name     | price  |
| ------- | ------------- | ------ |
| 0       | trial         | 0.00   |
| 1       | basic monthly | 9.90   |
| 2       | pro monthly   | 19.90  |
| 3       | pro annual    | 199.00 |
| 4       | churn         |        |

</details>

### **```subscriptions```**

<details>
<summary>
View table
</summary>
  
Customer subscriptions show the exact date where their specific **```plan_id```** starts.

If customers downgrade from a pro plan or cancel their subscription - the higher plan will remain in place until the period is over - the **```start_date```** in the **```subscriptions```** table will reflect the date that the actual plan changes.

When customers upgrade their account from a basic plan to a pro or annual pro plan - the higher plan will take effect straightaway.

When customers churn - they will keep their access until the end of their current billing period but the **```start_date```** will be technically the day they decided to cancel their service.

*Below is a sample of the top 10 rows of the **```foodie_fi.subscriptions```***

| customer_id | plan_id | start_date |
| ----------- | ------- | ---------- |
| 1           | 0       | 2020-08-01 |
| 1           | 1       | 2020-08-08 |
| 2           | 0       | 2020-09-20 |
| 2           | 3       | 2020-09-27 |
| 3           | 0       | 2020-01-13 |
| 3           | 1       | 2020-01-20 |
| 4           | 0       | 2020-01-17 |
| 4           | 1       | 2020-01-24 |
| 4           | 4       | 2020-04-21 |
| 5           | 0       | 2020-08-03 |

</details>

---

## 🔍 Data Exploration
<details>
<summary> 
Customer Journey
</summary>

### **Based off the 8 sample customers provided in the sample from the subscriptions table, write a brief description about each customer’s onboarding journey. Try to keep it as short as possible - you may also want to run some sort of join to make your explanations a bit easier!**

</details>

<details>
<summary> 
Data Analysis Questions
</summary>

### **Q1. How many customers has Foodie-Fi ever had?**
###
</details>

<details>
<summary> 
Challenge Payment Question
</summary>


</details>

<details>
  <summary>
    Outside The Box Questions
  </summary>
  
</details>
