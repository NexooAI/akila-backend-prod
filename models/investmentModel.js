// models/investment.model.js
const pool = require("../config/db");
const logger=require('../middlewares/logger')
const dayjs = require('dayjs');
const utc = require('dayjs/plugin/utc');
dayjs.extend(utc);
exports.getMaxAccountNo = async () => {
  const sql =
    "SELECT MAX(CAST(accountNo AS UNSIGNED)) as maxAccountNo FROM investments";
  const [rows] = await pool.execute(sql);
  return rows[0].maxAccountNo;
};

exports.createInvestment = async (investmentData) => {
  const {
    userId,
    chitId,
    schemeId,
    accountName,
    accountNo,
    startDate,
    endDate,
    joiningDate,
    paymentStatus,
    goldRate,
    silverRate,
    status,
    descripation,
    associated_branch,
    payment_frequency_id,
    firstMonthAmount

  } = investmentData;

  // **Step 1: Mandatory Fields Validation**
  if (
    !userId ||
    !chitId ||
    !schemeId ||
    !accountName ||
    !accountNo ||
    !joiningDate ||
    !paymentStatus||
    !payment_frequency_id// Fixed schemes require a first-month investment
  ) {
    throw new Error("All required fields must be provided.");
  }

  // **Step 2: Data Type Validation**
  if (
    typeof userId !== "number" ||
    typeof chitId !== "number" ||
    typeof schemeId !== "number"
  ) {
    throw new Error(
      "Invalid data types: userId, chitId, and schemeId must be numbers."
    );
  }

  if (typeof accountName !== "string" || typeof accountNo !== "string") {
    throw new Error(
      "Invalid data types: accountName and accountNo must be strings."
    );
  }

  // **Step 3: Date Validation**
  const join = new Date(joiningDate);

  // **Step 4: Payment Status Validation**
  const validPaymentStatuses = ["paid", "pending", "completed", "failed"];
  if (!validPaymentStatuses.includes(paymentStatus.toLowerCase())) {
    throw new Error(
      "Invalid payment status: Allowed values are paid, pending, completed, failed."
    );
  }

  // **Step 5: Fetch scheme type and frequency**
  const [schemeResult] = await pool.execute(
    `SELECT 
      s.scheme_plan_type_id  AS typeId, st.name AS type
    
     FROM schemes s
     JOIN scheme_plan_types st ON s.scheme_plan_type_id  = st.id
     
     WHERE s.id = ? AND s.ACTIVE = 'Y'`,
    [schemeId]
  );

  if (!schemeResult || schemeResult.length === 0) {
    throw new Error("Scheme not found or inactive.");
  }

  const schemeType = schemeResult[0].type?.toLowerCase();        // e.g., "flexi"
 
  // You can now use schemeType and paymentFrequency for custom validation or logic
  console.log(`Scheme Type: ${schemeType}`);

  // **Step 6: Get Active Rate ID**
  const [rateId] = await pool.execute(
    "SELECT id as rateId FROM rates WHERE status='active' ORDER BY id DESC LIMIT 1"
  );

  // **Step 7: Chit Continuation Handling**
  let previousInvestmentId = null;
  let accumulatedGoldWeight = 0;
  let totalPaid = 0;

  const [lastInvestment] = await pool.execute(
    "SELECT id, totalgoldweight as totalGoldAccumulated, paymentStatus FROM investments WHERE userId = ? AND chitId = ? ORDER BY end_date DESC LIMIT 1",
    [userId, chitId]
  );

  if (
    lastInvestment.length > 0 &&
    lastInvestment[0].paymentStatus === "completed"
  ) {
    previousInvestmentId = lastInvestment[0].id;
    // accumulatedGoldWeight = parseFloat(lastInvestment[0].totalGoldAccumulated); // if needed
  }

  // **Step 8: Insert Investment**
  const sql = `INSERT INTO investments (
    userId, chitId, schemeId, accountName, accountNo, joiningDate,
    paymentStatus, totalGoldWeight, previousInvestmentId, total_paid, associated_branch,payment_frequency_id
  ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)`;

  const values = [
    userId,
    chitId,
    schemeId,
    accountName,
    accountNo,
    joiningDate,
    paymentStatus.toLowerCase(),
    accumulatedGoldWeight ? parseFloat(accumulatedGoldWeight) : 0,
    previousInvestmentId !== undefined ? previousInvestmentId : null,
    totalPaid ? parseFloat(totalPaid) : 0,
    associated_branch || 0,
    payment_frequency_id
  ];

  try {
    const [result] = await pool.execute(sql, values);
    console.log("Investment inserted successfully", result.insertId);
    return {
      success: true,
      investmentId: result.insertId,
      schemeType
    };
  } catch (error) {
    logger.error(error)
    console.error("Error inserting investment:", error);
    throw error;
  }
};




// Get all investments
exports.getAllInvestments = async () => {
  try {
    logger.info('Starting getAllInvestments function');
    
    // Step 1: Validate if the investments table is accessible
    const checkTableSql = "SHOW TABLES LIKE 'investments'";
    const [tableExists] = await pool.execute(checkTableSql);
    logger.info('Table check result:', tableExists);

    if (!tableExists.length) {
      throw new Error("Investments table not found.");
    }

    // Step 2: First try a simple query to check if we can access the investments table
    const simpleQuery = "SELECT COUNT(*) as count FROM investments";
    const [countResult] = await pool.execute(simpleQuery);
    logger.info('Investment count:', countResult[0].count);

    // Step 3: Try the full query with joins
    const sql = `
      SELECT 
        i.*, 
        s.scheme_plan_type_id AS schemeType, 
        pf.id AS paymentFrequencyId,
        pf.name AS paymentFrequencyName,
        spt.name AS schemePlanTypeName
      FROM 
        investments i
      LEFT JOIN 
        schemes s ON i.schemeId = s.id
      LEFT JOIN 
        chits c ON i.chitId = c.id
      LEFT JOIN 
        payment_frequencies pf ON c.payment_frequency = pf.id
      LEFT JOIN 
        scheme_plan_types spt ON s.scheme_plan_type_id = spt.id
      WHERE 
        i.status = 'ACTIVE'
      ORDER BY 
        i.createdAt DESC
    `;

    logger.info('Executing main query');
    const [rows] = await pool.execute(sql);
    logger.info(`Query executed successfully, found ${rows.length} rows`);

    // Step 4: Return results (empty array if no investments found)
    return rows || [];
  } catch (error) {
    logger.error('Error in getAllInvestments:', error);
    logger.error('Error stack:', error.stack);
    
    // If the complex query fails, try a simple fallback
    try {
      logger.info('Attempting fallback query');
      const fallbackSql = "SELECT * FROM investments WHERE status = 'ACTIVE' ORDER BY id DESC";
      const [fallbackRows] = await pool.execute(fallbackSql);
      logger.info(`Fallback query successful, found ${fallbackRows.length} rows`);
      return fallbackRows || [];
    } catch (fallbackError) {
      logger.error('Fallback query also failed:', fallbackError);
      throw new Error(`Failed to retrieve investments: ${error.message}`);
    }
  }
};




