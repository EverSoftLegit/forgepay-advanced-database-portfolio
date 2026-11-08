Portfolio 4: NoSQL and Advanced Data Models

1. Introduction

This exercise explored the use of a document-oriented NoSQL database within the ForgePay fintech payment platform. MongoDB 7.0 was deployed locally using Docker to demonstrate how transaction records can be represented, stored, queried and modified using a document-based data model.

The objective was to implement an alternative data model to the relational PostgreSQL database developed in the earlier portfolio activities and evaluate its suitability for fintech workloads.

2. MongoDB Implementation

A MongoDB database named `forgepay_nosql` and a collection named `transactions` were created.

Three sample transaction documents representing deposits, withdrawals and transfers were inserted. Each document contained transaction attributes such as transaction ID, transaction type, amount, currency, status and creation timestamp.

Related account information and transaction metadata were embedded within the documents. For example, source and destination account details were represented as nested objects rather than being maintained exclusively through relational foreign keys.

MongoDB's `Decimal128` data type was used for monetary values to avoid relying on binary floating-point representation.

3. Operations and Queries Demonstrated

The implementation demonstrated the following operations:

- Create: Inserted three transaction documents using `insertMany()`.
- Read: Retrieved all documents using `find()` and retrieved individual records using `findOne()`.
- Filtering: Queried completed transactions and transactions of a particular type.
- Nested-field querying: Retrieved transactions using the embedded source account number through MongoDB dot notation.
- Update: Modified the channel metadata of transaction 103 from `internet_banking` to `USSD` using `updateOne()`.
- Delete: Inserted and deleted a temporary test document using `deleteOne()`.

The final collection count returned three documents, confirming that the temporary deletion test did not remove the original transaction records.

4. Relational and Document Model Comparison

The earlier PostgreSQL implementation represented customers, accounts and transactions in separate relational tables connected through primary and foreign keys.

The MongoDB implementation used a more flexible document structure in which account details and metadata could be embedded directly within transaction records.

This approach reduces the need for joins when retrieving transaction information together with its associated account details. It also accommodates additional transaction metadata without requiring every new attribute to be introduced as a relational table column.

However, embedding introduces data duplication and consistency considerations. If embedded account details change, multiple transaction documents may require updates. MongoDB also does not automatically enforce the same foreign-key relationships as the PostgreSQL schema.

5. Suitability for ForgePay

MongoDB could be useful for ForgePay workloads involving flexible transaction metadata, channel-specific information, audit enrichment and operational event records.

For example, mobile, ATM and internet-banking transactions may contain different metadata attributes. A document model can accommodate these differences without forcing every transaction type into an identical structure.

However, MongoDB should not automatically replace the relational database for core financial operations. Account balances, transfers, transaction integrity and consistency requirements demand carefully designed controls. MongoDB supports multi-document transactions, but their use, isolation requirements and operational trade-offs must be assessed.

A hybrid architecture could therefore retain PostgreSQL for core financial records while using MongoDB for selected flexible or metadata-intensive workloads.

6. Conclusion

The exercise demonstrated the practical implementation of a document-oriented database using MongoDB. Database creation, document insertion, retrieval, filtering, nested-field queries, updates and deletions were successfully performed.

The comparison with PostgreSQL showed that relational and document databases address different data-management requirements. The appropriate choice depends on data relationships, consistency requirements, query patterns and operational needs rather than assuming that one database model is universally superior.
