// controllers/investment.controller.js
const investmentModel = require("../models/investmentModel");
const Rate = require("../models/rateModel");
const logger = require("../middlewares/logger");
const fs = require("fs");
const fastCsv = require("fast-csv");
const pool = require("../config/db");

// Create a new investment
exports.createInvestment = async (req, res) => {
  console.log("createInvestment");
  try {
    const { schemeId } = req.body;

    if (!schemeId) {
      return res.status(400).json({
        success: false,
        message: "Scheme ID is required",
      });
    }

    // Step 1: Fetch schemeType and frequency from DB
    

    

    // Step 2: Generate sequential accountNo starting from 101 if not provided
    if (!req.body.accountNo) {
      const maxAccountNo = await investmentModel.getMaxAccountNo();
      req.body.accountNo = maxAccountNo
        ? (parseInt(maxAccountNo) + 1).toString()
        : "101";
    }

    // Step 3: Set joiningDate to today if not provided
    if (!req.body.joiningDate) {
      req.body.joiningDate = new Date().toISOString().split("T")[0];
    }

    // Step 4: Auto-set default paymentStatus
    req.body.paymentStatus = "pending";

    // Step 5: Populate gold/silver rate if missing
    if (!req.body.goldRate || !req.body.silverRate) {
      const rate = await Rate.getCurrent();
      req.body.goldRate = Number(rate.gold_rate);
      req.body.silverRate = Number(rate.silver_rate);
    }

    // Step 6: Create investment
    const result = await investmentModel.createInvestment(req.body);

    // Step 7: Return success with scheme info included
    res.status(201).json({
      success: true,
      data: {
        id: result.investmentId,
        schemeType:result.schemeType,
        paymentFrequency:result.paymentFrequency,
        ...req.body
      },
      message: "Investment created successfully",
    });

  } catch (error) {
    logger.error("Create Investment Error:", error);
    res.status(500).json({
      success: false,
      message: error.message || "Server error",
    });
  }
};

//export investments
exports.exportInvestments = async (req, res) => {
  try {
    const { userId=req.user.id, startDate, endDate, schemeId, chitId } = req.query;
    console.log("Exporting investments for user:", userId, "Filters:", { startDate, endDate, schemeId, chitId });

    // Fetch filtered investments from the model
    const investments = await investmentModel.getFilteredInvestments(userId, startDate, endDate, schemeId, chitId);

    if (investments.length === 0) {
      return res.status(404).json({ success: false, message: "No investments found for given filters" });
    }

    const filePath = `exports/investments_${userId}_${Date.now()}.csv`;
    const writableStream = fs.createWriteStream(filePath);

    fastCsv
      .write(investments, { headers: true })
      .pipe(writableStream)
      .on("finish", () => {
        res.download(filePath, "investments.csv", (err) => {
          if (err) {
            console.error("Download error:", err);
            res.status(500).json({ success: false, message: "Error downloading file" });
          }
          // Optionally delete file after download
          fs.unlinkSync(filePath);
        });
      });

  } catch (error) {
    console.error("Export Error:", error);
    res.status(500).json({ success: false, message: "Server error" });
  }
};
// Get all investments
exports.getAllInvestments = async (req, res) => {
  try {
    logger.info('Fetching all investments');
    const investments = await investmentModel.getAllInvestments();
    
    res.status(200).json({
      success: true,
      data: investments,
      message: investments.length > 0 
        ? "Investments retrieved successfully" 
        : "No investments found",
      count: investments.length
    });
  } catch (error) {
    logger.error('Error in getAllInvestments:', error);
    res.status(500).json({
      success: false,
      message: error.message || "Error retrieving investments",
      error: process.env.NODE_ENV === 'development' ? error.message : undefined
    });
  }
};

// Get a single investment by ID
exports.getInvestmentById = async (req, res) => {
  try {
    console.log("Fetching investment by ID:", req.params.id);
    const result = await investmentModel.getInvestmentById(req.params.id);
    console.log("DB Response:", result);

    if (Array.isArray(result)) {
      res.status(200).json({
        success: true,
        data: Array.isArray(result) ? result[0] : result,
        message: "Investment retrieved successfully",
      });
    } else {
      res.status(200).json({
        success: false,
        data: [],
        message: "Investment not found",
      });
    }
  } catch (error) {
    console.error("Error fetching investment:", error);
    res.status(500).json({
      success: false,
      message: "Internal server error",
    });
  }
};

// Update an investment
exports.deactivateupdateInvestment = async (req, res) => {
  try {
    const { id } = req.params;
    console.log(`Deactivating investment ID: ${id}`);

    // Call the model function to update investment status
    const result = await investmentModel.deactiveupdateInvestment(id, req.body);
    console.log("Update Result:", result);

    // Check if the update was successful or if an error occurred
    if (!result || result.error) {
      return res.status(404).json({
        success: false,
        message: result?.message || "Investment not found or update failed",
      });
    }

    res.status(200).json({
      success: true,
      data: { id, ...req.body },
      message: "Investment updated successfully",
    });
  } catch (error) {
    console.error("Error in deactivateupdateInvestment:", error);
    res.status(500).json({
      success: false,
      message: "Internal server error",
    });
  }
};
exports.checkPayment = async (req, res) => {
  try {
    const { userId=req.user.id, investmentId,amount } = req.body;
console.log("working",req.body)
    // Call the function to check if payment exists
    const hasPaid = await investmentModel.payNowNew(userId, investmentId,amount);
console.log("data from model",hasPaid)
    if (!hasPaid.success) {
      return res.status(200).json(hasPaid);
    }
    else
    {
      res.status(200).json(hasPaid);
    }


    

  } catch (err) {
    console.log('error',err)
    res.status(500).json({ error: err || err.message });
  }
};