// Get a single investment by ID
exports.getInvestmentById = async (id) => {
  try {
    console.log("investment function");

    // SQL query to fetch the investment details along with scheme name, scheme type, and payment frequency name
    const sql = `
      SELECT 
        i.*, 
        s.scheme_plan_type_id  AS schemeType, 
        pf.name AS paymentFrequencyName,
        spt.name AS schemeName
      FROM investments i
      INNER JOIN schemes s ON i.schemeId = s.id
      INNER JOIN chits c ON i.chitId = c.id
      INNER JOIN payment_frequencies pf ON c.payment_frequency  = pf.id
      INNER JOIN scheme_plan_types spt ON s.scheme_plan_type_id = spt.id
      WHERE i.id = ? AND i.status = 'ACTIVE'
    `;
    
    const [investments] = await pool.execute(sql, [id]);

    console.log("investment", investments);
    if (investments.length === 0) {
      return { error: true, message: "No active investments found" };
    }

    let results = [];

    for (let investment of investments) {
      const startDate = new Date(investment.start_date); // Fix column name
      const startMonth = startDate.getMonth() + 1;
      const startYear = startDate.getFullYear();
      const investmentId = investment.id;

      // Get actual payments
      let payments = [];
      try {
        const [paymentResults] = await pool.execute(
          "SELECT *, amount AS amountPaid FROM payments WHERE investment_id = ?",
          [investmentId]
        );
        payments = paymentResults;
        console.log("payments", payments);
      } catch (paymentError) {
        console.error("Error fetching payments:", paymentError);
        return { error: true, message: "Failed to fetch payment details." };
      }

      // Build payment tracking data
      let paymentMap = {};
      payments.forEach((p) => (paymentMap[p.monthNumber] = p.amountPaid));

      let paymentStatus = [];
      for (let i = 1; i <= 11; i++) {
        let dueDate = new Date(startDate);
        dueDate.setMonth(startMonth + i - 1);
        let dueMonth = dueDate.getMonth() + 1;
        let dueYear = dueDate.getFullYear();

        paymentStatus.push({
          monthNumber: i,
          dueDate: `${dueYear}-${dueMonth < 10 ? "0" : ""}${dueMonth}-01`,
          amountPaid: paymentMap[i] || 0,
          status: paymentMap[i] ? "PAID" : "PENDING",
        });
      }

      results.push({
        investmentId,
        schemeType: investment.schemeType, // Scheme type
        paymentFrequencyName: investment.paymentFrequencyName, // Payment frequency name
        schemeName: investment.schemeName, // Scheme name from scheme_plan_types table
        paymentStatus,
        paymentHistory: payments.map((payment) => ({
          paymentId: payment.id,
          amountPaid: payment.amount,
          paymentDate: payment.payment_date,
          paymentMode: payment.payment_method,
          transactionId: payment.transaction_id,
          status: payment.status, // e.g., "Completed" or "Pending"
        })),
        investmentList: investment,
      });
    }

    console.log("result", results);
    return results;
  } catch (error) {
    logger.error(error)
    console.error("Database Error:", error);
    return {
      error: true,
      message: "An error occurred while fetching investment details.",
    };
  }
};



//Get Investstement by User
exports.getInvestmentsByUser = async (userId) => {
  // Validate userId
  if (!userId || isNaN(userId)) {
    return { error: true, message: "Invalid user ID." };
  }

  try {
    console.log("Fetching investments for userId:", userId);

    // Query to fetch investments along with the related scheme, chit, and payment frequency information
    const query = `
      SELECT 
        i.*, 
        s.*, 
        c.*, 
        pf.name AS payment_frequency_name,  -- Retrieve payment frequency name from payment_frequencies table
        sp.name AS scheme_type_name,        -- Retrieve scheme type name from scheme_plan_types table
        i.id AS investmentId, 
        i.userId, 
        s.id AS schemeId, 
        s.schemeName, 
        c.AMOUNT AS chitAmount, 
        c.NOINS, 
        c.TOTALMEMBERS, 
        c.REGNO, 
        c.ACTIVE, 
        c.METID, 
        c.GROUPCODE, 
       MAX(COALESCE(t.installment, 0)) AS lastInstallment
      FROM investments i
      LEFT JOIN schemes s ON i.schemeId = s.id
      LEFT JOIN (
          SELECT investment_id, MAX(monthNumber) AS installment 
          FROM payments 
          GROUP BY investment_id
      ) t ON i.id = t.investment_id
      LEFT JOIN chits c ON i.chitId = c.id 
     LEFT JOIN scheme_plan_types sp ON s.scheme_plan_type_id  = sp.id
      LEFT JOIN payment_frequencies pf ON c.payment_frequency = pf.id
      WHERE i.userId = ? 
      AND i.firstMonthPayment = 'PAID' 
      AND i.status = 'ACTIVE'
      GROUP BY i.id;
    `;

    // Execute the query
    const [rows] = await pool.execute(query, [userId]);

    // If no data is found
    if (rows.length === 0) {
      return { error: true, message: "No active investments found for the given user." };
    }

    // Process rows to map to the desired format
    const result = rows.map(row => ({
      investmentId: row.investmentId,
      userId: row.userId,
      schemeId: row.schemeId,
      schemeName: row.schemeName,
      chitAmount: row.chitAmount,
      firstMonthPayment: row.firstMonthPayment,
      accountName: row.accountName ? row.accountName : '',
      accountNo: row.accountNo ? row.accountNo : 0,
      joiningDate: row.joiningDate ? row.joiningDate : '',
      paymentStatus: row.paymentStatus ? row.paymentStatus : '',
      createdAt: row.createdAt ? row.createdAt : '',
      updatedAt: row.updatedAt ? row.updatedAt : '',
      start_date: row.start_date ? row.start_date : '',
      end_date: row.end_date ? row.end_date : '',
      total_paid: row.total_paid ? row.total_paid : '',
      dueDate: row.dueDate ? row.dueDate : '',
      previousInvestmentId: row.previousInvestmentId ? row.previousInvestmentId : 0,
      totalgoldweight: row.totalgoldweight ? row.totalgoldweight : 0,
      status: row.status ? row.status : '',
      description: row.DESCRIPTION ? row.DESCRIPTION : '',
      current_goldrate: row.current_goldrate ? row.current_goldrate : 0,
      current_silverrate: row.current_silverrate ? row.current_silverrate : 0,
      totalsilverweight: row.totalsilverweight ? row.totalsilverweight : 0,
      lastInstallment: row.lastInstallment,
      amount:row?.firstMonthAmount,
      // Nested Objects for Scheme & Chits
      scheme: {
        schemeId: row.schemeId,
        schemeName: row.schemeName,
        schemeType: row.SCHEMETYPE,
        schemeTypeName: row.scheme_type_name,  // Retrieved from scheme_plan_types table
        paymentFrequencyId: row.payment_frequency_id,
        paymentFrequencyName: row.payment_frequency_name,  // Retrieved from payment_frequencies table
      },

      // Only include chits data if schemeType is 'fixed'
      chits: row.scheme_plan_type_id  === 1 ? {
        chitId: row.id,
        amount: row.chitAmount,
        noOfInstallments: row.NOINS,
        totalMembers: row.TOTALMEMBERS,
        regNo: row.REGNO,
        active: row.ACTIVE,
        metId: row.METID,
        groupCode: row.GROUPCODE
      } : null, // For flexi schemes, no chits data
    }));

    return result;

  } catch (error) {
    logger.error(error)
    console.error("Error fetching investments:", error);
    return {
      success: false,
      message: "An error occurred while fetching the investment details.",
    };
  }
};



