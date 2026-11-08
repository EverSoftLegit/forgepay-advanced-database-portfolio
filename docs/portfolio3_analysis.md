# Portfolio 3: Transactions and Concurrency

## 1. Introduction

This exercise examines transaction management and concurrency
control in the ForgePay fintech database using PostgreSQL 15.

The practical activities demonstrate transaction initiation,
commit, rollback, isolation levels, concurrent database access
and row-level locking.

A dedicated transaction_lab table was created to conduct
transaction experiments without modifying actual customer
account balances.

## 2. Transaction Management

Two transaction control operations were demonstrated.

### ROLLBACK

A transaction was initiated using BEGIN, followed by an INSERT
operation into transaction_lab.

A SELECT query confirmed that the inserted record was visible
within the active transaction.

ROLLBACK was then executed. A subsequent SELECT returned
zero rows, demonstrating that the uncommitted insertion
had been undone.

### COMMIT

A second transaction inserted a record labelled
"Commit demonstration".

COMMIT was executed, after which a SELECT query confirmed
that the record remained permanently stored.

These exercises demonstrate the difference between
committing and rolling back database transactions.

## 3. Transaction Isolation

Two PostgreSQL isolation levels were examined using separate
database sessions.

### READ COMMITTED

Session A began a transaction using READ COMMITTED.
It initially retrieved two records from transaction_lab.

Session B inserted and committed another record.

When Session A repeated its SELECT query without ending
its transaction, the newly committed record became visible.

This demonstrated that READ COMMITTED provides a fresh
snapshot for each statement.

### REPEATABLE READ

Session A began a transaction using REPEATABLE READ
and retrieved the existing records.

Session B subsequently inserted and committed another record.

When Session A repeated its SELECT query, the new record
was not visible within the existing transaction.

After Session A committed and executed another SELECT,
the newly committed record became visible.

This demonstrated snapshot consistency under REPEATABLE READ.

## 4. Concurrency Control and Row-Level Locking

Two PostgreSQL sessions were used to demonstrate
row-level locking.

Session A acquired a lock on ForgePay account FP100001
using SELECT ... FOR UPDATE.

Session B attempted to acquire a conflicting lock
on the same account row.

Session B waited until Session A committed and released
its lock. The waiting query then completed successfully.

The account balance was checked before and after the
experiment and remained NGN 150,000.00.

This demonstrated how PostgreSQL coordinates concurrent
access to records using row-level locks.

## 5. Findings and Relevance to ForgePay

Transaction management is essential to financial systems
because incomplete or inconsistent operations can affect
financial records.

COMMIT and ROLLBACK provide transaction control, while
isolation levels determine how concurrent transactions
observe database changes.

Row-level locking helps coordinate conflicting operations
on the same account record.

For ForgePay, these mechanisms are relevant to account
updates, withdrawals, transfers and other operations
that require consistent financial records.

## 6. Conclusion

The practical exercise demonstrated transaction control,
transaction isolation and concurrency management using
PostgreSQL.

The results showed that committed changes persist,
uncommitted changes can be rolled back, isolation levels
affect data visibility, and row-level locks coordinate
concurrent access.