// Update an investment
exports.updateInvestment = async (req, res) => {
  try {
    const { id } = req.params;
    console.log(`Updating investment with ID: ${id}`);
console.log('error',id)
    // Ensure that the body contains all the necessary fields for updating the investment
    const requiredFields = [
      "chitId",
      "schemeId",
      "accountName",
      "accountNo",
      "paymentStatus",
      "paymentAmount",
    ];
    for (const field of requiredFields) {
      if (!req.body[field]) {
        return res.status(400).json({
          success: false,
          message: `Missing required field: ${field}`,
        });
      }
    }
    // req.body.userId=req.user.id
    console.log('this function',id, req.body)
    // Call the model function to update the investment
    const result = await investmentModel.updateInvestmentNew(id, req.body);
    console.log("Update Result:", result);

    // Check if the update was successful or if an error occurred
    if (!result || result.error) {
      return res.status(404).json({
        success: false,
        message: result?.message || "Investment not found or update failed",
      });
    }

    // Respond with success if the update was successful
    return res.status(200).json({
      success: true,
      data: { id, ...req.body },
      message: "Investment updated successfully",
    });
  } catch (error) {
    console.error("Error in updateInvestment:", error);
    return res.status(500).json({
      success: false,
      message: "Internal server error",
    });
  }
};

// Delete an investment
exports.deleteInvestment = async (req, res) => {
  try {
    const result = await investmentModel.deleteInvestment(req.params.id);
    if (result.affectedRows === 0) {
      return res.status(404).json({
        success: false,
        message: "Investment not found",
      });
    }
    res.status(200).json({
      success: true,
      message: "Investment deleted successfully",
    });
  } catch (error) {
    logger.error("Delete Investment Error:", error);
    res.status(500).json({
      success: false,
      message: "Server error",
    });
  }
};

// Get investments by user ID
exports.getInvestmentsByUser = async (req, res) => {
  try {
    const userId = req.params.userId || req.user?.id;
    
    if (!userId) {
      return res.status(400).json({
        success: false,
        message: "User ID is required"
      });
    }

    logger.info(`Fetching investments for user ID: ${userId}`);
    
    const investments = await investmentModel.getInvestmentsByUser(userId);
    
    if (!investments || investments.error) {
      return res.status(200).json({
        success: true,
        message: "No investments found for this user",
        investments: []
      });
    }

    res.status(200).json({
      success: true,
      data: investments,
      message: "Investments retrieved successfully",
      count: investments.length
    });
  } catch (error) {
    logger.error("Error in getInvestmentsByUser:", error);
    res.status(500).json({
      success: false,
      message: error.message || "Error retrieving user investments"
    });
  }
};

// Get detailed user investment information
exports.getUserInvestmentDetails = async (req, res) => {
  try {
    const userId = req.params.userId || req.user?.id;
    
    if (!userId) {
      return res.status(400).json({
        success: false,
        message: "User ID is required"
      });
    }

    logger.info(`Fetching detailed investment information for user ID: ${userId}`);

    // Get all investments for the user
    const [investments] = await pool.execute(
      "SELECT * FROM investments WHERE userId = ? AND status = 'ACTIVE'",
      [userId]
    );

    // If no investments found, return empty arrays with totals set to 0
    if (investments.length === 0) {
      return res.status(200).json({
        success: true,
        data: {
          userId,
          accountNumbers: [],
          investments: [],
          chitDetails: [],
          schemeDetails: [],
          payments: [],
          totalSavingAmount: 0,
          totalSavingGold: 0,
          totalSavingSilver: 0,
        },
        message: "No investments found for this user"
      });
    }

    // Extract unique chitId and schemeId values from investments
    const chitIds = [...new Set(investments.map((inv) => inv.chitId))];
    const schemeIds = [...new Set(investments.map((inv) => inv.schemeId))];

    // Retrieve chit details from the chits table
    let chitDetails = [];
    if (chitIds.length > 0) {
      const [chitRows] = await pool.execute(
        `SELECT * FROM chits WHERE id IN (${chitIds.join(",")}) AND ACTIVE = 'Y'`
      );
      chitDetails = chitRows;
    }

    // Retrieve scheme details from the schemes table
    let schemeDetails = [];
    if (schemeIds.length > 0) {
      const [schemeRows] = await pool.execute(
        `SELECT * FROM schemes WHERE id IN (${schemeIds.join(",")}) AND ACTIVE = 'Y'`
      );
      schemeDetails = schemeRows;
    }

    // Retrieve payments for the user from the payments table
    const [payments] = await pool.execute(
      "SELECT * FROM payments WHERE user_id = ? AND payment_status = 'success'",
      [userId]
    );

    // Calculate totals
    const totalSavingAmount = payments.reduce(
      (sum, p) => sum + parseFloat(p.amount || 0),
      0
    );
    const totalSavingGold = investments.reduce(
      (sum, inv) => sum + parseFloat(inv.totalgoldweight || 0),
      0
    );
    const totalSavingSilver = investments.reduce(
      (sum, inv) => sum + parseFloat(inv.totalsilverweight || 0),
      0
    );

    // Gather account numbers from investments
    const accountNumbers = investments.map((inv) => inv.accountNo);

    // Assemble the response data
    const responseData = {
      userId,
      accountNumbers,
      investments,
      chitDetails,
      schemeDetails,
      payments,
      totalSavingAmount,
      totalSavingGold,
      totalSavingSilver,
    };

    res.status(200).json({
      success: true,
      data: responseData,
      message: "User investment details retrieved successfully"
    });
  } catch (error) {
    logger.error("Error in getUserInvestmentDetails:", error);
    res.status(500).json({
      success: false,
      message: error.message || "Error retrieving user investment details"
    });
  }
};
