// models/transactionModel.js
const db = require("../config/db");
const ExcelJS = require("exceljs");
const fs = require("fs").promises;
const path = require("path");
const { v4: uuidv4 } = require('uuid');
class Transaction {
  static async createTransaction(transactionData) {
    let {
        userId,
        investmentId,
        schemeId,
        chitId,
        accountNumber,
        paymentId = null, // Default null for pending transactions
        orderId,
        amount,
        currency,
        paymentMethod,
        signature = null, // Default null if not available
        paymentStatus,
        paymentDate,
        status = "coming soon", // Fixed typo
        gatewayTransactionId = null, // Default null until confirmed
        gatewayresponse,
        isManual,
        utr_reference_number
    } = transactionData;
    const manualPayment = isManual || 'no'; 
    try {
      if (amount <= 0) {
        return { success: false, message: "Invalid payment amount." };
      }
      if (manualPayment === 'no' && (!gatewayTransactionId || !orderId)) {
        return { success: false, message: "Transaction ID and Order ID are required for online payments." };
      }
      let utr_reference=null
      if(manualPayment=='yes')
      {
        // ✅ Step 1: Check if transaction_id already exists
        const [existingTransaction] = await db.execute(
          `SELECT id FROM transactions WHERE gatewayTransactionId = ? LIMIT 1`,
          [gatewayTransactionId]
        );
        if (existingTransaction.length > 0) {
          
          return { success: false, message: "Duplicate transaction detected." };
        }
  
        // ✅ Step 2: Check if order_id already exists
        const [existingOrder] = await db.execute(
          `SELECT id FROM transactions WHERE orderId = ? LIMIT 1`,
          [orderId]
        );
        if (existingOrder.length > 0) {
        
          return { success: false, message: "Duplicate order detected." };
        }
      }
        // Fetch last successful installment
        const installment = await this.getLastPaidInstallments(investmentId);

        // Determine the new installment number
      // Convert to a Date object
        let dateObj = new Date(paymentDate);

        // Format it to 'YYYY-MM-DD HH:MM:SS'
        let mysqlFormattedDate = dateObj.toISOString().slice(0, 19).replace('T', ' ');

        // Now mysqlFormattedDate is in the correct format '2025-04-03 18:31:54'
        console.log(mysqlFormattedDate); // Output: '2025-04-03 18:31:54'
        if (isManual === 'yes') {
          const manualPayment = generateManualPaymentIds(userId, investmentId);
        
          orderId = manualPayment.orderId;
        
          if (paymentMethod === 'Cash') {
            gatewayTransactionId = manualPayment.transactionId;
          }
        }
        if ( isManual=='yes' &&
          ['UPI', 'NetBanking', 'CreditCard', 'DebitCard'].includes(paymentMethod) &&
          utr_reference_number) {
            const [existingManualUPI] = await db.execute(
              `SELECT id FROM payments WHERE utr_reference = ? LIMIT 1`,
              [utr_reference_number]
            );
            if (existingManualUPI.length > 0) {
              
              return { success: false, message: "Duplicate UTR reference for manual payment." };
            }
            utr_reference=utr_reference_number||null
        }
        // Insert transaction record
        const query = `
          INSERT INTO transactions 
          (userId, investmentId, schemeId, chitId, installment, accountNumber, paymentId, orderId, amount, currency, paymentMethod, signature, paymentStatus, paymentDate, status, gatewayTransactionId,gatewayresponse,isManual,utr_reference)
          VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?,?)
        `;

        const [result] = await db.query(query, [
            userId,
            investmentId,
            schemeId,
            chitId,
            installment,
            accountNumber,
            paymentId,
            orderId,
            amount,
            currency,
            paymentMethod,
            signature,
            paymentStatus,
            mysqlFormattedDate,
            status,
            gatewayTransactionId,
            gatewayresponse,
            manualPayment,
            utr_reference
        ]);

        return {success:true,transactionId:result.insertId}

    } catch (error) {
        console.error("Error creating transaction:", error);
        throw new Error("Transaction creation failed");
    }
}


  static async getTransactionById(id) {
    const query = "SELECT * FROM transactions WHERE id = ?";
    const [rows] = await db.query(query, [id]);
    return rows.length ? rows[0] : null;
  }

  static async getAllTransactions() {
    const query = "SELECT * FROM transactions";
    const [rows] = await db.query(query);
    return rows;
  }
  static async getFilterTransactions(filters = {}) {
    let query = "SELECT * FROM transactions";
    let conditions = [];
    let values = [];
  
    if (filters.userId) {
      conditions.push("userId = ?");
      values.push(filters.userId);
    }
    if (filters.investmentId) {
      conditions.push("investmentId = ?");
      values.push(filters.investmentId);
    }
    if (filters.schemeId) {
      conditions.push("schemeId = ?");
      values.push(filters.schemeId);
    }
    if (filters.accountNumber) {
      conditions.push("accountNumber = ?");
      values.push(filters.accountNumber);
    }
    if (filters.chitId) {
      conditions.push("chitId = ?");
      values.push(filters.chitId);
    }
  
    if (conditions.length > 0) {
      query += " WHERE " + conditions.join(" AND ");
    }
  console.log('query',query)
    const [rows] = await db.query(query, values);
    return rows;
  }
  

