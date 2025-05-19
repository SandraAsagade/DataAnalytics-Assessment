# DataAnalytics-Assessment

In this **README**, I'll explain my approach to the assessment questions

## ASSESSMENT QUESTION 1: High-Value Customers with Multiple Products
**Scenario:** The business wants to identify customers who have both a savings and an investment plan (cross-selling opportunity).

**Task:** Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.

**Tables:**
* users_customuser
* savings_savingsaccount
* plans_plan

**Approach:**
* The first step was understanding the question, because it sets the foundation.
* The next step was breaking down the task into bits
* Before breaking it down, I viewed all records from the needed tables, so I could understand their structure, and identifying the columns I needed based on the expected output
* After farmiliarizing myself with each table's structure, I proceeded to writing the query
* For this query, the focus was on customers who have both a savings and an investment plan. The hints given were very helpful in solving this one. From the hints, I knew that if a customer has a funded saving, the **is_regular_savings** column value is 1 and if they have a funded investment, the **is_a_fund** column value is also 1
* With this information in mind, the query was filtered to only return records based on the above.

**Challenges:**
* The tricky part of the task was to find customers with at least one funded savings plan AND one funded investment plan. Initially I I thought I had finished the query, no until I read the task again. Identifying customers who with both savings and investment plans was only the starting point. The key focus was on customers who had both their plans funded, Realizing this, I corrected the query, by filtering the results to show customers who have both their plans funded (HAVING savings_count >=1 AND investment_count >=1)

[View query](https://github.com/SandraAsagade/DataAnalytics-Assessment/blob/main/Assessment_Q1.sql)


## ASSESSMENT QUESTION 2: Transaction Frequency Analysis
**Scenario:** The finance team wants to analyze how often customers transact to segment them (e.g., frequent vs. occasional users).

**Task:** Calculate the average number of transactions per customer per month and categorize them:
* "High Frequency" (≥10 transactions/month)
* "Medium Frequency" (3-9 transactions/month)
* "Low Frequency" (≤2 transactions/month)

**Tables:**
* users_customuser
* savings_savingsaccount

**Approach:**
* In this task, I created a temporary table for the total transactions for each customer per month. I also took into consideration the year, so that the query does not only focuses on the month. For each year, we can know the average transaction per month.
* The reason for creating a temporary table was to simplify the query and avoid complexity.
* The records from the transaction frequency table were then grouped to get the frequency at which customers transact based on the given conditions

[View query](https://github.com/SandraAsagade/DataAnalytics-Assessment/blob/main/Assessment_Q2.sql)
