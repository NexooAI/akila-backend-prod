// controllers/transactionController.js
const Transaction = require("../models/transactionModel");
const fs = require("fs").promises;
const path = require("path");
const transactionController = {
  //   createTransaction: async (req, res) => {
  //     try {
  //       const {
  //         userid,
  //         inversementid,
  //         schemeid,
  //         chitid,
  //         installment,
  //         accountnumber,
  //         payment_id,
  //         order_id,
  //         amount,
  //         currency,
  //         payment_method,
  //         signature,
  //         payment_status,
  //         paymentdate,
  //         status,
  //       } = req.body;

  //       // Validate required fields
  //       if (
  //         !userid ||
  //         !inversementid ||
  //         !schemeid ||
  //         !chitid ||
  //         !installment ||
  //         !accountnumber ||
  //         !payment_id ||
  //         !order_id ||
  //         !amount ||
  //         !currency ||
  //         !payment_method ||
  //         !payment_status ||
  //         !paymentdate
  //       ) {
  //         return res.status(400).json({
  //           success: false,
  //           data: {},
  //           message: "Missing required fields",
  //         });
  //       }

  //       const transactionId = await Transaction.createTransaction(req.body);
  //       const newTransaction = await Transaction.getTransactionById(
  //         transactionId
  //       );
  //       res.status(201).json({
  //         success: true,
  //         data: newTransaction,
  //         message: "Transaction created successfully",
  //       });
  //     } catch (error) {
  //       console.error("Error creating transaction:", error);
  //       res.status(500).json({
  //         success: false,
  //         data: {},
  //         message: "Failed to create transaction",
  //       });
  //     }
  //   },
  // createTransactionFromInvestment: async (req, res) => {
  //   try {
  //     // Extract required fields from the request body
  //     const {
  //       investmentId,
  //       payment_id,
  //       order_id,
  //       amount,
  //       currency,
  //       payment_method,
  //       signature,
  //       payment_status,
  //       paymentdate,
  //     } = req.body;

  //     if (!investmentId) {
  //       return res.status(400).json({
  //         success: false,
  //         data: {},
  //         message: "investmentId is required",
  //       });
  //     }

  //     // Retrieve investment record to get schemeid, chitid, userId, and accountnumber
  //     const [investmentRows] = await db.query(
  //       "SELECT schemeId, chitId, userId, accountNo FROM investments WHERE id = ?",
  //       [investmentId]
  //     );
  //     if (investmentRows.length === 0) {
  //       return res.status(404).json({
  //         success: false,
  //         data: {},
  //         message: "Investment not found",
  //       });
  //     }
  //     const { schemeId, chitId, userId, accountNo } = investmentRows[0];

  //     // Determine installment by counting existing transactions for this investment
  //     const [countRows] = await db.query(
  //       "SELECT COUNT(*) as count FROM transactions WHERE inversementid = ?",
  //       [investmentId]
  //     );
  //     const installment = parseInt(countRows[0].count) + 1;

  //     // Build the transaction data object
  //     const transactionData = {
  //       userid: userId,
  //       investmentId: investmentId,
  //       schemeid: schemeId,
  //       chitid: chitId,
  //       installment,
  //       accountnumber: accountNo,
  //       payment_id: payment_id || "",
  //       order_id: order_id || "",
  //       amount: amount || 0,
  //       currency: currency || "",
  //       payment_method: payment_method || "",
  //       signature: signature || "",
  //       payment_status: payment_status || "",
  //       paymentdate: paymentdate || new Date().toISOString(),
  //       status: "comming soon",
  //     };

  //     // --- FIRST INSERT ---
  //     // Insert the new transaction record and wait until it completes.
  //     const transactionId = await Transaction.createTransaction(
  //       transactionData
  //     );
  //     const newTransaction = await Transaction.getTransactionById(
  //       transactionId
  //     );

  //     // --- AFTER FIRST INSERT COMPLETES ---
  //     // Now retrieve the chit record for chitId to obtain AMOUNT and NOINS.
  //     const [chitRows] = await db.query(
  //       "SELECT AMOUNT, NOINS FROM chits WHERE id = ?",
  //       [chitId]
  //     );
  //     if (chitRows.length > 0) {
  //       const { AMOUNT, NOINS } = chitRows[0];
  //       const updatedNoins = NOINS - 1; // Subtract 1 from NOINS

  //       // Insert into basic_details using chitid, AMOUNT, and updated NOINS.
  //       await BasicDetails.insertBasicDetails(chitId, AMOUNT, updatedNoins);
  //     }

  //     // Return the newly created transaction record.
  //     res.status(201).json({
  //       success: true,
  //       data: newTransaction,
  //       message:
  //         "Transaction created successfully; basic details inserted after first insert completed",
  //     });
  //   } catch (error) {
  //     console.error("Error creating transaction from investment:", error);
  //     res.status(500).json({
  //       success: false,
  //       data: {},
  //       message: "Failed to create transaction from investment",
  //     });
  //   }
  // },
   createTransaction:async (req, res)=> {
    try {
      const transactionData = req.body;

      // Validate required fields
      if (!transactionData.userId || !transactionData.investmentId || !transactionData.schemeId || !transactionData.amount || !transactionData.paymentStatus) {
        return res.status(400).json({ message: "Missing required fields" });
      }

      // Call the service to insert the transaction
      const transactionId = await Transaction.createTransaction(transactionData);
      if(transactionId.success)
        {
      return res.status(201).json({
        message: "Transaction created successfully",
        transactionId:transactionId.transactionId,
      });
    }
    else
    {
      return res.status(500).json({
        message: "Error in payment processing",
        data: transactionId,
       
      });
    }
    } catch (error) {
      console.error("Error creating transaction:", error);
      return res.status(500).json({ message: "Internal Server Error", error: error.message });
    }
  },
  getTransactions:async (req, res) => {
    try {
      console.log("api",req.body)
      const { userId, investmentId, schemeId, accountNumber, chitId } = req.query;
  
      // Construct filters dynamically
      const filters = {};
      if (userId) filters.userId = userId;
      if (investmentId) filters.investmentId = investmentId;
      if (schemeId) filters.schemeId = schemeId;
      if (accountNumber) filters.accountNumber = accountNumber;
      if (chitId) filters.chitId = chitId;
  
      // Fetch transactions based on filters
      const transactions = await Transaction.getFilterTransactions(filters);
  
      res.status(200).json({ success: true, data: transactions });
    } catch (err) {
      res.status(500).json({ success: false, error: err.message || err });
    }
  },
  getTransactionById: async (req, res) => {
    try {
      const { id } = req.params;
      const transaction = await Transaction.getTransactionById(id);
      if (!transaction) {
        return res.status(404).json({
          success: false,
          data: {},
          message: "Transaction not found",
        });
      }
      res.status(200).json({
        success: true,
        data: transaction,
        message: "Transaction retrieved successfully",
      });
    } catch (error) {
      console.error("Error fetching transaction:", error);
      res.status(500).json({
        success: false,
        data: {},
        message: "Failed to fetch transaction",
      });
    }
  },
  exportPayments : async (req, res) => {
    try {
      const { startDate, endDate } = req.query;
  
      if (!startDate || !endDate) {
        return res.status(400).json({ success: false, message: "Start date and end date are required." });
      }
  
      const result = await Transaction.exportPaymentsExcel(startDate, endDate);
  
      if (!result.success) {
        return res.status(404).json({ success: false, message: result.message });
      }
  
      res.download(result.filePath, "payments.xlsx", async (err) => {
        if (err) {
          console.error("Download error:", err);
          return res.status(500).json({ message: "File download error." });
        }
        // Delete file after successful download
        await fs.unlink(result.filePath);
      });
    } catch (error) {
      res.status(500).json({ success: false, message: error.message });
    }
  },
  getAllTransactions: async (req, res) => {
    try {
      const transactions = await Transaction.getAllTransactions();
      res.status(200).json({
        success: true,
        data: transactions,
        message: "Transactions retrieved successfully",
      });
    } catch (error) {
      console.error("Error fetching transactions:", error);
      res.status(500).json({
        success: false,
        data: {},
        message: "Failed to fetch transactions",
      });
    }
  },

  updateTransaction: async (req, res) => {
    try {
      const { id } = req.params;
      const result = await Transaction.updateTransaction(id, req.body);
      if (result.affectedRows === 0) {
        return res.status(404).json({
          success: false,
          data: {},
          message: "Transaction not found",
        });
      }
      const updatedTransaction = await Transaction.getTransactionById(id);
      res.status(200).json({
        success: true,
        data: updatedTransaction,
        message: "Transaction updated successfully",
      });
    } catch (error) {
      console.error("Error updating transaction:", error);
      res.status(500).json({
        success: false,
        data: {},
        message: "Failed to update transaction",
      });
    }
  },

  deleteTransaction: async (req, res) => {
    try {
      const { id } = req.params;
      const result = await Transaction.deleteTransaction(id);
      if (result.affectedRows === 0) {
        return res.status(404).json({
          success: false,
          data: {},
          message: "Transaction not found",
        });
      }
      res.status(200).json({
        success: true,
        data: { id },
        message: "Transaction deleted successfully",
      });
    } catch (error) {
      console.error("Error deleting transaction:", error);
      res.status(500).json({
        success: false,
        data: {},
        message: "Failed to delete transaction",
      });
    }
  },
};

module.exports = transactionController;
