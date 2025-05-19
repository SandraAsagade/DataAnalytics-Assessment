/*ASSESSMENT QUESTION 3. ACCOUNT INACTIVITY ALERT

Scenario: The ops team wants to flag accounts with no inflow transactions for over one year.

Task: Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days) .

Tables:
plans_plan
savings_savingsaccount
*/

-- QUERY

SELECT * FROM plans_plan; -- plans_plan.id
SELECT * FROM savings_savingsaccount; -- savings_savingsaccount.plan_id
-- ---------------------------------------------------------------------------

SELECT
	savings_savingsaccount.plan_id,
    savings_savingsaccount.owner_id,
    CASE WHEN plans_plan.is_a_fund = 1 THEN "Investment"
		WHEN plans_plan.is_regular_savings = 1 THEN "Savings"
	END AS type,
    DATE(MAX(transaction_date)) AS last_transaction_date, -- This returns the last/latest transaction date of the customer
    DATEDIFF(CURDATE(), MAX(transaction_date)) AS inactivity_days -- This returns the number of days from customer's last transaction date till current date
FROM plans_plan
INNER JOIN savings_savingsaccount ON savings_savingsaccount.plan_id = plans_plan.id
GROUP BY plan_id, owner_id, type
HAVING inactivity_days > 365 AND type IS NOT NULL
ORDER BY inactivity_days DESC;