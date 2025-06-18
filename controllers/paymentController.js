const Payment = require("../models/paymentModel");
const {
  createPaymentSession,
  checkPaymentStatus,
  handlePayResponse,
} = require("../utils/juspayService");
const fs = require("fs");
const crypto = require("crypto");
const path = require("path");
const paymentModel=require('../models/paymentModel')
// Load Public and Private Keys with error handling
let privateKey, publicKey;
try {
  const PRIVATE_KEY_PATH = process.env.PRIVATE_KEY_PATH || path.join(__dirname, "privateKey.pem");
  const PUBLIC_KEY_PATH = process.env.PUBLIC_KEY_PATH || path.join(__dirname, "key_2bd2dcf3a2ec497384e8d4724e2f33be.pem");
  
  if (fs.existsSync(PRIVATE_KEY_PATH)) {
    privateKey = fs.readFileSync(PRIVATE_KEY_PATH, "utf8");
  } else {
    console.warn("Private key file not found:", PRIVATE_KEY_PATH);
    privateKey = "dummy-private-key"; // Fallback for development
  }
  
  if (fs.existsSync(PUBLIC_KEY_PATH)) {
    publicKey = fs.readFileSync(PUBLIC_KEY_PATH, "utf8");
  } else {
    console.warn("Public key file not found:", PUBLIC_KEY_PATH);
    publicKey = "dummy-public-key"; // Fallback for development
  }
} catch (error) {
  console.error("Error loading keys:", error);
  privateKey = "dummy-private-key";
  publicKey = "dummy-public-key";
}

const SIGNING_METHOD = "RSA"; // Change to "HMAC" if needed
const SECRET_KEY = process.env.SECRET_KEY || "your-secure-hmac-secret-key"; // Use only for HMAC
// Your HDFC SmartWay Response Key (Get this from HDFC Dashboard)
const RESPONSE_KEY = process.env.RESPONSE_KEY || "dummy-response-key"; // Securely store this key

// WebSocket server instance
let eventEmitter;
try {
  eventEmitter = require("../index").eventEmitter;
} catch (error) {
  console.warn("EventEmitter not available:", error.message);
  eventEmitter = null;
}

/**
 * Function to verify Juspay response signature using HMAC-SHA256
 */
function verifyJuspaySignature(responseData, receivedSignature) {
  try {
    // Remove 'signature' from responseData to compute the signature correctly
    console.log("RESPONSE_KEY", RESPONSE_KEY);
    const dataToSign = { ...responseData };
    delete dataToSign.signature;

    // Sort the keys in ascending order
    const sortedKeys = Object.keys(dataToSign).sort();

    // Create a concatenated string of values in sorted order
    const dataString = sortedKeys.map((key) => dataToSign[key]).join("|");

    // Generate HMAC-SHA256 signature using the Response Key
    const hmac = crypto.createHmac("sha256", RESPONSE_KEY);
    hmac.update(dataString);
    const expectedSignature = hmac.digest("base64"); // Juspay provides Base64-encoded signatures
    console.log('expected', expectedSignature, receivedSignature);
    return expectedSignature === receivedSignature; // Return true if valid, false otherwise
  } catch (error) {
    console.error("Error verifying signature:", error);
    return false;
  }
}

function verify_hmac(params, secret) {
  try {
    console.log("params", params);
    var paramsList = [];
    for (var key in params) {
      if (key != 'signature' && key != 'signature_algorithm') {
        paramsList[key] = params[key];
      }
    }

    paramsList = sortObjectByKeys(paramsList);

    var paramsString = '';
    for (var key in paramsList) {
      paramsString = paramsString + key + '=' + paramsList[key] + '&';
    }

    let encodedParams = encodeURIComponent(paramsString.substring(0, paramsString.length - 1));
    let computedHmac = crypto.createHmac('sha256', secret).update(encodedParams).digest('base64');
    let receivedHmac = decodeURIComponent(params.signature);

    console.log("computedHmac :", computedHmac);
    console.log("receivedHmac :", receivedHmac);
    const buffer1 = Buffer.from(decodeURIComponent(computedHmac), 'base64');
    const buffer2 = Buffer.from(receivedHmac, 'base64');
    return crypto.timingSafeEqual(buffer1, buffer2);
  } catch (error) {
    console.error("Error in HMAC verification:", error);
    return false;
  }
}

