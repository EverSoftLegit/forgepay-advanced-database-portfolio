/*
FORGEPAY - PORTFOLIO 5
Distributed and Cloud Database Exercise

Implementation: PostgreSQL Logical Replication
Primary: forgepay-primary (port 5433)
Secondary: forgepay-secondary (port 5434)

IMPORTANT:
Execute each section on its designated database node.
The replication password is intentionally omitted.
*/

-- ==========================================
-- 1. PRIMARY NODE CONFIGURATION
-- Execute on forgepay-primary
-- ==========================================

SHOW wal_level;
SHOW max_replication_slots;
SHOW max_wal_senders;

-- Create replication user
CREATE ROLE forge_replicator
WITH LOGIN REPLICATION PASSWORD '<REPLICATION_PASSWORD>';

GRANT CONNECT ON DATABASE forgepay TO forge_replicator;

-- Create replication table
CREATE TABLE replication_transactions (
    transaction_id INTEGER PRIMARY KEY,
    transaction_type VARCHAR(20) NOT NULL,
    amount NUMERIC(15,2) NOT NULL,
    currency CHAR(3) NOT NULL,
    status VARCHAR(20) NOT NULL
);

-- Insert initial records
INSERT INTO replication_transactions VALUES
(201, 'deposit', 25000.00, 'NGN', 'completed'),
(202, 'transfer', 7500.00, 'NGN', 'completed');

-- Create publication
CREATE PUBLICATION forgepay_publication
FOR TABLE replication_transactions;

-- Grant replication permissions
GRANT USAGE ON SCHEMA public TO forge_replicator;
GRANT SELECT ON TABLE replication_transactions
TO forge_replicator;


-- ==========================================
-- 2. SECONDARY NODE CONFIGURATION
-- Execute on forgepay-secondary
-- ==========================================

CREATE TABLE replication_transactions (
    transaction_id INTEGER PRIMARY KEY,
    transaction_type VARCHAR(20) NOT NULL,
    amount NUMERIC(15,2) NOT NULL,
    currency CHAR(3) NOT NULL,
    status VARCHAR(20) NOT NULL
);

-- Create subscription.
-- Replace <REPLICATION_PASSWORD> with the lab password
-- when reproducing the exercise.

CREATE SUBSCRIPTION forgepay_subscription
CONNECTION
'host=forgepay-primary port=5432 dbname=forgepay user=forge_replicator password=<REPLICATION_PASSWORD>'
PUBLICATION forgepay_publication;


-- ==========================================
-- 3. REPLICATION TESTS
-- Execute INSERT, UPDATE and DELETE on primary.
-- Verify each change on secondary.
-- ==========================================

-- INSERT test
INSERT INTO replication_transactions
VALUES (203, 'deposit', 15000.00, 'NGN', 'completed');

-- UPDATE test
UPDATE replication_transactions
SET status = 'reversed'
WHERE transaction_id = 202;

-- DELETE test
DELETE FROM replication_transactions
WHERE transaction_id = 201;

-- Verification query (run on both nodes)
SELECT * FROM replication_transactions
ORDER BY transaction_id;
