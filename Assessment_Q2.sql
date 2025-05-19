/*ASSESSMENT QUESTION 2. TRANSACTION FREQUENCY ANALYSIS

Scenario: The finance team wants to analyze how often customers transact to segment them (e.g., frequent vs. occasional users).

Task: Calculate the average number of transactions per customer per month and categorize them:
"High Frequency" (≥10 transactions/month)
"Medium Frequency" (3-9 transactions/month)
"Low Frequency" (≤2 transactions/month)

Tables:
users_customuser
savings_savingsaccount
*/

-- QUERY

USE adashi_staging;

SELECT * FROM users_customuser; -- users_customuser.id
SELECT * FROM savings_savingsaccount; -- savings_savingsaccount.owner_id
-- ------------------------------------------------------------------------

WITH transaction_frequency AS ( -- This creates a temporary table for the total transaction by customers (will be referenced to get the required output)
	SELECT 
		users_customuser.id AS owner_id,
		MONTHNAME(transaction_date) AS month,
		YEAR(transaction_date) AS year,
		COUNT(transaction_date) AS transaction_count
	FROM users_customuser
	INNER JOIN savings_savingsaccount ON savings_savingsaccount.owner_id = users_customuser.id
	GROUP BY owner_id, month, year
)
SELECT -- Querying the temportary table (transaction_frequency) to get the required output
	CASE WHEN transaction_count <= 2 THEN "Low Frequency"
		WHEN transaction_count BETWEEN 3 AND 9 THEN "Medium Frequency"
        ELSE "High Frequency" END AS frequency_category, -- This creates a column for frequency_category based on the given conditions
	COUNT(DISTINCT owner_id) AS customer_count,
    ROUND(AVG(transaction_count), 1) AS avg_transactions_per_month
FROM transaction_frequency
GROUP BY frequency_category;