//Export investment
exports.getFilteredInvestments = async (userId, startDate, endDate, schemeId, chitId) => {
  let query = `
      SELECT 
        i.*, 
        s.schemeName, 
        sp.name AS scheme_type_name,  
        pf.name AS payment_frequency_name,
        i.id AS investmentId, 
        c.AMOUNT AS chitAmount, 
        c.NOINS, 
        c.TOTALMEMBERS, 
        c.REGNO, 
        c.ACTIVE, 
        c.METID, 
        c.GROUPCODE 
      FROM investments i
      LEFT JOIN schemes s ON i.schemeId = s.id
      LEFT JOIN scheme_plan_types sp ON s.scheme_plan_type_id  = sp.id  
      LEFT JOIN payment_frequencies pf ON s.payment_frequency_id = pf.id  
      LEFT JOIN chits c ON i.chitId = c.id AND s.scheme_plan_type_id  = 1  
      WHERE i.userId = ?
    `;
  const queryParams = [userId];

  if (startDate && endDate) {
    query += ` AND i.joiningDate BETWEEN ? AND ?`;
    queryParams.push(startDate, endDate);
  }

  if (schemeId) {
    query += ` AND i.schemeId = ?`;
    queryParams.push(schemeId);
  }

  if (chitId) {
    query += ` AND i.chitId = ?`;
    queryParams.push(chitId);

  }
console.log("query",query)
  const [rows] = await pool.execute(query, queryParams);
  return rows;
};
// Update an investment
exports.deactiveupdateInvestment = async (id, investmentData) => {
  const {
    userId,
    chitId,
    schemeId,
    accountName,
    accountNo,
    joiningDate,
    paymentStatus,
    status,
    descripation,
    previousInvestmentId,
  } = investmentData;
  // Check if the investment exists and is active
  const [investment] = await pool.execute(
    "SELECT id FROM investments WHERE id = ? AND status = 'ACTIVE'",
    [id]
  );
  console.log("investment", investment);
  if (investment.length === 0) {
    return { error: true, message: "Investment is not found" };
  }
  const sql = `
    UPDATE investments SET 
      userId = ?,
      chitId = ?,
      schemeId = ?,
      accountName = ?,
      joiningDate = ?,
      paymentStatus = ?,
      status=?,
      descripation=?,
      previousInvestmentId = NULL
    WHERE id = ?
  `;
  const [result] = await pool.execute(sql, [
    userId,
    chitId,
    schemeId,
    accountName,
    joiningDate,
    paymentStatus,
    status,
    descripation,
    id,
  ]);

  return { success: true, result: result };
};
exports.checkPaymentStatusForPeriod = async (userId, investmentId, paymentFrequency) => {
  try {
    console.log('payment',paymentFrequency)
    // Get the current date in UTC
    const currentDate = new Date();
    let dateCondition = "";
    let queryParams = [userId, investmentId];  // Initial query parameters

    // Check based on the payment frequency (daily, weekly, or monthly)
    if (paymentFrequency === "Daily") {
      // For daily, check if the payment date matches today's date in UTC
      const todayUTC = new Date(Date.UTC(currentDate.getUTCFullYear(), currentDate.getUTCMonth(), currentDate.getUTCDate()));
      dateCondition = `DATE(payment_date	) = ?`;
      queryParams.push(todayUTC.toISOString().split('T')[0]); // Use only the date part
    } else if (paymentFrequency === "Weekly") {
      // For weekly, get the start and end of the week in UTC
      const startOfWeek = new Date(currentDate.setUTCDate(currentDate.getUTCDate() - currentDate.getUTCDay()));
      const endOfWeek = new Date(currentDate.setUTCDate(currentDate.getUTCDate() + 6));
      
      dateCondition = `payment_date	 BETWEEN ? AND ?`;
      queryParams.push(startOfWeek.toISOString().split('T')[0], endOfWeek.toISOString().split('T')[0]); // Use date part in ISO format
    } else if (paymentFrequency === "Monthly") {
      // For monthly, get the first and last day of the month in UTC
      const firstDayOfMonth = new Date(Date.UTC(currentDate.getUTCFullYear(), currentDate.getUTCMonth(), 1));
      const lastDayOfMonth = new Date(Date.UTC(currentDate.getUTCFullYear(), currentDate.getUTCMonth() + 1, 0));

      dateCondition = `payment_date	 BETWEEN ? AND ?`;
      queryParams.push(firstDayOfMonth.toISOString().split('T')[0], lastDayOfMonth.toISOString().split('T')[0]); // Use date part in ISO format
    }

    // Query to check if the user has made a payment in the current period
    const query = `
      SELECT COUNT(*) as paymentCount
      FROM payments
      WHERE user_id = ? AND investment_id = ? AND ${dateCondition}
    `;
console.log('query',query)
    const [results] = await pool.execute(query, queryParams);
console.log("results",results)
    return results[0].paymentCount > 0; // Return true if payment exists, false if not
  } catch (error) {
    logger.error(error)
    console.error("Error in checkPaymentStatusForPeriod:", error);
    throw error; // Re-throw the error to be handled by the calling function
  }
};

exports.checkPaymentStatusForPeriodNew = async (userId, investmentId, paymentFrequency, intervalCount) => {
  try {
    console.log("yes");

    if (!intervalCount || intervalCount < 1) {
      throw new Error("Invalid intervalCount. Must be >= 1");
    }

    const currentDate = new Date();
    let queryParams = [userId, investmentId];

    // Fetch investment start date
    const [investmentData] = await pool.execute(
      "SELECT createdAt FROM investments WHERE id = ? AND userId = ?",
      [investmentId, userId]
    );

    const [paymentData] = await pool.execute(
      "SELECT MIN(payment_date) AS firstPayment FROM payments WHERE investment_id = ? AND user_id = ?",
      [investmentId, userId]
    );
    console.log("paymentDate", JSON.stringify(paymentData));

    if (!investmentData || investmentData.length === 0) return false;

    let startDate;
    if (paymentData.length > 0 && paymentData[0]?.firstPayment) {
      startDate = new Date(paymentData[0]?.firstPayment);
    } else {
      startDate = new Date(investmentData[0]?.createdAt);
    }

    console.log("Using startDate:", startDate);

    let intervalNumber = 0;
    let windowStart, windowEnd;

    const MS_PER_DAY = 1000 * 60 * 60 * 24;

    if (paymentFrequency === "Daily") {
      const diffDays = Math.floor((currentDate - startDate) / MS_PER_DAY);
      intervalNumber = Math.floor(diffDays / intervalCount);

      const baseTime = startDate.getTime();
      const intervalLengthMs = intervalCount * MS_PER_DAY;

      const windowStartTime = baseTime + intervalNumber * intervalLengthMs;
      const windowEndTime = windowStartTime + intervalLengthMs - MS_PER_DAY;

      windowStart = new Date(windowStartTime);
      windowEnd = new Date(windowEndTime);

    } else if (paymentFrequency === "Weekly") {
      const MS_PER_WEEK = MS_PER_DAY * 7;
      const diffWeeks = Math.floor((currentDate - startDate) / MS_PER_WEEK);
      intervalNumber = Math.floor(diffWeeks / intervalCount);

      const baseTime = startDate.getTime();
      const intervalLengthMs = intervalCount * MS_PER_WEEK;

      const windowStartTime = baseTime + intervalNumber * intervalLengthMs;
      const windowEndTime = windowStartTime + intervalLengthMs - MS_PER_DAY;

      windowStart = new Date(windowStartTime);
      windowEnd = new Date(windowEndTime);

    } else if (paymentFrequency === "Monthly") {
      const startYear = startDate.getUTCFullYear();
      const startMonth = startDate.getUTCMonth();
      const currentYear = currentDate.getUTCFullYear();
      const currentMonth = currentDate.getUTCMonth();

      const diffMonths = (currentYear - startYear) * 12 + (currentMonth - startMonth);
      intervalNumber = Math.floor(diffMonths / intervalCount);

      const windowStartMonth = startMonth + intervalNumber * intervalCount;
      windowStart = new Date(Date.UTC(startYear, windowStartMonth, startDate.getUTCDate()));

      // Adjust day if current month doesn't have that date (e.g., Feb 30)
      const actualWindowStartDay = new Date(windowStart.getUTCFullYear(), windowStart.getUTCMonth() + 1, 0).getUTCDate();
      if (startDate.getUTCDate() > actualWindowStartDay) {
        windowStart.setUTCDate(actualWindowStartDay);
      }

      // End = start of next interval - 1 day
      const windowEndTemp = new Date(Date.UTC(startYear, windowStartMonth + intervalCount, startDate.getUTCDate()));
      windowEndTemp.setUTCDate(windowEndTemp.getUTCDate() - 1);
      windowEnd = windowEndTemp;

    } else {
      return false; // Unsupported frequency
    }
    console.log("windowstart",windowStart,windowEnd)
    const windowStartDate = windowStart.toLocaleDateString('en-CA', { timeZone: 'Asia/Kolkata' });
    const windowEndDate = windowEnd.toLocaleDateString('en-CA', { timeZone: 'Asia/Kolkata' });
    console.log("Interval window:", windowStartDate, "to", windowEndDate);

    const query = `
      SELECT COUNT(*) AS paymentCount
      FROM payments
      WHERE user_id = ? AND investment_id = ?
        AND DATE(payment_date) BETWEEN ? AND ?
    `;
    queryParams.push(windowStartDate, windowEndDate);

    const [results] = await pool.execute(query, queryParams);
    return results[0].paymentCount > 0;

  } catch (error) {
    logger.error("Payment Status Check Failed:", error);
    throw error;
  }
};






