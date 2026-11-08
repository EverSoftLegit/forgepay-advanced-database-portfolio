Portfolio 5: Distributed and Cloud Database Exercise

1. Introduction

This exercise demonstrates distributed database concepts using PostgreSQL logical replication for the ForgePay fintech platform.

The objective was to configure a primary database and a secondary database, establish replication between them, and verify that changes made on the primary were reflected on the secondary.

2. Implementation Architecture

Two PostgreSQL 15 Docker containers were deployed:

- Primary node: `forgepay-primary`, exposed on host port 5433.
- Secondary node: `forgepay-secondary`, exposed on host port 5434.

Both containers were connected through a dedicated Docker network named `forgepay-network`.

Logical replication was configured using:

- A replication role named `forge_replicator`.
- A publication named `forgepay_publication` on the primary.
- A subscription named `forgepay_subscription` on the secondary.
- A replicated table named `replication_transactions`.

The primary acted as the publisher, while the secondary acted as the subscriber.

3. Replication Testing and Results

Initial records were inserted into the primary database. The subscription performed the initial table synchronisation, and the records became available on the secondary.

Three replication operations were tested:

INSERT

A new deposit transaction, ID 203, was inserted on the primary. The record subsequently appeared on the secondary.

UPDATE

The status of transaction 202 was changed from `completed` to `reversed` on the primary. The updated status was verified on the secondary.

DELETE

Transaction 201 was deleted from the primary. The record was also removed from the secondary.

These tests demonstrated that the configured logical replication propagated INSERT, UPDATE and DELETE operations successfully.

The final replicated dataset contained:

| Transaction ID | Type | Amount (NGN) | Status |
|---|---|---:|---|
| 202 | Transfer | 7,500.00 | Reversed |
| 203 | Deposit | 15,000.00 | Completed |

4. Relevance to ForgePay

For a fintech platform, maintaining consistent transaction records across database nodes supports reporting, read workloads and data availability.

A secondary database can support selected read operations and reduce the workload placed on the primary database.

Logical replication also provides flexibility because selected tables can be replicated rather than requiring the entire database to be copied.

5. Limitations and Production Considerations

This implementation demonstrates logical replication, not a complete high-availability architecture.

The following capabilities were not implemented:

- Automatic failover or promotion of the secondary node.
- Synchronous replication or guaranteed zero replication lag.
- Database sharding.
- Application-level connection switching.
- Backup and point-in-time recovery testing.
- TLS encryption and production-grade network access restrictions.

PostgreSQL logical replication is asynchronous by default. Consequently, a change may take some time to appear on the subscriber.

For production deployment, ForgePay would require monitoring of replication lag, secure credential management, encrypted connections, tested backups, disaster recovery procedures and a documented failover strategy.

A sharding strategy could distribute transaction records by customer or account identifier. However, this would introduce additional complexity around routing, cross-shard transactions and data rebalancing.

A managed cloud PostgreSQL deployment could provide additional infrastructure resilience through availability zones, automated backups, monitoring and managed failover capabilities.

6. Conclusion

The exercise successfully established PostgreSQL logical replication between two database nodes and verified the propagation of INSERT, UPDATE and DELETE operations.

It demonstrated how distributed database techniques can support the data architecture of a fintech platform while highlighting the additional controls required before such an implementation could be considered production-ready.
