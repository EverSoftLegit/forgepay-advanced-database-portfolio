-- ForgePay: Portfolio 3 - Transactions and Concurrency
-- PostgreSQL 15
-- Demonstrates transaction control, isolation and row-level locking.

-- 1. Create a dedicated table for transaction demonstrations.
CREATE TABLE IF NOT EXISTS transaction_lab (
    demo_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    description VARCHAR(100) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 2. Demonstrate ROLLBACK.
BEGIN;

INSERT INTO transaction_lab (description)
VALUES ('Rollback demonstration');

SELECT * FROM transaction_lab;

ROLLBACK;

-- Verify that the uncommitted insert was undone.
SELECT * FROM transaction_lab;

-- 3. Demonstrate COMMIT.
BEGIN;

INSERT INTO transaction_lab (description)
VALUES ('Commit demonstration');

COMMIT;

-- Verify that the committed insert persists.
SELECT * FROM transaction_lab;

-- 4. Inspect the default transaction isolation level.
SHOW transaction_isolation;

-- 5. Demonstrate READ COMMITTED.
-- Execute the following in Session A:
BEGIN ISOLATION LEVEL READ COMMITTED;
SELECT * FROM transaction_lab;

-- In Session B, insert and commit a new record:
-- BEGIN;
-- INSERT INTO transaction_lab (description)
-- VALUES ('Concurrent session demonstration');
-- COMMIT;

-- Back in Session A, run the query again.
-- A new committed record should now be visible.
SELECT * FROM transaction_lab;
COMMIT;

-- 6. Demonstrate REPEATABLE READ.
-- Execute in Session A:
BEGIN ISOLATION LEVEL REPEATABLE READ;
SELECT * FROM transaction_lab;

-- In Session B, insert and commit another record:
-- BEGIN;
-- INSERT INTO transaction_lab (description)
-- VALUES ('Repeatable read test');
-- COMMIT;

-- Back in Session A, repeat the SELECT.
-- The newly committed record should not be visible
-- within the existing REPEATABLE READ transaction.
SELECT * FROM transaction_lab;

-- End the transaction and obtain a fresh snapshot.
COMMIT;

SELECT * FROM transaction_lab;

-- 7. Demonstrate row-level locking.
-- Execute in Session A:
BEGIN;

SELECT account_id, account_number, balance
FROM accounts
WHERE account_id = 1
FOR UPDATE;

-- In Session B, execute the same SELECT ... FOR UPDATE.
-- Session B waits until Session A releases its lock.

-- In Session A:
COMMIT;

-- Session B's waiting query should now complete.
-- Commit Session B after the query completes.

-- Verify that the account balance was not modified.
SELECT account_id, account_number, balance
FROM accounts
WHERE account_id = 1;