function sortObjectByKeys(o) {
  return Object.keys(o)
    .sort()
    .reduce((r, k) => ((r[k] = o[k]), r), {});
}

exports.createPayment = async (req, res) => {
  try {
    // Handle case where req.user might not exist (auth disabled)
    if (req.user && req.user.id) {
      req.body.userId = req.user.id;
    }
    
    const result = await Payment.create(req.body);
    if (result.success) {
      res.status(201).json({
        message: "Payment created successfully",
        data: result,
        status: 200,
      });
    } else {
      res.status(500).json({
        message: "Error in payment processing",
        data: result,
      });
    }
  } catch (err) {
    console.error("Error creating payment:", err);
    res.status(500).json({ 
      success: false,
      error: err.sqlMessage || err.message || "Internal server error" 
    });
  }
};
exports.ccinitiatePayment= async (req, res) => {
    try {
      const result = await paymentModel.akila_initiatePayment(req.body);

      if (typeof result === 'object' && result.success === false) {
        return res.status(400).json(result); // validation failure
      }

      // Success - send auto-submitting HTML form
      return res.status(200).type('html').send(result);
    } catch (error) {
      console.error("Error initiating payment:", error);
      return res.status(500).json({ success: false, message: "Internal Server Error" });
    }
  }
 exports.ccavenueresponse=async (req, res) => {
    try {
      const { encResp } = req.body;
      console.log("encResp",encResp,'request',JSON.stringify(req.body))
      const result = paymentModel.handleCCAvenueResponse(encResp);

      if (!result.success) {
        return res.status(500).json({ success: false, message: result.message });
      }

      const { paymentData, isSuccess } = result;

      if (isSuccess) {
        // You may update DB here if not already in model
        return res.status(200).json({ success: true, message: 'Payment Successful', paymentData });
      } else {
        return res.status(400).json({ success: false, message: 'Payment Failed or Cancelled', paymentData });
      }
    } catch (error) {
      console.error("Error in CCAvenue response handler:", error);
      return res.status(500).json({ success: false, message: 'Internal Server Error' });
    }
  }


/**
 * Generate a secure digital signature using RSA or HMAC
 */
function signRequest(data) {
  try {
    // Add security measures: Timestamp & Nonce to prevent replay attacks
    data.timestamp = Date.now();
    data.nonce = crypto.randomBytes(16).toString("hex");

    // Canonical JSON sorting to ensure consistent signing
    const jsonString = JSON.stringify(data, Object.keys(data).sort());

    if (SIGNING_METHOD === "RSA") {
      const sign = crypto.createSign("SHA256");
      sign.update(jsonString);
      sign.end();
      return sign.sign(privateKey, "base64");
    } else if (SIGNING_METHOD === "HMAC") {
      return crypto.createHmac("sha256", SECRET_KEY).update(jsonString).digest("hex");
    }
    throw new Error("Invalid signing method");
  } catch (error) {
    console.error("Error signing request:", error);
    return "dummy-signature"; // Fallback for development
  }
}

/**
 * Initiate Payment
 */