  static async updateTransaction(id, transactionData) {
    const {
      userid,
      inversementid,
      schemeid,
      chitid,
      installment,
      accountnumber,
      payment_id,
      order_id,
      amount,
      currency,
      payment_method,
      signature,
      payment_status,
      paymentdate,
      status,
    } = transactionData;
    const query = `
      UPDATE transactions
      SET userid = ?, inversementid = ?, schemeid = ?, chitid = ?, installment = ?, accountnumber = ?, payment_id = ?, order_id = ?, amount = ?, currency = ?, payment_method = ?, signature = ?, payment_status = ?, paymentdate = ?, status = ?
      WHERE id = ?
    `;
    const [result] = await db.query(query, [
      userid,
      inversementid,
      schemeid,
      chitid,
      installment,
      accountnumber,
      payment_id,
      order_id,
      amount,
      currency,
      payment_method,
      signature,
      payment_status,
      paymentdate,
      status,
      id,
    ]);
    return result;
  }

  static async deleteTransaction(id) {
    const query = "DELETE FROM transactions WHERE id = ?";
    const [result] = await db.query(query, [id]);
    return result;
  }
  // static async exportPaymentsExcel(startDate, endDate) {
  //   try {
  //     let query = `
  //       SELECT t.id, t.userId, u.name as user, t.amount, t.currency, t.paymentMethod, 
  //              t.paymentStatus, t.paymentDate
  //       FROM transactions t
  //       JOIN users u ON t.userId = u.id
  //     `;
  //     const queryParams = [];

  //     if (startDate && endDate) {
  //       query += " WHERE paymentDate BETWEEN ? AND ?";
  //       queryParams.push(startDate, endDate);
  //     }

  //     const [payments] = await db.query(query, queryParams);

  //     if (!payments.length) {
  //       return { success: false, message: "No payments found in the given date range." };
  //     }

  //     const workbook = new ExcelJS.Workbook();
  //     const worksheet = workbook.addWorksheet("Payments");

  //     // Define headers
  //     worksheet.columns = [
  //       { header: "ID", key: "id", width: 10 },
  //       { header: "User ID", key: "userId", width: 15 },
  //       { header: "Amount", key: "amount", width: 15 },
  //       { header: "Currency", key: "currency", width: 10 },
  //       { header: "Payment Method", key: "paymentMethod", width: 15 },
  //       { header: "Payment Status", key: "paymentStatus", width: 15 },
  //       { header: "Payment Date", key: "paymentDate", width: 20 },
  //     ];

  //     // Add rows
  //     payments.forEach((payment) => worksheet.addRow(payment));

  //     // Set file path
  //     const filePath = path.join(__dirname, "../exports/payments.xlsx");

  //     await workbook.xlsx.writeFile(filePath);

  //     return { success: true, filePath };
  //   } catch (error) {
  //     console.error("Error exporting payments:", error);
  //     throw new Error("Error generating the Excel file.");
  //   }
  // }
  static async exportPaymentsExcel(startDate, endDate) {
    try {
      let query = `
        SELECT t.id, t.userId, u.name as userName, t.amount, t.currency, t.paymentMethod, 
               t.paymentStatus, t.paymentDate
        FROM transactions t
        JOIN users u ON t.userId = u.id
      `;
      const queryParams = [];

      if (startDate && endDate) {
        query += " WHERE DATE(t.paymentDate)>=? AND DATE(t.paymentDate)<=?";
        queryParams.push(startDate, endDate);
      }
console.log('query',query)
      const [payments] = await db.query(query, queryParams);

      if (!payments.length) {
        return { success: false, message: "No payments found in the given date range." };
      }

      const workbook = new ExcelJS.Workbook();
      const worksheet = workbook.addWorksheet("Payments");

      // Define headers including userName
      worksheet.columns = [
        { header: "ID", key: "id", width: 10 },
        { header: "User ID", key: "userId", width: 10 },
        { header: "User Name", key: "userName", width: 20 }, // Added userName
        { header: "Amount", key: "amount", width: 15 },
        { header: "Currency", key: "currency", width: 10 },
        { header: "Payment Method", key: "paymentMethod", width: 15 },
        { header: "Payment Status", key: "paymentStatus", width: 15 },
        { header: "Payment Date", key: "paymentDate", width: 20 },
      ];

      // Add rows
      payments.forEach((payment) => worksheet.addRow(payment));

      // Set file path
      const filePath = path.join(__dirname, "../exports/payments.xlsx");

      await workbook.xlsx.writeFile(filePath);

      return { success: true, filePath };
    } catch (error) {
      console.error("Error exporting payments:", error);
      throw new Error("Error generating the Excel file.");
    }
  }
  static async getLastPaidInstallment(investmentId) {
    const query = `
        SELECT installment, paymentStatus 
        FROM transactions 
        WHERE investmentId = ? 
        ORDER BY installment DESC 
        LIMIT 1
    `;
    const [rows] = await db.query(query, [investmentId]);

    // If no records exist, start from 0
    if (rows.length === 0) return 0;

    const { installment, paymentStatus } = rows[0];

    // If the last transaction was failed, return the same installment
    return paymentStatus === 'failed' ? installment : installment + 1;
}
  
static async getLastPaidInstallments(investmentId) {
  const query = `
      SELECT installment 
      FROM transactions 
      WHERE investmentId = ? AND paymentStatus = 'success' 
      ORDER BY installment DESC 
      LIMIT 1
  `;
  
  const [rows] = await db.query(query, [investmentId]);

  // If no successful transactions exist, start from 0
  return rows.length === 0 ? 1 : rows[0].installment + 1;
}
}
function generateManualPaymentIds(userId,investment_id) {
  const timestamp = Date.now(); // current UTC time in milliseconds
  const randomUuid = uuidv4().split('-')[0]; // short unique string
  const prefix = 'DC_MANUAL';

  const transactionId = `${prefix}_TXN_${userId}_${investment_id}_${timestamp}_${randomUuid}`;
  const orderId = `${prefix}_ORD_${userId}_${investment_id}_${timestamp}`;

  return { transactionId, orderId };
}

module.exports = Transaction;