// Update an investment
// exports.updateInvestment = async (id, investmentData) => {
//   const {
//     userId,
//     chitId,
//     schemeId,
//     accountName,
//     accountNo,
//     paymentStatus,
//     previousInvestmentId,
//     paymentAmount
//   } = investmentData;

//   const connection = await pool.getConnection(); // For transaction management

//   try {
//     await connection.beginTransaction(); // Start transaction

//     // Step 1: Check if the investment exists and is active
//     const [investment] = await connection.execute(
//       `SELECT I.totalgoldweight, I.joiningDate, S.NOINS as duration, COUNT(P.id) AS monthsPaid
//        FROM investments I
//        JOIN chits S ON I.chitId = S.id
//        LEFT JOIN payments P ON I.id = P.investment_id AND P.payment_status = 'success'
//        WHERE I.id = ? GROUP BY I.id`,
//       [id]
//     );

//     if (investment.length === 0) {
//       await connection.rollback();
//       return { success: false, message: "Investment not found." };
//     }

//     // Fetch the current gold and silver rates
//     const [rateResult] = await connection.execute(`SELECT gold_rate, silver_rate FROM rates WHERE status = 'active'`);
//     const { gold_rate, silver_rate } = rateResult[0];
//     console.log("Gold Rate:", gold_rate, "Silver Rate:", silver_rate);

//     const { totalgoldweight, joiningDate, duration, monthsPaid } = investment[0];

//     // Step 2: Calculate the gold weight based on the payment amount
//     let updatedGoldWeight = totalgoldweight;
//     let extraGoldWeight = 0;
//     let goldWeightGained = 0;

//     if (paymentAmount) {
//       goldWeightGained = parseFloat(paymentAmount) / parseFloat(gold_rate);
//       console.log("goldWeightGained",goldWeightGained)
//       const [totalGoldWeightResult] = await connection.execute(
//         `SELECT COALESCE(SUM(gold_rate), 0) AS totalGoldWeight FROM payments
//          WHERE investment_id = ? AND payment_status = 'success'`,
//         [id]
//       );
//       const {totalGoldWeight}=totalGoldWeightResult[0]

//       updatedGoldWeight = parseFloat(totalGoldWeight) + goldWeightGained;
//     }

//     // Step 3: Calculate the next due date (1 month after the last payment)
//     let nextDueDate = new Date(joiningDate);
//     nextDueDate.setMonth(nextDueDate.getMonth() + monthsPaid + 1);
//     nextDueDate = nextDueDate.toISOString().split("T")[0]; // Format YYYY-MM-DD

//     // Step 4: Update the investment record
//     await connection.execute(
//       `UPDATE investments SET
//         userId = ?, chitId = ?, schemeId = ?, accountName = ?,
//         accountNo = ?, paymentStatus = ?, totalgoldweight = ?,
//         updatedAt = CURRENT_TIMESTAMP, current_goldrate = ?,
//         current_silverrate = ?, dueDate = ?
//       WHERE id = ?`,
//       [
//         userId, chitId, schemeId, accountName, accountNo,
//         paymentStatus, updatedGoldWeight.toFixed(2), gold_rate,
//         silver_rate, nextDueDate, id
//       ]
//     );

//     console.log("fully",monthsPaid,duration)

//     // Step 6: Check if the investment is fully paid (if the duration is completed)
//     if (monthsPaid + 1 >= duration) {
//       console.log("fully",monthsPaid + 1 >= duration)
//       await connection.execute(
//         `UPDATE investments SET paymentStatus = 'COMPLETED' WHERE id = ?`,
//         [id]
//       );
//     }

//     await connection.commit(); // Commit transaction

