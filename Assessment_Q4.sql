/*ASSESSMENT QUESTION 4. CUSTOMER LIFETIME VALUE (CLV) ESTIMATION

Scenario: Marketing wants to estimate CLV based on account tenure and transaction volume (simplified model).

Task: For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate:
Account tenure (months since signup)
Total transactions
Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction)
Order by estimated CLV from highest to lowest

Tables:
users_customuser
savings_savingsaccount
*/

-- QUERY

SELECT * FROM users_customuser;
SELECT * FROM savings_savingsaccount;
-- ------------------------------------------------------------------------------

WITH clv AS( -- This creates a temporary table for the customer lifetime value of each customer (will be referenced to get the required output)
	SELECT
		users_customuser.id AS owner_id,
		CONCAT(first_name, " ", last_name) AS name,
		FLOOR(DATEDIFF(CURDATE(), users_customuser.created_on)/30.42) AS tenure_months,/* returns the whole numer value of the tenure of the
																customer in months. 30.42 is the average number of days per month*/
		COUNT(savings_savingsaccount.owner_id) AS total_transactions,
		SUM(confirmed_amount) AS transaction_value,
		(0.1 * SUM(confirmed_amount))/100 AS avg_profit_per_transaction
	FROM users_customuser
	INNER JOIN savings_savingsaccount ON savings_savingsaccount.owner_id = users_customuser.id
	GROUP BY owner_id, name
)
SELECT
	owner_id,
    name,
    tenure_months,
    total_transactions,
    ROUND((total_transactions/tenure_months) * 12 * avg_profit_per_transaction, 2) AS estimated_clv
FROM clv;