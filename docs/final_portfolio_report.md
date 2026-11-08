MIT 8103 — Advanced Database Systems
ForgePay: Practical Database Portfolio Report

Case Study: ForgePay — A Fictional Fintech Payment Platform  
Operating Environment: Parrot OS, PostgreSQL 15, MongoDB 7.0 and Docker

1. Introduction

This portfolio applies advanced database concepts to ForgePay, a fictional fintech platform designed to manage customers, financial accounts and payment transactions. The objective was to demonstrate how different database technologies and techniques support data integrity, query performance, transaction reliability, flexible data modelling and distributed data management.

The implementation used PostgreSQL for relational database operations and logical replication, MongoDB for document-based storage, and Docker for deploying database services in an isolated local environment.

2. Portfolio Activities and Implementation

Portfolio 1: Database Design and Modelling

A relational database was designed and implemented using three principal entities: customers, accounts and transactions. The schema incorporated primary keys, foreign keys, unique constraints, NOT NULL constraints and CHECK constraints to enforce data integrity.

An Entity Relationship Diagram was developed to illustrate the relationships between the entities. The design established the foundation for managing customer accounts and recording financial transactions within ForgePay.

Portfolio 2: Query Processing and Optimisation

SQL queries were developed to retrieve customer and account information using joins and filtering conditions. PostgreSQL execution plans were examined using `EXPLAIN` and `EXPLAIN ANALYZE`.

An index was created on the accounts balance column to investigate indexing and query optimisation. However, PostgreSQL continued to use a sequential scan because the demonstration table contained only three records. This illustrated that an index does not automatically improve every query: the query planner considers table size, selectivity and estimated execution cost when selecting an execution plan.

Portfolio 3: Transactions and Concurrency

Transaction management was examined through practical COMMIT and ROLLBACK operations. The exercises demonstrated how committed changes persist while uncommitted changes can be discarded.

READ COMMITTED and REPEATABLE READ isolation levels were tested using separate database sessions. The results demonstrated how transaction isolation affects the visibility of changes made by concurrent transactions. Row-level locking was also tested using `SELECT FOR UPDATE`, demonstrating how PostgreSQL coordinates competing access to a database record.

Portfolio 4: NoSQL and Advanced Data Models

MongoDB 7.0 was deployed using Docker. A document-based transaction collection was created to represent ForgePay transaction records, including transaction types, amounts, statuses, account information and nested metadata.

Practical operations included document insertion, retrieval, filtering, updating and deletion. The exercise demonstrated the flexibility of document databases, particularly for transaction metadata and records with varying attributes.

The analysis also recognised that MongoDB does not automatically provide relational foreign-key enforcement. Therefore, financial integrity requirements must be addressed through appropriate application and database design.

Portfolio 5: Distributed and Cloud Database Exercise

Two PostgreSQL 15 Docker containers were deployed and connected through a dedicated Docker network. PostgreSQL logical replication was configured using a publication on the primary node and a subscription on the secondary node.

Replication was verified through initial data synchronisation and subsequent INSERT, UPDATE and DELETE operations. The final records on both nodes were compared and found to match.

The exercise demonstrated data propagation between a publisher and subscriber. It did not implement automatic failover, synchronous replication, sharding or a complete high-availability architecture. These limitations were considered when discussing production deployment requirements for ForgePay.

3. Overall Reflection and Conclusion

The practical exercises demonstrated that database design and administration involve more than creating tables and executing queries. Data integrity, query planning, transaction isolation, concurrency control and distribution each address different operational requirements.

One important observation from the query optimisation exercise was that creating an index does not guarantee improved performance. Similarly, the replication exercise demonstrated that maintaining a secondary copy of data is not equivalent to implementing a complete disaster recovery or high-availability solution.

The use of PostgreSQL and MongoDB also illustrated that relational and document databases serve different purposes. A relational database provides structured relationships and constraint enforcement, while a document database offers flexibility for records containing nested or variable attributes.

Overall, the ForgePay project provided practical experience in implementing and evaluating database technologies within a fintech scenario. It also highlighted the importance of testing, evidence collection and understanding the limitations of an implementation before considering its suitability for production.

4. References

1. PostgreSQL Global Development Group. *PostgreSQL Documentation*. https://www.postgresql.org/docs/
2. MongoDB, Inc. *MongoDB Manual*. https://www.mongodb.com/docs/manual/
3. Docker, Inc. *Docker Documentation*. https://docs.docker.com/

5. AI-Use Declaration

AI assistance was used for learning support, technical explanations, troubleshooting, SQL guidance, documentation structuring and review. The practical database environments were configured and operated locally. SQL and MongoDB commands were executed, and implementation outcomes were tested and verified through database outputs and screenshots. The submitted work was reviewed against the actual practical activities performed.