//     return {
//       success: true,
//       message: "Investment updated successfully.",
//       updatedGoldWeight,
//       extraGoldWeight,
//       nextDueDate
//     };
//   } catch (error) {
//     await connection.rollback(); // Rollback in case of an error
//     console.error("Error updating investment:", error);
//     return { error: true, message: "Database error occurred." };
//   } finally {
//     connection.release(); // Release connection
//   }
// };
exports.checkPaymentStatus = async (userId, investmentId) => {
  const query = `
    SELECT COUNT(*) AS count FROM payments
    WHERE user_id = ? AND investment_id = ? 
      AND MONTH(payment_date) = MONTH(CURRENT_DATE())
      AND YEAR(payment_date) = YEAR(CURRENT_DATE());
  `;

  const [rows] = await pool.execute(query, [userId, investmentId]);

  return rows[0].count > 0; // true if payment exists
};
exports.payNow = async (userId, investmentId, amount) => {
  try {
    console.log("Working with:", userId, investmentId, amount);

    // Fetch active investment details
    const sql = "SELECT * FROM investments WHERE id = ? AND status='ACTIVE'";
    const [investments] = await pool.execute(sql, [investmentId]);

    // Check if the investment exists
    if (investments.length === 0) {
      return { success: false, message: "No active investments found" };
    }

    const { chitId, schemeId, accountName, accountNo, schemeType } = investments[0];

    // Fetch scheme details to get the payment frequency and scheme type
    const schemeQuery = "SELECT c.*,c.payment_frequency as payment_frequency_id ,s.* FROM chits as c join schemes as s on c.schemeId=s.id WHERE c.id = ?";
    const [schemes] = await pool.execute(schemeQuery, [chitId]);

    if (schemes.length === 0) {
      return { success: false, message: "Scheme not found" };
    }

    const { payment_frequency_id , scheme_plan_type_id  } = schemes[0]; // Retrieve payment frequency and type from scheme
  // Fetch scheme type and payment frequency details
  const schemePlanQuery = "SELECT * FROM scheme_plan_types WHERE id = ?";
  const [schemePlanType] = await pool.execute(schemePlanQuery, [scheme_plan_type_id]);

  const paymentFrequencyQuery = "SELECT * FROM payment_frequencies WHERE id = ?";
  const [paymentFrequency] = await pool.execute(paymentFrequencyQuery, [payment_frequency_id]);
  console.log("paymentfreq",JSON.stringify(paymentFrequency))
let paymentFrequencyvalue=paymentFrequency.length>0?paymentFrequency[0].name:''
  console.log('schemplantype',JSON.stringify(schemePlanType),paymentFrequencyvalue)
  if (!schemePlanType || !paymentFrequency) {
    return { success: false, message: "Scheme plan type or payment frequency not found" };
  }
    // Fetch chit details
    const chitquery = "SELECT * FROM chits WHERE id = ? AND ACTIVE='Y'";
    const [chits] = await pool.execute(chitquery, [chitId]);

    if (chits.length === 0) {
      return { success: false, message: "Chit not found for this investment" };
    }

    const chitAmount = chits[0].amount;

    // If the scheme type is 'Fixed', we check payment based on frequency
    if (schemePlanType[0].name == 'Fixed') {
      const isPaid = await this.checkPaymentStatusForPeriod(userId, investmentId, paymentFrequencyvalue);
      console.log("Payment status for this period:", isPaid);

      // If the user has already paid for the period, reject the payment
      if (isPaid) {
        return { success: false, message: `Payment already made for this ${paymentFrequencyvalue}` };
      }
      else
      {
        return { success: false, message: `Payment not capture under  ${paymentFrequencyvalue}` };
      }
     

      

      
    }
    else
    {
      return { success: true, message: `User have Flexi payment frequency` };
    }
  } catch (error) {
    logger.error(error)
    console.error("Error in payNow:", error);
    return { success: false, message: "Internal server error", error };
  }
};
exports.payNowNew = async (userId, investmentId, amount) => {
  try {
    console.log("Working with:", userId, investmentId, amount);

    // Fetch active investment details
    const sql = "SELECT * FROM investments WHERE id = ? AND status='ACTIVE'";
    const [investments] = await pool.execute(sql, [investmentId]);

    // Check if the investment exists
    if (investments.length === 0) {
      return { success: false, message: "No active investments found" };
    }

    const { chitId, schemeId, accountName, accountNo, schemeType } = investments[0];

    // Fetch scheme details to get the payment frequency and scheme type
    const schemeQuery = "SELECT c.*,c.payment_frequency as payment_frequency_id ,s.* FROM chits as c join schemes as s on c.schemeId=s.id WHERE c.id = ?";
    const [schemes] = await pool.execute(schemeQuery, [chitId]);

    if (schemes.length === 0) {
      return { success: false, message: "Scheme not found" };
    }

    const { payment_frequency_id , scheme_plan_type_id  } = schemes[0]; // Retrieve payment frequency and type from scheme
    console.log("payment_frequency_id",payment_frequency_id,scheme_plan_type_id)
  // Fetch scheme type and payment frequency details
  const schemePlanQuery = "SELECT * FROM scheme_plan_types WHERE id = ?";
  const [schemePlanType] = await pool.execute(schemePlanQuery, [scheme_plan_type_id]);

  const paymentFrequencyQuery = "SELECT * FROM payment_frequencies WHERE id = ?";
  const [paymentFrequency] = await pool.execute(paymentFrequencyQuery, [payment_frequency_id]);
  console.log("paymentfreq",JSON.stringify(paymentFrequency))
let paymentFrequencyvalue=paymentFrequency.length>0?paymentFrequency[0].name:''
  console.log('schemplantype',JSON.stringify(schemePlanType),paymentFrequencyvalue)
  if (!schemePlanType || !paymentFrequency) {
    return { success: false, message: "Scheme plan type or payment frequency not found" };
  }
    // Fetch chit details
    const chitquery = "SELECT * FROM chits WHERE id = ? AND ACTIVE='Y'";
    const [chits] = await pool.execute(chitquery, [chitId]);

    if (chits.length === 0) {
      return { success: false, message: "Chit not found for this investment" };
    }

    const chitAmount = chits[0].amount;
const intervalCount = paymentFrequency[0]?.interval_count || 1;
console.log("schemePlanType[0].name",schemePlanType[0].name)
    // If the scheme type is 'Fixed', we check payment based on frequency
    if (schemePlanType[0].name == 'Fixed') {
     const isPaid = await this.checkPaymentStatusForPeriodNew(userId, investmentId, paymentFrequencyvalue, intervalCount);
      console.log("Payment status for this period:", isPaid);

      // If the user has already paid for the period, reject the payment
      if (isPaid) {
        return { success: false, message: `Payment already made for this ${paymentFrequencyvalue}` };
      }
      else
      {
        return { success: true, message: `Payment not capture under  ${paymentFrequencyvalue}` };
      }
     

      

      
    }
    else
    {
      return { success: true, message: `User have Flexi payment frequency` };
    }
  } catch (error) {
    logger.error(error)
    console.error("Error in payNow:", error);
    return { success: false, message: "Internal server error", error };
  }
};



