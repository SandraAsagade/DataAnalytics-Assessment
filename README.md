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

## ASSESSMENT QUESTION 3: Account Inactivity Alert
**Scenario:** The ops team wants to flag accounts with no inflow transactions for over one year.

**Task:** Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days) .

**Tables:**
* plans_plan
* savings_savingsaccount

**Approach:**
* Just like all other queries, understanding the task at hand is key.
* For this task, I created a conditional column ***type*** in the query using CASE WHEN to get the type of inflow transaction (savings or investments)
* In other to get the number of days inactive, I had to first find their last transaction date using the MAX function.
* The next was to deduct the last transaction date from the current date and get the result in days
* After doing the above, the next step was filtering the query to only return records where the number of days inactive is over one year (the task says to focus on accounts with no transactions in the last one year. If the last one year is 365 days, it means that any account transaction above 365 days, means the account has been inactive for over a year)

**Challenges:**
* I think the main challenge I had was getting the inactivity days. This was where ChatGPT came to the rescue. I knew that to get it, I had to use the DATEDIFF function, but I wasn't sure how to in MySQL, as I am more farmiliar with MSSQL.

[View query](https://github.com/SandraAsagade/DataAnalytics-Assessment/blob/main/Assessment_Q3.sql)

## ASSESSMENT QUESTION 4. CUSTOMER LIFETIME VALUE (CLV) ESTIMATION

**Scenario:** Marketing wants to estimate CLV based on account tenure and transaction volume (simplified model).

**Task:** For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:

* Account tenure (months since signup)
* Total transactions
* Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
Order by estimated CLV from highest to lowest

**Tables:**
* users_customuser
* savings_savingsaccount

**Approach:**
* Understanding what CLV meant was important for this task, and the instructions give were very helpful. In fact, by follwoing the instructions, I was able to efficiently and painlessly write the query.
* First of all, I created a temporary table in the query to show the main fields that'll be needed to get the expected result.
* After getting the tenure in days from when the customer signed up, to the current date, the result was then divided by the average number of days per month (30.42), so as to get the tenure in months.
* Because I understood what CLV meant, it was easy for me to identify the amount column to be used (confirmed_amount - which focuses on inflow), and
* Lastly, I queried the temporary table for the expected customer lifetime value, grouping the result by the customers.

[View query](https://github.com/SandraAsagade/DataAnalytics-Assessment/blob/main/Assessment_Q4.sql)
