
// FORGEPAY - PORTFOLIO 4
// MongoDB document-oriented database implementation
// MongoDB version: 7.0

// Select database
use("forgepay_nosql");

// Create transactions collection if it does not exist
if (!db.getCollectionNames().includes("transactions")) {
    db.createCollection("transactions");
}

// Insert sample transaction documents
// Run this insertion section only once.
if (db.transactions.countDocuments({}) === 0) {
    db.transactions.insertMany([
        {
            transaction_id: 101,
            transaction_type: "deposit",
            amount: NumberDecimal("20000.00"),
            currency: "NGN",
            status: "completed",
            destination_account: {
                account_id: 1,
                account_number: "FP100001"
            },
            metadata: {
                channel: "mobile",
                description: "Customer deposit"
            },
            created_at: ISODate("2026-11-08T10:00:00Z")
        },
        {
            transaction_id: 102,
            transaction_type: "withdrawal",
            amount: NumberDecimal("10000.00"),
            currency: "NGN",
            status: "completed",
            source_account: {
                account_id: 2,
                account_number: "FP100002"
            },
            metadata: {
                channel: "ATM",
                description: "Cash withdrawal"
            },
            created_at: ISODate("2026-11-08T11:00:00Z")
        },
        {
            transaction_id: 103,
            transaction_type: "transfer",
            amount: NumberDecimal("5000.00"),
            currency: "NGN",
            status: "completed",
            source_account: {
                account_id: 1,
                account_number: "FP100001"
            },
            destination_account: {
                account_id: 3,
                account_number: "FP100003"
            },
            metadata: {
                channel: "USSD",
                description: "Funds transfer"
            },
            created_at: ISODate("2026-11-08T12:00:00Z")
        }
    ]);
}

// READ: Retrieve all transactions
db.transactions.find().pretty();

// READ: Find completed transactions
db.transactions.find({ status: "completed" }).pretty();

// READ: Find transfers
db.transactions.find({ transaction_type: "transfer" }).pretty();

// READ: Query a nested account field
db.transactions.find({
    "source_account.account_number": "FP100001"
}).pretty();

// UPDATE: Change transaction channel
db.transactions.updateOne(
    { transaction_id: 103 },
    { $set: { "metadata.channel": "USSD" } }
);

// VERIFY UPDATE
db.transactions.findOne({ transaction_id: 103 });

// DELETE: Temporary test document
db.transactions.insertOne({
    transaction_id: 999,
    transaction_type: "deposit",
    amount: NumberDecimal("100.00"),
    currency: "NGN",
    status: "pending",
    description: "Temporary deletion test"
});

db.transactions.deleteOne({ transaction_id: 999 });

// FINAL VERIFICATION
db.transactions.countDocuments({});
