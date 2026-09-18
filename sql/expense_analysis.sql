-- Expense Tracking & Spending Analysis

-- 1. Overall Spending KPIs
SELECT
    SUM(amount) AS total_spent,
    COUNT(*) AS total_transactions,
    AVG(amount) AS average_expense,
    MIN(amount) AS minimum_expense,
    MAX(amount) AS maximum_expense
FROM expenses;


-- 2. Spending by Category
SELECT
    category,
    SUM(amount) AS total_spent
FROM expenses
GROUP BY category
ORDER BY total_spent DESC;


-- 3. Necessary vs Unnecessary Spending
SELECT
    necessary,
    SUM(amount) AS total_spent
FROM expenses
GROUP BY necessary;


-- 4. Daily Spending
SELECT
    expense_date,
    SUM(amount) AS daily_spending
FROM expenses
GROUP BY expense_date
ORDER BY expense_date;


-- 5. Payment Method Analysis
SELECT
    payment_method,
    SUM(amount) AS total_spent,
    COUNT(*) AS transactions
FROM expenses
GROUP BY payment_method
ORDER BY total_spent DESC;


-- 6. Location-wise Spending
SELECT
    location,
    SUM(amount) AS total_spent,
    COUNT(*) AS transactions
FROM expenses
GROUP BY location
ORDER BY total_spent DESC;


-- 7. Budget vs Actual Spending
SELECT
    m.category,
    m.planned_amount AS budget,
    COALESCE(SUM(e.amount), 0) AS actual_spending,
    m.planned_amount - COALESCE(SUM(e.amount), 0) AS remaining_budget
FROM monthly_budget m
LEFT JOIN expenses e
    ON m.category = e.category
GROUP BY m.category, m.planned_amount
ORDER BY remaining_budget;


-- 8. Overspending Categories
SELECT
    m.category,
    m.planned_amount AS budget,
    SUM(e.amount) AS actual_spending
FROM monthly_budget m
JOIN expenses e
    ON m.category = e.category
GROUP BY m.category, m.planned_amount
HAVING SUM(e.amount) > m.planned_amount;


-- 9. Top 5 Expenses
SELECT
    expense_id,
    expense_date,
    category,
    description,
    amount
FROM expenses
ORDER BY amount DESC
LIMIT 5;
