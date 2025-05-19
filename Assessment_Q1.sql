/*ASSESSMENT QUESTION 1. HIGH-VALUE CUSTOMERS WITH MULTIPLE PRODUCTS

Scenario: The business wants to identify customers who have both a savings and an investment plan (cross-selling opportunity).

Task: Write a query to find customers with at least one funded savings plan AND one funded investment plan, sorted by total deposits.

Tables:
users_customuser
savings_savingsaccount
plans_plan*/

-- QUERY

USE adashi_staging;

SELECT * FROM savings_savingsaccount; -- savings_savingsaccount.owner_id, savings_savingsaccount.plan_id
SELECT * FROM plans_plan; -- plans_plan.id
SELECT * FROM users_customuser; -- users_customuser.id
-- --------------------------------------------------------------------------------------------------------------

SELECT
	users_customuser.id AS owner_id,
	CONCAT(first_name, " ", last_name) AS name,
	COUNT(CASE WHEN is_regular_savings = 1 THEN 1 END) AS savings_count,
	COUNT(CASE WHEN is_a_fund = 1 THEN 1 END) AS investment_count,
	ROUND(SUM(savings_savingsaccount.confirmed_amount), 2) AS total_deposits
FROM users_customuser
INNER JOIN savings_savingsaccount ON savings_savingsaccount.owner_id = users_customuser.id
INNER JOIN plans_plan ON plans_plan.id = savings_savingsaccount.plan_id
WHERE is_a_fund = 1 OR is_regular_savings = 1
GROUP BY owner_id, name
HAVING savings_count >=1 AND investment_count >=1
ORDER BY total_deposits DESC;	