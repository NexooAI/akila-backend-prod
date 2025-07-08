require("dotenv").config();
const db = require("../config/db");
const logger=require('../middlewares/logger')
const { v4: uuidv4 } = require('uuid');
const { encrypt, encryptcc, decryptcc } = require('../utils/encryptor');
const {decrypt}=require('./ccavutil')
 const crypto = require('crypto')
 const qs = require('querystring');
 const { orderMetaMap } = require("../utils/socket");
 const investmentmodel=require('../models/investmentModel')
 const transaction=require('../models/transactionModel')
 let eventEmitter;
try {
  eventEmitter = require("../index").eventEmitter;
} catch (error) {
  console.warn("EventEmitter not available:", error.message);
  eventEmitter = null;
}
const Payment = {
 
  create: async (data) => {
    const connection = await db.getConnection();
  
    try {
      await connection.beginTransaction();
      let { investmentId, paymentAmount, userId, paymentMethod, schemeId, transactionId, orderId,chitId,isManual,utr_reference_number } = data;
      console.log("data",transactionId)
       const manualPayment = isManual || 'no'; 

      if (paymentAmount <= 0) {
        return { success: false, message: "Invalid payment amount." };
      }
      if (manualPayment === 'no' && (!transactionId || !orderId)) {
        return { success: false, message: "Transaction ID and Order ID are required for online payments." };
      }
      let utr_reference=null
      if(manualPayment=='no')
      {

      
      // Step 1: Check for duplicate transaction
      const [existingTransaction] = await connection.execute(
        `SELECT id FROM payments WHERE transaction_id = ? LIMIT 1`,
        [transactionId]
      );
      console.log("existing",JSON.stringify(existingTransaction))
    
      if (existingTransaction.length > 0)  {
        await connection.rollback();
        return { success: false, message: "Duplicate transaction detected." };
      }
  
      // Step 2: Check for duplicate order
      const [existingOrder] = await connection.execute(
        `SELECT id FROM payments WHERE order_id = ?`,
        [orderId]
      );
      
      if (existingOrder.length > 0) {
        await connection.rollback();
        return { success: false, message: "Duplicate order detected." };
      }
    }
      // Step 3: Fetch scheme details
      const [schemeResult] = await connection.execute(
        `SELECT s.type, s.scheme_plan_type_id, c.payment_frequency as payment_frequency_id FROM chits as c join schemes as s on c.SchemeId=s.id WHERE c.id = ? LIMIT 1`,
        [chitId]
      );
  
      if (schemeResult.length === 0) {
        await connection.rollback();
        return { error: true, message: "Scheme not found." };
      }

      //step4:Get the fixed amount the chits table
       // Step 3: Fetch scheme details
       const [chitResult] = await connection.execute(
        `SELECT AMOUNT as  fixed  FROM chits WHERE SchemeId  = ? LIMIT 1`,
        [schemeId]
      );
      if (chitResult.length === 0) {
        await connection.rollback();
        return { error: true, message: "chit not found." };
      }
        console.log('chitResult',JSON.stringify(chitResult))
        const [investmentData] = await connection.execute(
        `SELECT firstMonthAmount FROM investments WHERE id = ? LIMIT 1`,
        [investmentId]
      );

      let firstMonthAmount = investmentData.length > 0 ? investmentData[0].firstMonthAmount : 0;

      console.log("First Month Amount from Investment:", firstMonthAmount);

      const { type: schemeType, scheme_plan_type_id, payment_frequency_id } = schemeResult[0];
      const { fixed: fixed } = chitResult[0];
  
      // Step 4: Fetch scheme plan type and payment frequency names
      const [[planTypeResult]] = await connection.execute(
        `SELECT name FROM scheme_plan_types WHERE id = ?`,
        [scheme_plan_type_id]
      );
  
      const [[frequencyResult]] = await connection.execute(
        `SELECT name FROM payment_frequencies WHERE id = ?`,
        [payment_frequency_id]
      );
  
      const planTypeName = planTypeResult ? planTypeResult.name : null;
      const frequencyName = frequencyResult ? frequencyResult.name : null;
  console.log("scheme",planTypeName,frequencyName,paymentAmount,fixed)
      // Step 5: If scheme is "fixed", validate payment amount
      if (planTypeName && planTypeName.toLowerCase() === "fixed") {
        if (parseFloat(paymentAmount) !== parseFloat(firstMonthAmount)) {
          await connection.rollback();
          return { error: true, message: `Payment amount should be exactly ₹${firstMonthAmount} for fixed schemes.` };
        }
      }
  
      // Step 6: Fetch active gold & silver rates
      const [rateResult] = await connection.execute(
        `SELECT gold_rate, silver_rate FROM rates WHERE status = 'active'`
      );
      if (rateResult.length === 0) {
        await connection.rollback();
        return { error: true, message: "Active rates not found." };
      }
      const { gold_rate, silver_rate } = rateResult[0];
  
      let goldWeightGained = 0;
      let silverWeightGained = 0;
      let finalGoldRate = 0;
      let finalSilverRate = 0;
  
      if (schemeType === "gold") {
        goldWeightGained = parseFloat(paymentAmount) / parseFloat(gold_rate);
        finalGoldRate = gold_rate;
      } else if (schemeType === "silver") {
        silverWeightGained = parseFloat(paymentAmount) / parseFloat(silver_rate);
        finalSilverRate = silver_rate;
      }
  
      const utcPaymentDate = new Date().toISOString().slice(0, 19).replace("T", " "); // UTC format
  
      // Step 7: Fetch last installment month
      const [lastPaymentResult] = await connection.execute(
        `SELECT MAX(monthNumber) AS lastPaidMonth FROM payments WHERE investment_id = ? AND payment_status = 'success'`,
        [investmentId]
      );
  
      let installmentMonth = 1;
      if (lastPaymentResult.length > 0 && lastPaymentResult[0].lastPaidMonth !== null) {
        installmentMonth = lastPaymentResult[0].lastPaidMonth + 1;
      }
    if (isManual === 'yes') {
        const manualPayment = generateManualPaymentIds(userId, investmentId);
      
        orderId = manualPayment.orderId;
      
        if (paymentMethod === 'Cash') {
          transactionId = manualPayment.transactionId;
        }
      }
      if ( isManual=='yes' &&
        ['UPI', 'NetBanking', 'CreditCard', 'DebitCard'].includes(paymentMethod) &&
        utr_reference_number) {
          const [existingManualUPI] = await connection.execute(
            `SELECT id FROM payments WHERE utr_reference = ? LIMIT 1`,
            [utr_reference_number]
          );
          console.log("Exisitng",existingManualUPI)
          if (existingManualUPI.length > 0) {
            await connection.rollback();
            return { success: false, message: "Duplicate UTR reference for manual payment." };
          }
          utr_reference=utr_reference_number||null
      }
      // Step 8: Insert payment record
      const [paymentData] = await connection.execute(
        `INSERT INTO payments (investment_id, user_id, amount, current_goldrate, current_silverrate, gold_rate, silver_rate, payment_date, payment_status, transaction_id, payment_method, monthNumber, created_at, updated_at, order_id,isManual,utr_reference) 
         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?,?)`,
        [
          investmentId,
          userId,
          paymentAmount,
          finalGoldRate,
          finalSilverRate,
          goldWeightGained.toFixed(2),
          silverWeightGained.toFixed(2),
          utcPaymentDate,
          "success",
          transactionId,
          paymentMethod,
          installmentMonth,
          utcPaymentDate,
          utcPaymentDate,
          orderId,
          manualPayment,
          utr_reference
        ]
      );
  
      const insertedId = paymentData.insertId;
  console.log("insert",insertedId)
      await connection.commit();
      return {
        success: true,
        message: "Payment added successfully.",
        paymentId: insertedId,
        installmentMonth,
        goldWeightGained,
        silverWeightGained,
        schemeType,
        planTypeName,
        frequencyName
      };
  
    } catch (error) {
      logger.error(error)
      await connection.rollback();
      console.error("Error adding payment:", error);
      return { error: true, message: "Database error occurred." };
    } finally {
      connection.release();
    }
  },
  
akila_initiatePayment: (data) => {
  const { order_id,userId, amount, investmentId,currency,userEmail,userMobile,userName,chitId,schemeId,payment_frequency_id } = data;

  if (!order_id || !amount || !currency) {
    return { success: false, message: "Missing required fields" };
  }
  

  const paymentData = {
    merchant_id: process.env.MERCHANT_ID || 'YOUR_MERCHANT_ID',
    order_id,
    currency,
    amount,
    userId,
    schemeId,
    chitId,
    payment_frequency_id,
    investmentId,
    redirect_url: process.env.REDIRECT_URL || 'https://yourdomain.com/payment-success',
    cancel_url: process.env.REDIRECT_URL || 'https://yourdomain.com/payment-cancel',
    language: 'EN',
    billing_name: userName,
    billing_email: userEmail,
    billing_tel: userMobile,
    billing_address: '123 Street',
    billing_city: 'City',
    billing_state: 'State',
    billing_zip: '123456',
    billing_country: 'India',
  };
  console.log("Redirect URL:", paymentData.redirect_url);
console.log("paymentData",JSON.stringify(paymentData))
  const workingKey = process.env.REQUEST_WORKING_KEY || 'YOUR_WORKING_KEY';
  const accessCode = process.env.REQUEST_ACCESS_CODE || 'YOUR_ACCESS_CODE';

  const querystring = Object.entries(paymentData)
    .map(([key, val]) => `${key}=${encodeURIComponent(val)}`)
    .join('&');
    var md5 = crypto.createHash('md5').update(workingKey).digest();
    var keyBase64 = Buffer.from(md5).toString('base64');

    //Initializing Vector and then convert in base64 string
    var ivBase64 = Buffer.from([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d,0x0e, 0x0f]).toString('base64');
  //const encRequest = encrypt(querystring, workingKey);
 const encRequest = encryptcc(querystring, keyBase64, ivBase64);
 //console.log("de",decryptcc(encRequest,keyBase64))
   const ccavenueurl = process.env.STAGE_CCAVENUE_URL || 'https://test.ccavenue.com/transaction/transaction.do?command=initiateTransaction';
  const paymentLink = `${ccavenueurl}&encRequest=${encRequest}&access_code=${accessCode}`;
  // return `
  //   <form id="ccavenueForm" method="post" action="https://test.ccavenue.com/transaction/transaction.do?command=initiateTransaction">
  //     <input type="hidden" name="encRequest" value="${encRequest}" />
  //     <input type="hidden" name="access_code" value="${accessCode}" />
  //   </form>
  //   <script>document.getElementById('ccavenueForm').submit();</script>
  // `;
  return {success:true,data:paymentLink,order_id}
},
 handleCCAvenueResponse: async(encResp,orderNo) => {
    try {
      const workingKey = process.env.REQUEST_WORKING_KEY || 'YOUR_WORKING_KEY';
      console.log("response working key",workingKey)
      const orderIdValue=orderNo
      //Generate Md5 hash for the key and then convert in base64 string
      var md5 = crypto.createHash('md5').update(workingKey).digest();
      console.log("MD5 Key Length:", md5.length)
      var keyBase64 = Buffer.from(md5).toString('base64');
       var ivBase64 = Buffer.from([0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d,0x0e, 0x0f]).toString('base64');
      console.log("Type of encResp:", typeof encResp);
      const decrypted = decryptcc(encResp, keyBase64, ivBase64);
      let paymentData = qs.parse(decrypted); 
       const finalStatus = paymentData.order_status;
       const statusResponse=paymentData
        let customMessage = "";
    let customStatus = "";



    // Customize the response based on the payment status
    switch (statusResponse.status) {
      case "Success":
        customMessage = "Payment completed successfully.";
        customStatus = "success";
        break;
      case "PENDING":
      case "PENDING_VBV":
        customMessage = "Payment is pending. Please wait for confirmation.";
        customStatus = "pending";
        break;
      case "AUTHORIZATION_FAILED":
        customMessage = "Payment authorization failed. Please check your payment details.";
        customStatus = "failure";
        break;
      case "AUTHENTICATION_FAILED":
        customMessage = "Payment authentication failed. Please check your credentials.";
        customStatus = "failure";
        break;
      default:
        customMessage = `Payment status is ${statusResponse.status}. Please contact support for assistance.`;
        customStatus = "failure";
        break;
    }
     
    const isSuccess = finalStatus === "Success";
    const isFailure = ["AUTHORIZATION_FAILED", "AUTHENTICATION_FAILED"].includes(finalStatus);
    const meta = orderMetaMap.get(orderIdValue);
     console.log("Stored metadata for:", JSON.stringify(Array.from(orderMetaMap.entries()), null, 2));
        if (!meta) {
          console.warn("No metadata found for:", orderIdValue);
          return {success:false,message:"No metadata found for order"}
        }

        // Build shared transaction object base
        const transactionObject = {
          userId: meta.userId,
          investmentId: meta.investmentId,
          schemeId: meta.schemeId,
          chitId: meta.chitId,
          accountNumber: meta.accountNumber,
          orderId: statusResponse?.order_id,
          amount: meta.paymentAmount,
          currency: statusResponse?.currency,
          paymentMethod: statusResponse?.payment_mode,
          signature: "00",
          paymentStatus: statusResponse?.status=='CHARGED'?"Success":"Failed",
          paymentDate: new Date(),
          status:statusResponse?.status,
          gatewayTransactionId: statusResponse?.tracking_id,
          gatewayresponse: JSON.stringify(statusResponse),
          isManual: meta?.isManual,
          utr_reference_number: meta?.utr_reference_number
        };

        // If Payment is Successful
        if (isSuccess) {
          const paymentObject = {
            investmentId: meta.investmentId,
            userId: meta.userId,
            paymentAmount: meta.paymentAmount,
            paymentMethod: statusResponse?.payment_mode,
            schemeId: meta.schemeId,
            chitId: meta.chitId,
            transactionId: statusResponse?.tracking_id,
            orderId: statusResponse?.order_id,
            isManual: meta.isManual,
            utr_reference_number: meta.utr_reference_number
          };

          try {
           const paymentResult = await Payment.create(paymentObject);

            if (paymentResult.success) {
              transactionObject.paymentId = paymentResult.paymentId;

              // Call updateInvestment
              const updatePayload = {
                userId: meta.userId,
                schemeId: meta.schemeId,
                chitId: meta.chitId,
                accountName: meta.accountName,
                accountNo: meta.accountNumber,
                paymentStatus: 'PAID',
                paymentAmount: meta.paymentAmount
              };

              await investmentmodel.updateInvestmentNew(paymentObject.investmentId,updatePayload);
              console.log("transaction",transactionObject)
              await transaction.createTransaction(transactionObject);
            } else {
              console.error("Payment creation failed:", paymentResult.message);
            }
          } catch (error) {
            console.error("Error during successful payment flow:", error);
          }

        } else {
          // Payment Failed → Only log transaction with paymentId = 0
          transactionObject.paymentId = 0;
          try {
            await transaction.createTransaction(transactionObject);
          } catch (error) {
            console.error("Transaction creation failed on failure flow:", error);
          }
        }

        console.log("completed ")
    // Emit payment status update event to frontend via WebSocket (if available)
    if (eventEmitter) {
      eventEmitter.emit("payment_status_update", {
        orderId: orderIdValue,
        status: customStatus,
        message: customMessage,
        paymentResponse: statusResponse,
      });
    }
      // You could also persist this in DB here
      return {
        success: true,
        paymentData,
        isSuccess: paymentData.order_status === 'Success',
      };
    } catch (error) {
      console.error("Decryption failed:", error);
      return {
        success: false,
        message: "Failed to decrypt CCAvenue response",
        error,
      };
    }
  },



  

  // Retrieve all payment records ordered by creation date (descending)
  getAll: async () => {
    const sql = "SELECT * FROM payments ORDER BY created_at DESC";
    const [results] = await db.query(sql);
    return results;
  },

  // Retrieve a single payment record by id
  getById: async (id) => {
    const sql = "SELECT * FROM payments WHERE id = ?";
    const [results] = await db.query(sql, [id]);
    if (results.length === 0) return null;
    return results[0];
  },

  // Retrieve payments for a specific user
  getByUserId: async (userId) => {
    const sql =
      "SELECT * FROM payments WHERE user_id = ? ORDER BY payment_date DESC";
    const [results] = await db.query(sql, [userId]);
    return results;
  },

  // Update a payment record by id
  update: async (id, paymentData) => {
    const data = {
      user_id: paymentData.user_id,
      investment_id: paymentData.investment_id || null,
      amount: paymentData.amount,
      payment_date: paymentData.payment_date,
      payment_method: paymentData.payment_method,
      transaction_id: paymentData.transaction_id || null,
      payment_status: paymentData.payment_status,
    };

    const sql = "UPDATE payments SET ? WHERE id = ?";
    const [result] = await db.query(sql, [data, id]);
    return result;
  },

  // Delete a payment record by id
  delete: async (id) => {
    const sql = "DELETE FROM payments WHERE id = ?";
    const [result] = await db.query(sql, [id]);
    return result;
  },

  getRecentPaymentsByUser: async (userId, limit = 5) => {
    const connection = await db.getConnection();
    try {
      const [rows] = await connection.query(
        `SELECT 
          id,
          amount,
          payment_status as status,
          created_at,
          transaction_id
        FROM payments 
        WHERE user_id = ? 
        ORDER BY created_at DESC 
        LIMIT ?`,
        [userId, limit]
      );
      return rows;
    } catch (error) {
      logger.error('Error getting recent payments:', error);
      throw error;
    } finally {
      connection.release();
    }
  },

  // Get payments by user ID with filters and pagination
  getByUserIdWithFilters: async (userId, filters = {}) => {
    const connection = await db.getConnection();
    try {
      let sql = `
        SELECT 
          p.*,
          s.SCHEMENAME as schemeName,
          s.type as schemeType,
          s.SCHEMENAME as schemeDisplayName
        FROM payments p
        LEFT JOIN investments i ON p.investment_id = i.id
        LEFT JOIN schemes s ON i.schemeId = s.id
        WHERE p.user_id = ?
      `;
      
      const params = [userId];
      
      // Add filters
      if (filters.status) {
        sql += ` AND p.payment_status = ?`;
        params.push(filters.status);
      }
      
      if (filters.paymentMethod) {
        sql += ` AND p.payment_method = ?`;
        params.push(filters.paymentMethod);
      }
      
      if (filters.schemeId) {
        sql += ` AND i.schemeId = ?`;
        params.push(filters.schemeId);
      }
      
      if (filters.investmentId) {
        sql += ` AND p.investment_id = ?`;
        params.push(filters.investmentId);
      }
      
      if (filters.startDate) {
        sql += ` AND DATE(p.payment_date) >= ?`;
        params.push(filters.startDate);
      }
      
      if (filters.endDate) {
        sql += ` AND DATE(p.payment_date) <= ?`;
        params.push(filters.endDate);
      }
      
      if (filters.minAmount) {
        sql += ` AND p.amount >= ?`;
        params.push(parseFloat(filters.minAmount));
      }
      
      if (filters.maxAmount) {
        sql += ` AND p.amount <= ?`;
        params.push(parseFloat(filters.maxAmount));
      }
      
      // Add sorting
      const validSortColumns = ['created_at', 'payment_date', 'amount', 'payment_status', 'monthNumber'];
      const sortBy = validSortColumns.includes(filters.sortBy) ? filters.sortBy : 'created_at';
      const sortOrder = filters.sortOrder === 'ASC' ? 'ASC' : 'DESC';
      
      sql += ` ORDER BY p.${sortBy} ${sortOrder}`;
      
      // Add pagination
      if (filters.limit) {
        sql += ` LIMIT ?`;
        params.push(filters.limit);
        
        if (filters.offset) {
          sql += ` OFFSET ?`;
          params.push(filters.offset);
        }
      }
      
      const [rows] = await connection.query(sql, params);
      return rows;
    } catch (error) {
      logger.error('Error getting payments with filters:', error);
      throw error;
    } finally {
      connection.release();
    }
  },

  // Get count of payments by user ID with filters (for pagination)
  getCountByUserIdWithFilters: async (userId, filters = {}) => {
    const connection = await db.getConnection();
    try {
      let sql = `
        SELECT COUNT(*) as total
        FROM payments p
        LEFT JOIN investments i ON p.investment_id = i.id
        LEFT JOIN schemes s ON i.schemeId = s.id
        WHERE p.user_id = ?
      `;
      
      const params = [userId];
      
      // Add same filters as in getByUserIdWithFilters (excluding pagination)
      if (filters.status) {
        sql += ` AND p.payment_status = ?`;
        params.push(filters.status);
      }
      
      if (filters.paymentMethod) {
        sql += ` AND p.payment_method = ?`;
        params.push(filters.paymentMethod);
      }
      
      if (filters.schemeId) {
        sql += ` AND i.schemeId = ?`;
        params.push(filters.schemeId);
      }
      
      if (filters.investmentId) {
        sql += ` AND p.investment_id = ?`;
        params.push(filters.investmentId);
      }
      
      if (filters.startDate) {
        sql += ` AND DATE(p.payment_date) >= ?`;
        params.push(filters.startDate);
      }
      
      if (filters.endDate) {
        sql += ` AND DATE(p.payment_date) <= ?`;
        params.push(filters.endDate);
      }
      
      if (filters.minAmount) {
        sql += ` AND p.amount >= ?`;
        params.push(parseFloat(filters.minAmount));
      }
      
      if (filters.maxAmount) {
        sql += ` AND p.amount <= ?`;
        params.push(parseFloat(filters.maxAmount));
      }
      
      const [rows] = await connection.query(sql, params);
      return rows[0].total;
    } catch (error) {
      logger.error('Error getting payment count with filters:', error);
      throw error;
    } finally {
      connection.release();
    }
  }
};
function generateManualPaymentIds(userId,investment_id) {
  const timestamp = Date.now(); // current UTC time in milliseconds
  const randomUuid = uuidv4().split('-')[0]; // short unique string
  const prefix = 'DC_MANUAL';

  const transactionId = `${prefix}_TXN_${userId}_${investment_id}_${timestamp}_${randomUuid}`;
  const orderId = `${prefix}_ORD_${userId}_${investment_id}_${timestamp}`;

  return { transactionId, orderId };
}

module.exports = Payment;