exports.updateInvestment = async (id, investmentData) => {
  console.log('id', id, JSON.stringify(investmentData));
  const {
    userId,
    chitId,
    schemeId,
    accountName,
    accountNo,
    paymentStatus,
    previousInvestmentId,
    paymentAmount,
    paymentFrequency, // Added paymentFrequency
  } = investmentData;
  let firstMonthAmount=0
  const connection = await pool.getConnection(); // For transaction management

  try {
    console.log("id value", id, investmentData);
    await connection.beginTransaction(); // Start transaction

    const [schemeInfo] = await connection.execute(
      `SELECT c.*,spt.name AS schemeType, pf.name AS paymentFrequency ,sc.type as schemevalue,pf.duration as payment_frequenies_duration,pf.payment_duration as payment_duration
       FROM schemes sc
       JOIN scheme_plan_types spt ON sc.scheme_plan_type_id = spt.id
       JOIN chits as c on c.schemeId=sc.id
       JOIN payment_frequencies pf ON c.payment_frequency = pf.id
       WHERE c.id = ?`,
      [chitId]
    );
    if (schemeInfo.length === 0) {
      await connection.rollback();
      return { error: true, message: "Scheme information not found." };
    }
    
    const { schemeType, paymentFrequency,schemevalue,payment_frequenies_duration,payment_duration } = schemeInfo[0];
    console.log("Scheme Type:", schemeType, "Frequency:", paymentFrequency);
    console.log("Scheme Type:", schemeType, id);

    var sql1 = `SELECT I.totalgoldweight, I.totalsilverweight, I.joiningDate, I.firstMonthAmount as firstMonthAmounts, S.NOINS as duration, COUNT(P.id) AS monthsPaid, MAX(P.payment_date) as paymentDate, I.start_date as startDate, I.firstMonthPayment FROM investments I JOIN chits S ON I.chitId = S.id LEFT JOIN payments P ON I.id = P.investment_id AND P.payment_status = 'success' WHERE I.id = ? AND I.status='ACTIVE' GROUP BY I.id`;
    console.log("sql1", sql1);
    // Step 1: Check if the investment exists and is active
    const [investment] = await connection.execute(sql1, [id]);
    console.log('investment', investment);
    if (investment.length === 0) {
      await connection.rollback();
      return { error: true, message: "Investment not found." };
    }

    // Fetch the current gold and silver rates
    const [rateResult] = await connection.execute(
      `SELECT gold_rate, silver_rate FROM rates WHERE status = 'active'`
    );
    const { gold_rate, silver_rate } = rateResult[0];
    if (!gold_rate || !silver_rate) {
      return { success: false, message: "Gold or Silver rates are unavailable." };
    }
    console.log("Gold Rate:", gold_rate, "Silver Rate:", silver_rate);

    const [totalPaidResult] = await connection.execute(
      `SELECT COALESCE(SUM(amount), 0) AS totalPaid FROM payments WHERE investment_id = ? AND user_id = ? AND payment_status = 'success'`,
      [id, userId]
    );
    const { totalPaid } = totalPaidResult[0];
    const updatedTotalPaid = parseFloat(totalPaid);
console.log("update",updatedTotalPaid)
    const {
      totalgoldweight,
      totalsilverweight,
      joiningDate,
      duration,
      monthsPaid,
      paymentDate,
      startDate,
      firstMonthPayment,
      firstMonthAmounts
    } = investment[0];

    // Step 2: Calculate the weight based on the scheme type (Gold or Silver)
    let updatedGoldWeight = totalgoldweight ? Number(totalgoldweight) : 0;
    let updatedSilverWeight = totalsilverweight ? Number(totalsilverweight) : 0;
    let goldWeightGained = 0;
    let silverWeightGained = 0;

    // Calculate weight based on the scheme type
    if (paymentAmount) {
      if (schemevalue === "gold") {
        goldWeightGained = parseFloat(paymentAmount) / parseFloat(gold_rate);
        updatedGoldWeight = updatedGoldWeight + goldWeightGained;;
        updatedSilverWeight = 0;
      } else if (schemevalue === "silver") {
        silverWeightGained = parseFloat(paymentAmount) / parseFloat(silver_rate);
        updatedSilverWeight = updatedSilverWeight + silverWeightGained;
        updatedGoldWeight = 0;
      }
    }

    let newPaymentDate = paymentDate || new Date().toISOString().split("T")[0]; // If no paymentDate, take current date
    let newStartDate = startDate || newPaymentDate; // If no startDate, use new payment date as startDate

    if ((!startDate || isNaN(new Date(startDate).getTime())) && paymentAmount ) {
      // If no start date exists (first payment) and a payment amount is provided, set the start date as the current payment date.
      newStartDate = new Date().toISOString().split("T")[0]; // Get the current date in YYYY-MM-DD format
    }

    console.log('startdate payment', newStartDate,payment_frequenies_duration);

    // Step 3: Generate the next due date using the provided payment frequency
    const nextDueDate = generateDueDate(paymentFrequency, newStartDate,payment_frequenies_duration);
    console.log("nextDueDate", nextDueDate);

    let updatedFirstMonthPayment = firstMonthPayment;
    firstMonthAmount=firstMonthAmounts;
    if (monthsPaid === 1 && paymentAmount) {
      updatedFirstMonthPayment = 'PAID';
      firstMonthAmount=paymentAmount
      newStartDate = new Date().toISOString().split("T")[0];
    }

    var endDate = calculateEndDate(newStartDate, duration);

    console.log("total weight", totalPaid, updatedGoldWeight, updatedSilverWeight);

    // Step 4: Update the investment record
    await connection.execute(
      `UPDATE investments SET 
        userId = ?, chitId = ?, schemeId = ?, accountName = ?, 
        accountNo = ?, paymentStatus = ?, totalgoldweight = ?, totalsilverweight = ?, 
        updatedAt = CURRENT_TIMESTAMP, current_goldrate = ?, 
        current_silverrate = ?, dueDate = ?, start_date = ?, end_date = ?, firstMonthPayment = ?, total_paid = ? ,firstMonthAmount=?
      WHERE id = ?`,
      [
        userId,
        chitId,
        schemeId,
        accountName,
        accountNo,
        paymentStatus,
        updatedGoldWeight ? updatedGoldWeight.toFixed(5) : 0,
        updatedSilverWeight ? updatedSilverWeight.toFixed(5) : 0,
        gold_rate,
        silver_rate,
        nextDueDate, // Updated due date here
        newStartDate,
        endDate,
        updatedFirstMonthPayment,
        updatedTotalPaid,
        firstMonthAmount,
        id,
      ]
    );
      let totalPaymentsRequired;

      if (paymentFrequency === "Monthly") {
        totalPaymentsRequired = duration; // 11 months = 11 payments
      } else if (paymentFrequency === "Weekly") {
        totalPaymentsRequired = duration * 4; // Roughly 44 weekly payments
      } else if (paymentFrequency === "Daily") {
        totalPaymentsRequired = duration * 30; // Roughly 330 daily payments
      }
      console.log("totpaymentrequired",totalPaymentsRequired)
    // Step 5: Check if the investment is fully paid (if the duration is completed)
    if (monthsPaid + 1 >= totalPaymentsRequired) {
      console.log("Fully Paid");
      await connection.execute(
        `UPDATE investments SET paymentStatus = 'completed' WHERE id = ?`,
        [id]
      );
    }

    await connection.commit(); // Commit transaction

    return {
      success: true,
      message: "Investment updated successfully.",
      updatedGoldWeight,
      updatedSilverWeight,
      nextDueDate,
      firstMonthPayment: updatedFirstMonthPayment,
      totalPaid: updatedTotalPaid
    };
  } catch (error) {
    await connection.rollback(); // Rollback in case of an error
    console.error("Error updating investment:", error);
    return { error: true, message: "Database error occurred." };
  } finally {
    connection.release(); // Release connection
  }
};