exports.initiatePayment = async (req, res) => {
  try {
    console.log('responsekey', RESPONSE_KEY);
    
    // Handle userId safely
    const userId = req.body.userId || (req.user && req.user.id) || 'guest';
    console.log("userId", userId);
    
    const investmentId = req.body.investmentId;
    const schemeId = req.body.schemeId;
    const userName = req.body.userName;
    const userEmail = req.body.userEmail;
    const userMobile = req.body.userMobile;
    
    console.log("userids", userId);
    const orderId = `order_${userId.toString()}_${investmentId}_${Date.now()}`;
    console.log('orderId', orderId);
    const amount = req.body.amount;
    
    // Build return URL safely
    const protocol = req.protocol || 'http';
    const host = req.get("host") || 'localhost:3001';
    const returnUrl = `${protocol}://${host}/payments/status`;

    const requestData = {
      orderId,
      amount: req.body.amount,
      returnUrl,
      userId: userId.toString(),
      investmentId: req.body.investmentId,
      schemeId: req.body.schemeId,
      userName: req.body.userName,
      userEmail: req.body.userEmail,
      userMobile: req.body.userMobile,
    };

    // Generate digital signature
    const signature = signRequest(requestData);

    // Define signature algorithm
    const signatureAlgo = {
      signature_algorithm: SIGNING_METHOD === "RSA" ? "RSA-SHA256" : "HMAC-SHA256",
    };
    
    // Create a payment session with Juspay
    const session = await createPaymentSession(
      orderId,
      amount,
      returnUrl,
      userId.toString(),
      investmentId,
      schemeId,
      userName,
      userEmail,
      userMobile,
      signature
    );

    // Store payment details in the database
    await Payment.create({ orderId, amount, status: "PENDING" });

    res.json({ success: true, session });
  } catch (error) {
    console.error("Error initiating payment:", error);
    res.status(500).json({ 
      success: false, 
      error: error.message || "Internal server error" 
    });
  }
};

// Function to Sign Response for Frontend
const signResponse = (data) => {
  try {
    const signer = crypto.createSign("RSA-SHA256");
    signer.update(JSON.stringify(data));
    return signer.sign(privateKey, "base64");
  } catch (error) {
    console.error("Error signing response:", error);
    return "dummy-signature";
  }
};

/**
 * Handle Payment Response
 */
exports.handlePaymentStatus = async (req, res) => {
  try {
    console.log("request", req.body);
    const orderId = req.body.order_id || req.body.orderId;
    if (!orderId)
      return res
        .status(400)
        .json({ success: false, error: "order_id is required" });

    // Fetch payment status from Juspay
    const statusResponse = await checkPaymentStatus(orderId);
    const status = statusResponse.status;

    // Show success or failure view
    if (status === "CHARGED") {
      return res.render("paymentSuccess", { orderId });
    } else {
      return res.render("paymentFailure", { orderId });
    }
  } catch (error) {
    console.error("Error handling payment status:", error);
    res.status(500).json({ 
      success: false, 
      error: error.message || "Internal server error" 
    });
  }
};

