ForgePay — Advanced Database Systems Portfolio

Project Overview

ForgePay is a fictional fintech payment platform developed as the case study for the MIT 8103 Advanced Database Systems practical portfolio.

This project demonstrates the design, implementation and evaluation of database technologies used to support financial transactions, data integrity, query performance, concurrency and distributed data management.

The practical work uses PostgreSQL and MongoDB, with Docker for containerised database deployment.

Portfolio Activities

Portfolio 1 — Database Design and Modelling
- Designed a relational database for customers, accounts and transactions.
- Implemented primary keys, foreign keys and integrity constraints.
- Developed an Entity Relationship Diagram (ERD).
- Applied relational database design principles.

Portfolio 2 — Query Processing and Optimisation
- Developed SQL queries involving joins and filtering.
- Examined execution plans using `EXPLAIN` and `EXPLAIN ANALYZE`.
- Created an index on the accounts balance column.
- Evaluated query planning and execution behaviour.

Portfolio 3 — Transactions and Concurrency
- Demonstrated transaction commit and rollback.
- Examined READ COMMITTED and REPEATABLE READ isolation levels.
- Demonstrated concurrent database access.
- Tested row-level locking using `SELECT FOR UPDATE`.

Portfolio 4 — NoSQL and Advanced Data Models
- Deployed MongoDB 7.0 using Docker.
- Created a document-based transaction collection.
- Demonstrated document insertion, retrieval, filtering, updating and deletion.
- Evaluated the suitability of document databases for fintech transaction metadata.

Portfolio 5 — Distributed and Cloud Database Exercise
- Deployed two PostgreSQL 15 database nodes using Docker.
- Configured PostgreSQL logical replication.
- Created a publication on the primary and a subscription on the secondary.
- Verified replication of INSERT, UPDATE and DELETE operations.
- Discussed high availability, sharding and cloud deployment considerations.

Project Structure

```text
forgepay-portfolio/
├── diagrams/       # Entity Relationship Diagram
├── docs/           # Portfolio analysis documents
├── nosql/          # MongoDB implementation
├── results/        # Query and test results
├── screenshots/    # Practical evidence
├── sql/            # SQL scripts and database schema
└── README.md       # Project documentation
```

Technologies Used

- PostgreSQL 15
- MongoDB 7.0
- SQL
- MongoDB Query Language
- Docker
- Graphviz
- Parrot OS
- Git and GitHub

Implementation Notes

The project was implemented in a local Linux environment for academic demonstration.

The PostgreSQL logical replication exercise demonstrates data propagation between a publisher and subscriber. It does not implement automatic failover, synchronous replication or a complete production high-availability architecture.

The MongoDB deployment is a local coursework environment and is not configured as a production-secured database service.

Evidence and Documentation

The `screenshots/` directory contains practical evidence for all five portfolio activities.

The `docs/` directory contains analysis documents, while `sql/` and `nosql/` contain implementation scripts.

Author

Course MIT 8103 — Advanced Database Systems  
Case Study: ForgePay  
Project Type: Individual Practical Database Portfolio