exports.updateInvestmentNew = async (id, investmentData) => {
  console.log('id', id, JSON.stringify(investmentData));

  const {
    userId, chitId, schemeId, accountName, accountNo,
    paymentStatus, previousInvestmentId, paymentAmount, paymentFrequency // paymentFrequency here is probably redundant, we fetch from DB
  } = investmentData;

  let firstMonthAmount = 0;
  const connection = await pool.getConnection();

  try {
    console.log("id value", id, investmentData);
    await connection.beginTransaction();

    // Fetch scheme, chit, and payment frequency details (including interval_unit and interval_count)
    const [schemeInfo] = await connection.execute(
      `SELECT c.*, spt.name AS schemeType, pf.name AS paymentFrequency,
              sc.type AS schemevalue, pf.duration AS payment_frequenies_duration,pf.payment_duration as payment_duration,
              pf.payment_duration AS totalInvestmentDuration,
              pf.interval_unit, pf.interval_count
       FROM schemes sc
       JOIN scheme_plan_types spt ON sc.scheme_plan_type_id = spt.id
       JOIN chits c ON c.schemeId = sc.id
       JOIN payment_frequencies pf ON c.payment_frequency = pf.id
       WHERE c.id = ?`,
      [chitId]
    );

    if (schemeInfo.length === 0) {
      await connection.rollback();
      return { error: true, message: "Scheme information not found." };
    }

    const {
      schemeType, paymentFrequency: freqName, schemevalue,
      payment_frequenies_duration, totalInvestmentDuration,
      interval_unit, interval_count,payment_duration
    } = schemeInfo[0];

    console.log("Scheme Type:", schemeType, "Frequency:", freqName, "Interval Unit:", interval_unit, "Interval Count:", interval_count);

    // Fetch investment details
    const sql1 = `SELECT I.totalgoldweight, I.totalsilverweight, I.joiningDate, 
                         I.firstMonthAmount AS firstMonthAmounts, S.NOINS AS duration, 
                         COUNT(P.id) AS monthsPaid, MAX(P.payment_date) AS paymentDate, 
                         I.start_date AS startDate, I.firstMonthPayment
                  FROM investments I 
                  JOIN chits S ON I.chitId = S.id 
                  LEFT JOIN payments P ON I.id = P.investment_id 
                       AND P.payment_status = 'success' 
                  WHERE I.id = ? AND I.status='ACTIVE' 
                  GROUP BY I.id`;

    const [investment] = await connection.execute(sql1, [id]);

    if (investment.length === 0) {
      await connection.rollback();
      return { error: true, message: "Investment not found." };
    }

    // Fetch current gold and silver rates
    const [rateResult] = await connection.execute(
      `SELECT gold_rate, silver_rate FROM rates WHERE status = 'active'`
    );

    const { gold_rate, silver_rate } = rateResult[0];

    if (!gold_rate || !silver_rate) {
      return { success: false, message: "Gold or Silver rates are unavailable." };
    }

    console.log("Gold Rate:", gold_rate, "Silver Rate:", silver_rate);

    const [totalPaidResult] = await connection.execute(
      `SELECT COALESCE(SUM(amount), 0) AS totalPaid 
       FROM payments WHERE investment_id = ? AND user_id = ? 
       AND payment_status = 'success'`,
      [id, userId]
    );

    const { totalPaid } = totalPaidResult[0];
    const updatedTotalPaid = parseFloat(totalPaid);

    console.log("update", updatedTotalPaid);

    const {
      totalgoldweight, totalsilverweight, joiningDate, duration, monthsPaid,
      paymentDate, startDate, firstMonthPayment, firstMonthAmounts
    } = investment[0];

    // Calculate updated gold/silver weight based on payment amount and scheme type
    let updatedGoldWeight = totalgoldweight ? Number(totalgoldweight) : 0;
    let updatedSilverWeight = totalsilverweight ? Number(totalsilverweight) : 0;
    let goldWeightGained = 0;
    let silverWeightGained = 0;

    if (paymentAmount) {
      if (schemevalue === "gold") {
        goldWeightGained = parseFloat(paymentAmount) / parseFloat(gold_rate);
        updatedGoldWeight += goldWeightGained;
        updatedSilverWeight = 0;
      } else if (schemevalue === "silver") {
        silverWeightGained = parseFloat(paymentAmount) / parseFloat(silver_rate);
        updatedSilverWeight += silverWeightGained;
        updatedGoldWeight = 0;
      }
    }
console.log("dtart",dayjs(startDate).isValid(),startDate,paymentDate)
    // Determine the base date to calculate the next due date
    let newPaymentDate = paymentDate || dayjs().startOf('day').format('YYYY-MM-DD');
    let newStartDate = dayjs(startDate).startOf('day').format('YYYY-MM-DD') || newPaymentDate;
    let newStartDateflex = dayjs(startDate).isValid()?dayjs(startDate).startOf('day').format('YYYY-MM-DD'):newPaymentDate;
console.log("start date as",newStartDate,newPaymentDate,new Date())
    if ((!startDate || isNaN(new Date(startDate).getTime())) && paymentAmount) {
      newStartDate = dayjs().startOf('day').format('YYYY-MM-DD');
    }

    console.log('startdate payment', newStartDate, payment_frequenies_duration,interval_count,interval_unit,newStartDateflex,paymentDate);

  

    // Use interval_unit and interval_count if available, else fallback to paymentFrequency and 1
    const intervalUnit = interval_unit || freqName;
    const intervalCount = interval_count || 1;
console.log("newStartDate",newStartDate,totalInvestmentDuration)
    const nextDueDate = generateDueDateNew(intervalUnit, newStartDate, intervalCount,newStartDateflex,paymentDate);
    console.log("nextDueDate", nextDueDate);

    let updatedFirstMonthPayment = firstMonthPayment;
    firstMonthAmount = firstMonthAmounts;

    if (monthsPaid === 1 && paymentAmount) {
      updatedFirstMonthPayment = 'PAID';
      firstMonthAmount = paymentAmount;
      newStartDate = new Date().toISOString().split("T")[0];
    }

    // Calculate end date by adding total investment duration in months (you might have your own logic)
    var endDate = calculateEndDateNew(newStartDate, duration);

    console.log("total weight", totalPaid, updatedGoldWeight, updatedSilverWeight,payment_frequenies_duration);

          let totalPaymentsRequired;

        const unit = (intervalUnit || '').toLowerCase();

        if (unit === "daily") {
          // payment_duration is total days, divide by intervalCount (e.g., every 2 days)
          totalPaymentsRequired = Math.ceil(payment_duration / intervalCount);

        } else if (unit === "weekly") {
          // duration is in months (e.g., 11), convert to weeks by multiplying ~4.35 weeks/month,
          // then divide by intervalCount (e.g., every 2 weeks)
          totalPaymentsRequired = Math.ceil((duration * 4.35) / intervalCount);

        } else if (unit === "monthly") {
          // duration is months, divide by intervalCount (e.g., every 2 months)
          totalPaymentsRequired = Math.ceil(duration / intervalCount);

        } else {
          // fallback to duration as is
          totalPaymentsRequired = duration;
        }

            console.log("Total Payments Required:", monthsPaid,totalPaymentsRequired);

   

    // Update the investment record
    await connection.execute(
      `UPDATE investments SET 
          userId = ?, chitId = ?, schemeId = ?, accountName = ?, 
          accountNo = ?, paymentStatus = ?, totalgoldweight = ?, totalsilverweight = ?, 
          updatedAt = CURRENT_TIMESTAMP, current_goldrate = ?, 
          current_silverrate = ?, dueDate = ?, start_date = ?, end_date = ?, 
          firstMonthPayment = ?, total_paid = ?, firstMonthAmount = ?
       WHERE id = ?`,
      [
        userId, chitId, schemeId, accountName, accountNo, paymentStatus,
        updatedGoldWeight.toFixed(5), updatedSilverWeight.toFixed(5), gold_rate, silver_rate,
        nextDueDate, newStartDate, endDate, updatedFirstMonthPayment, updatedTotalPaid, firstMonthAmount, id
      ]
    );


     if (monthsPaid + 1 >= totalPaymentsRequired) {
      console.log("Fully Paid");
      await connection.execute(
        `UPDATE investments SET paymentStatus = 'completed' WHERE id = ?`,
        [id]
      );
    }
    await connection.commit();

    return {
      success: true,
      message: "Investment updated successfully.",
      updatedGoldWeight,
      updatedSilverWeight,
      nextDueDate,
      totalPaid: updatedTotalPaid,
      firstMonthAmount
    };
  } catch (err) {
    await connection.rollback();
    console.error(err);
    return { success: false, message: err.message };
  } finally {
    connection.release();
  }
};





