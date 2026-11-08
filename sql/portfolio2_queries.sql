-- ForgePay: Portfolio 2 - Query Processing and Optimisation

-- Query 1: Retrieve customers and accounts with balances above NGN 100,000.
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    a.account_number,
    a.balance
FROM customers AS c
JOIN accounts AS a
    ON c.customer_id = a.customer_id
WHERE a.balance > 100000
ORDER BY a.balance DESC;

-- Query 2: Inspect the estimated execution plan.
EXPLAIN
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    a.account_number,
    a.balance
FROM customers AS c
JOIN accounts AS a
    ON c.customer_id = a.customer_id
WHERE a.balance > 100000;

-- Query 3: Measure execution and buffer activity.
EXPLAIN (ANALYZE, BUFFERS)
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    a.account_number,
    a.balance
FROM customers AS c
JOIN accounts AS a
    ON c.customer_id = a.customer_id
WHERE a.balance > 100000
ORDER BY a.balance DESC;