exports.handleJuspayResponse = async (req, res) => {
  try {
    const { order_id, signature } = req.body;
    const orderIdValue = order_id;
    const requestBodyString = JSON.stringify(req.body);
    
    // Validate orderId
    if (!orderIdValue) {
      return res.status(400).json(makeError("order_id is required"));
    }

    if (!verify_hmac(req.body, RESPONSE_KEY)) {
      return res.status(400).json({ 
        success: false, 
        message: "Invalid response signature. Possible response tampering detected!" 
      });
    }
    
    // Call the service to check the payment status
    const { statusResponse, message } = await handlePayResponse(orderIdValue);

    // Log the status response for debugging
    console.log("Juspay Status Response:", statusResponse);
    
    // If status is PENDING, wait and recheck
    if (["PENDING", "PENDING_VBV"].includes(statusResponse.status)) {
      console.log("Waiting for final verification...");
      await new Promise((resolve) => setTimeout(resolve, 5000)); // Wait 5 sec

      // Second Inquiry: Final Verification
      const secondResponse = await handlePayResponse(orderIdValue);
      console.log("Second Inquiry Response:", secondResponse);
    }
    
    let customMessage = "";
    let customStatus = "";

    // Customize the response based on the payment status
    switch (statusResponse.status) {
      case "CHARGED":
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

    // Emit payment status update event to frontend via WebSocket (if available)
    if (eventEmitter) {
      eventEmitter.emit("payment_status_update", {
        orderId: orderIdValue,
        status: customStatus,
        message: customMessage,
        paymentResponse: statusResponse,
      });
    }

    return res.json(makeJuspayResponse({
      success: customStatus === 'success',
      message: customMessage,
      statusResponse,
    }));
  } catch (error) {
    console.error("Error processing Juspay response:", error);
    return res.status(500).json(makeError("An error occurred while processing the payment status"));
  }
};

exports.getAllPayments = async (req, res) => {
  try {
    const payments = await Payment.getAll();
    res.status(200).json({ data: payments, status: 200 });
  } catch (err) {
    console.error("Error getting all payments:", err);
    res.status(500).json({ 
      success: false,
      error: err.sqlMessage || err.message || "Internal server error" 
    });
  }
};

exports.getPaymentById = async (req, res) => {
  try {
    const id = req.params.id;
    const payment = await Payment.getById(id);
    if (!payment) {
      return res.status(404).json({ 
        success: false,
        message: "Payment not found", 
        status: 404 
      });
    }
    res.status(200).json({ data: payment, status: 200 });
  } catch (err) {
    console.error("Error getting payment by ID:", err);
    res.status(500).json({ 
      success: false,
      error: err.sqlMessage || err.message || "Internal server error" 
    });
  }
};

exports.getPaymentsByUser = async (req, res) => {
  try {
    // Get userId from multiple sources: query params, route params, or authenticated user
    const userId = req.query.userId || req.params.user_id || (req.user && req.user.id);
    
    if (!userId) {
      return res.status(400).json({
        success: false,
        message: "User ID is required. Please provide userId in query parameters."
      });
    }

    // Extract filter parameters from query
    const filters = {
      status: req.query.status, // e.g., 'PENDING', 'CHARGED', 'FAILED'
      paymentMethod: req.query.paymentMethod, // e.g., 'UPI', 'NetBanking', 'CreditCard'
      schemeId: req.query.schemeId,
      investmentId: req.query.investmentId,
      startDate: req.query.startDate, // Format: YYYY-MM-DD
      endDate: req.query.endDate, // Format: YYYY-MM-DD
      minAmount: req.query.minAmount,
      maxAmount: req.query.maxAmount,
      limit: parseInt(req.query.limit) || 50, // Default limit of 50
      offset: parseInt(req.query.offset) || 0, // Default offset of 0
      sortBy: req.query.sortBy || 'created_at', // Default sort by created_at
      sortOrder: req.query.sortOrder || 'DESC' // Default descending order
    };

    // Remove undefined/null filters
    Object.keys(filters).forEach(key => {
      if (filters[key] === undefined || filters[key] === null || filters[key] === '') {
        delete filters[key];
      }
    });

    console.log('Fetching payments for userId:', userId, 'with filters:', filters);
    
    const payments = await Payment.getByUserIdWithFilters(userId, filters);
    
    // Get total count for pagination
    const totalCount = await Payment.getCountByUserIdWithFilters(userId, filters);
    
    res.status(200).json({ 
      success: true,
      data: payments, 
      pagination: {
        total: totalCount,
        limit: filters.limit,
        offset: filters.offset,
        hasMore: (filters.offset + filters.limit) < totalCount
      },
      filters: filters,
      status: 200 
    });
  } catch (err) {
    console.error("Error getting payments by user:", err);
    res.status(500).json({ 
      success: false,
      error: err.sqlMessage || err.message || "Internal server error" 
    });
  }
};

exports.updatePayment = async (req, res) => {
  try {
    const id = req.params.id;
    const result = await Payment.update(id, req.body);
    res.status(200).json({
      message: "Payment updated successfully",
      data: result,
      status: 200,
    });
  } catch (err) {
    console.error("Error updating payment:", err);
    res.status(500).json({ 
      success: false,
      error: err.sqlMessage || err.message || "Internal server error" 
    });
  }
};

exports.deletePayment = async (req, res) => {
  try {
    const id = req.params.id;
    const result = await Payment.delete(id);
    res.status(200).json({
      message: "Payment deleted successfully",
      data: result,
      status: 200,
    });
  } catch (err) {
    console.error("Error deleting payment:", err);
    res.status(500).json({ 
      success: false,
      error: err.sqlMessage || err.message || "Internal server error" 
    });
  }
};

const makeError = (message = "Something went wrong") => {
  return {
    success: false,
    message: message,
  };
};

// Helper to format Juspay API responses
function makeJuspayResponse(successRspFromJuspay) {
  if (successRspFromJuspay == undefined) return successRspFromJuspay;
  if (successRspFromJuspay.http != undefined) delete successRspFromJuspay.http;
  return successRspFromJuspay;
}