// Delete an investment
exports.deleteInvestment = async (id) => {
  const sql = "DELETE FROM investments WHERE id = ?";
  const [result] = await pool.execute(sql, [id]);
  return result;
};
const calculateEndDateold = (joiningDate, durationMonths) => {
  const endDate = new Date(joiningDate);
  endDate.setMonth(endDate.getMonth() + durationMonths); // Add the duration to the joining date
  return new Date(endDate); // Return the final end date
};
const calculateEndDate = (joiningDate, durationMonths) => {
  if (!joiningDate || isNaN(new Date(joiningDate))) {
    throw new Error('Invalid joiningDate provided');
  }

  const startDate = new Date(joiningDate);

  // Calculate UTC-based end date to avoid timezone issues
  const endDate = new Date(Date.UTC(
    startDate.getUTCFullYear(),
    startDate.getUTCMonth() + durationMonths,
    startDate.getUTCDate()
  ));

  const formattedEndDate = endDate.toISOString().slice(0, 10); // YYYY-MM-DD
  console.log("enddate", formattedEndDate);
  return formattedEndDate;
};

const calculateEndDateNew = (joiningDate, durationMonths) => {
  if (!joiningDate || !dayjs(joiningDate).isValid()) {
    throw new Error('Invalid joiningDate provided');
  }

  const endDate = dayjs(joiningDate).add(durationMonths, 'month');

  // Format to YYYY-MM-DD
  const formattedEndDate = endDate.format('YYYY-MM-DD');
  console.log("enddate", formattedEndDate);
  return formattedEndDate;
};
function isValidDate(dateString) {
  // Check if the date is in YYYY-MM-DD format
  const regex = /^\d{4}-\d{2}-\d{2}$/;
  if (!dateString.match(regex)) {
    return false; // Invalid format
  }

  // Check if the year, month, or day is invalid (e.g., 000, 00)
  const [year, month, day] = dateString
    .split("-")
    .map((num) => parseInt(num, 10));

  if (year === 0 || month === 0 || day === 0) {
    return false; // Invalid year, month, or day
  }

  // Check if the date is valid
  const date = new Date(year, month - 1, day); // month is 0-indexed in JS
  return (
    date.getFullYear() === year &&
    date.getMonth() + 1 === month &&
    date.getDate() === day
  );
}
function generateDueDate(paymentFrequency, startDate,payment_frequenies_duration) {
  console.log("Payment Frequency:", paymentFrequency);

  // Normalize the paymentFrequency to lowercase
  paymentFrequency = paymentFrequency.toLowerCase();
  const dueDate = new Date(startDate); // Convert startDate to a Date object

  // Ensure the date is in UTC for consistency
  const utcDate = new Date(Date.UTC(
    dueDate.getUTCFullYear(),
    dueDate.getUTCMonth(),
    dueDate.getUTCDate(),
    dueDate.getUTCHours(),
    dueDate.getUTCMinutes(),
    dueDate.getUTCSeconds(),
    dueDate.getUTCMilliseconds()
  ));

  switch (paymentFrequency) {
    case 'daily':
      utcDate.setUTCDate(utcDate.getUTCDate() + (payment_frequenies_duration||1)); // Add 1 day for daily payments
      break;

    case 'weekly':
      utcDate.setUTCDate(utcDate.getUTCDate() + (payment_frequenies_duration||7)); // Add 7 days for weekly payments
      break;

    case 'monthly':
      // Set to the last day of the next month
      utcDate.setUTCMonth(utcDate.getUTCMonth() + 1);
      utcDate.setUTCDate(0); // Set to last day of the month
      break;

    case 'yearly':
      utcDate.setUTCFullYear(utcDate.getUTCFullYear() + 1); // Add 1 year for yearly payments
      break;

    default:
      throw new Error('Invalid payment frequency');
  }

  return utcDate.toISOString().split("T")[0]; // Return in YYYY-MM-DD format
}
function formatDateToUTCString(date) {
  const d = new Date(date); // Make sure it's a Date object

  const year = d.getUTCFullYear();
  const month = String(d.getUTCMonth() + 1).padStart(2, '0');
  const day = String(d.getUTCDate()).padStart(2, '0');

  return `${year}-${month}-${day}`; // returns "YYYY-MM-DD"
}
  // Updated generateDueDateNew function using interval_unit and interval_count
    // function generateDueDateNew(paymentFrequency, startDate, intervalCount) {
    //   console.log("startrget",startDate)
    //   const dateOnlyString = formatDateToUTCString(startDate)
    //   paymentFrequency = (paymentFrequency || '').toLowerCase();
    //   console.log("startdatee",dateOnlyString)
    //   const start = new Date(dateOnlyString);
    //     console.log("start dates",start)
    //   let nextDueDate = new Date(Date.UTC(
    //     start.getUTCFullYear(),
    //     start.getUTCMonth(),
    //     start.getUTCDate()
    //   ));
    //   console.log("next ",nextDueDate,intervalCount)

    //   intervalCount = Number(intervalCount) || 1;

    //   switch (paymentFrequency) {
    //     case 'daily':
    //       nextDueDate.setUTCDate(nextDueDate.getUTCDate() + intervalCount);
    //       break;

    //     case 'weekly':
    //       nextDueDate.setUTCDate(nextDueDate.getUTCDate() + (intervalCount * 7));
    //       break;

    //     case 'monthly':
    //       nextDueDate.setUTCMonth(nextDueDate.getUTCMonth() + intervalCount);
    //       break;

    //     case 'yearly':
    //       nextDueDate.setUTCFullYear(nextDueDate.getUTCFullYear() + intervalCount);
    //       break;

    //     default:
    //       throw new Error('Invalid payment frequency');
    //   }

    //   return nextDueDate.toISOString().split('T')[0];
    // }



function generateDueDateNew(paymentFrequency, startDate, intervalCount,newstartFlex,paymentDate) {
console.log('payment',paymentDate)
  const baseDate = paymentDate || startDate;
  console.log("startrget",startDate,newstartFlex,baseDate)
  if (!startDate) throw new Error('Start date is required');
  
  // Convert to UTC and remove time (set to start of day)
  const start = dayjs(baseDate).startOf('day');
  const flexistart=dayjs(newstartFlex).startOf('day');
  console.log("After format",start)
  paymentFrequency = (paymentFrequency || '').toLowerCase();

  let nextDueDate;

  switch (paymentFrequency) {
    case 'daily':
      nextDueDate = start.add(intervalCount, 'day');
      break;

    case 'weekly':
      nextDueDate = start.add(intervalCount, 'week');
      break;

    case 'monthly':
      nextDueDate = start.add(intervalCount, 'month');
      break;

    case 'yearly':
      nextDueDate = start.add(intervalCount, 'year');
      break;
    case 'flexi':
      nextDueDate = flexistart.add(intervalCount, 'month');
      break;
    default:
      throw new Error('Invalid payment frequency');
  }

  // Return ISO date string without timestamp
  return nextDueDate.format('YYYY-MM-DD');
}


function generateDueDatesFromPlan(startDate, duration, totalCycles) {
  const start = new Date(startDate);
  const dueDates = [];

  for (let i = 0; i < totalCycles; i++) {
    const due = new Date(start);
    due.setDate(start.getDate() + i * duration);
    dueDates.push(due.toISOString().split("T")[0]);
  }

  return dueDates;
}


