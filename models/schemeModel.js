const db = require("../config/db");
const logger=require('../middlewares/logger')
const Scheme = {
  create: async (schemeData) => {
    try {
      // Step 1: Validate required common fields
      const requiredFields = ['SCHEMENAME', 'SCHEMETYPE', 'SCHEMENO', 'REGNO', 'BRANCHID', 'INS_TYPE', 'duration_months', 'scheme_plan_type_id'];
      const missingFields = requiredFields.filter(field => !schemeData[field]);
  
      if (missingFields.length > 0) {
        throw new Error(`Missing required fields: ${missingFields.join(', ')}`);
      }
  
      // // Step 2: Validate payment_frequency_id for FIXED schemes
      // if (schemeData.SCHEMETYPE === 'FIXED') {
      //   throw new Error('payment_frequency_id is required for FIXED scheme type');
      // }
  
      // Step 3: Prepare insert data
      const data = {
        SCHEMENAME: schemeData.SCHEMENAME,
        SCHEMETYPE: schemeData.SCHEMETYPE,
        SCHEMENO: schemeData.SCHEMENO,
        REGNO: schemeData.REGNO,
        ACTIVE: schemeData.ACTIVE || 'Y',
        BRANCHID: schemeData.BRANCHID,
        INS_TYPE: schemeData.INS_TYPE,
        DESCRIPTION: schemeData.DESCRIPTION || null,
        SLOGAN: schemeData.SLOGAN || null,
        IMAGE: schemeData.IMAGE || null,
        ICON: schemeData.ICON || null,
        fixed: schemeData.fixed || null,
        duration_months: schemeData.duration_months,
        type: schemeData.type || 'gold',
        scheme_plan_type_id: schemeData.scheme_plan_type_id,
        //payment_frequency_id: schemeData.SCHEMETYPE === 'FIXED' ? schemeData.payment_frequency_id : null,
      };
  
      // Step 4: Run query
      const sql = "INSERT INTO schemes SET ?";
      const [result] = await db.query(sql, data)
  
      return {
        success: true,
        message: 'Scheme created successfully',
        insertId: result.insertId,
      };
    } catch (error) {
      console.error('Error creating scheme:', error.message);
  logger.error(error)
      return {
        success: false,
        message: 'Failed to create scheme',
        error: error.message,
      };
    }
  },

createSchemeAndChits: async (schemeData) => {
  console.log("schemeData", JSON.stringify(schemeData));
  const connection = await db.getConnection();

  try {
    await connection.beginTransaction();

    // Step 1: Validate required scheme fields
    const requiredFields = ['SCHEMENAME', 'SCHEMETYPE', 'SCHEMENO', 'REGNO', 'BRANCHID', 'INS_TYPE', 'duration_months', 'scheme_plan_type_id'];
    const missingFields = requiredFields.filter(field => !schemeData[field]);

    if (missingFields.length > 0) {
      throw new Error(`Missing required scheme fields: ${missingFields.join(', ')}`);
    }

    // Step 2: Prepare scheme insert data
    const data = {
      SCHEMENAME: schemeData.SCHEMENAME,
      SCHEMETYPE: schemeData.SCHEMETYPE,
      SCHEMENO: schemeData.SCHEMENO,
      REGNO: schemeData.REGNO,
      ACTIVE: schemeData.ACTIVE || 'Y',
      BRANCHID: schemeData.BRANCHID,
      INS_TYPE: schemeData.INS_TYPE,
      DESCRIPTION: schemeData.DESCRIPTION || null,
      SLOGAN: schemeData.SLOGAN || null,
      IMAGE: schemeData.IMAGE || null,
      ICON: schemeData.ICON || null,
      fixed: schemeData.fixed || null,
      duration_months: schemeData.duration_months,
      type: schemeData.type || 'gold',
      scheme_plan_type_id: schemeData.scheme_plan_type_id,
    };

    // Step 3: Insert scheme
    const schemeSql = "INSERT INTO schemes SET ?";
    const [schemeResult] = await connection.query(schemeSql, data);

    if (!schemeResult.insertId) {
      throw new Error("Scheme creation failed");
    }

    // Step 4: Prepare chit data with new Scheme ID
    let chitData = {};
    chitData.SCHEMEID = schemeResult.insertId;
    const { AMOUNT = 0, NOINS = data?.duration_months, payment_frequency = schemeData?.payment_frequency_id, ACTIVE = 'Y' } = chitData;

    if (!Array.isArray(payment_frequency) || payment_frequency.length === 0) {
      throw new Error("Invalid payment frequency data.");
    }

    // Step 5: Insert chits
    const chitSql = "INSERT INTO chits (SchemeId, AMOUNT, NOINS, ACTIVE, payment_frequency) VALUES ?";
    const values = payment_frequency.map(freq => [
      chitData.SCHEMEID, AMOUNT, NOINS, ACTIVE, freq
    ]);

    await connection.query(chitSql, [values]);

    // Commit the transaction if everything is successful
    await connection.commit();

    return { success: true, message: "Scheme and chits created successfully." };

  } catch (error) {
    // Rollback transaction on any error
    await connection.rollback();
    console.error("Error creating scheme and chits:", error);
    return { success: false, message: "Transaction failed, scheme and chits rolled back", error: error.message };
  } finally {
    connection.release();
  }
},
updateSchemeAndAddChits: async (schemeId, schemeData) => {
  console.log("Updating scheme and adding new chits for SchemeId:", schemeId);
  const connection = await db.getConnection();

  try {
    await connection.beginTransaction();

    // Step 1: Validate scheme existence
    const [schemeCheck] = await connection.query("SELECT * FROM schemes WHERE id = ?", [schemeId]);
    if (schemeCheck.length === 0) {
      throw new Error("Scheme not found");
    }

    // Step 2: Validate required fields in schemeData
    const requiredFields = ['SCHEMENAME', 'SCHEMETYPE', 'SCHEMENO', 'REGNO', 'BRANCHID', 'INS_TYPE', 'duration_months', 'scheme_plan_type_id'];
    const missingFields = requiredFields.filter(field => !schemeData[field]);

    if (missingFields.length > 0) {
      throw new Error(`Missing required scheme fields: ${missingFields.join(', ')}`);
    }
      const data = {
      SCHEMENAME: schemeData.SCHEMENAME,
      SCHEMETYPE: schemeData.SCHEMETYPE,
      SCHEMENO: schemeData.SCHEMENO,
      REGNO: schemeData.REGNO,
      ACTIVE: schemeData.ACTIVE || 'Y',
      BRANCHID: schemeData.BRANCHID,
      INS_TYPE: schemeData.INS_TYPE,
      DESCRIPTION: schemeData.DESCRIPTION || null,
      SLOGAN: schemeData.SLOGAN || null,
      IMAGE: schemeData.IMAGE || null,
      ICON: schemeData.ICON || null,
      fixed: schemeData.fixed || null,
      duration_months: schemeData.duration_months,
      type: schemeData.type || 'gold',
      scheme_plan_type_id: schemeData.scheme_plan_type_id,
    };

    // Step 3: Update Scheme
    try {
      const schemeUpdateSql = "UPDATE schemes SET ? WHERE id = ?";
      await connection.query(schemeUpdateSql, [data, schemeId]);
    } catch (error) {
      throw new Error(`Scheme update failed: ${error.message}`);
    }
    let chitData={}
    // Step 4: Validate chit data
    const { AMOUNT = 0, NOINS = schemeData?.duration_months, payment_frequency = schemeData?.payment_frequency_id, ACTIVE = 'Y' } = chitData;

    if (!Array.isArray(payment_frequency) || payment_frequency.length === 0) {
      throw new Error("Invalid payment frequency data.");
    }

    // Step 5: Retrieve existing chit payment frequencies (to avoid duplicates)
    const [existingChits] = await connection.query("SELECT payment_frequency FROM chits WHERE SchemeId = ?", [schemeId]);
    const existingFrequencies = existingChits.map(chit => chit.payment_frequency);

    // Step 6: Insert only **new** payment frequencies
    const newPayments = payment_frequency.filter(freq => !existingFrequencies.includes(freq));

    if (newPayments.length > 0) {
      try {
        const chitInsertSql = "INSERT INTO chits (SchemeId, AMOUNT, NOINS, ACTIVE, payment_frequency) VALUES ?";
        const values = newPayments.map(freq => [schemeId, AMOUNT, NOINS, ACTIVE, freq]);
        await connection.query(chitInsertSql, [values]);
      } catch (error) {
        throw new Error(`Failed to insert new chits: ${error.message}`);
      }
    }

    // Step 7: Commit transaction if everything succeeds
    await connection.commit();
    return { success: true, message: "Scheme updated and new chits added successfully." };

  } catch (error) {
    // Step 8: Rollback on failure
    await connection.rollback();
    console.error("Error updating scheme and adding new chits:", error);
    return { success: false, message: "Transaction failed, updates rolled back", error: error.message };
  } finally {
    connection.release();
  }
},



  // Retrieve all schemes along with associated chits (as JSON array)
  getAll: async () => {
    try {
      const sql = `SELECT DISTINCT c.id,
        s.id AS SCHEMEID,
        s.SCHEMENAME,
        spt.name AS SCHEMETYPE,                 
        s.duration_months,
        s.fixed,
        s.scheme_plan_type_id,
        c.payment_frequency as payment_frequency_id ,
        pf.name AS PAYMENTFREQUENCY,
        s.SCHEMENO,
        s.REGNO,
        s.ACTIVE,
        s.BRANCHID,
        s.INS_TYPE,
        s.DESCRIPTION,
        s.SLOGAN,
        s.IMAGE,
        s.ICON,
        c.id AS CHITID,
        c.AMOUNT,
        c.NOINS,
        c.TOTALMEMBERS,
        c.REGNO AS chitREGNO,
        c.ACTIVE AS chitActive,
        c.METID,
        c.GROUPCODE,
        b.id AS branchId,
        b.branchid AS customBranchId,
        b.branch_name AS branchName,
        b.address AS branchAddress,
        b.city AS branchCity,
        b.state AS branchState,
        b.country AS branchCountry,
        b.phone AS branchPhone,
        b.active AS branchActive
      FROM schemes s
      LEFT JOIN chits c ON s.id = c.SchemeId
      LEFT JOIN branches b ON s.BRANCHID = b.branchid
      LEFT JOIN payment_frequencies pf ON c.payment_frequency = pf.id
      LEFT JOIN scheme_plan_types spt on s.scheme_plan_type_id=spt.id
      ORDER BY s.id, c.id DESC`;
  
      const [results] = await db.query(sql);
  
      if (!Array.isArray(results)) {
        throw new Error("Invalid response from database.");
      }
  
      const schemesById = {};
  
      results.forEach((row) => {
        const schemeId = row.SCHEMEID;
  
        // Basic validation
        if (!schemeId || !row.SCHEMETYPE) {
          console.warn(`Skipping invalid scheme row: ${JSON.stringify(row)}`);
          return;
        }
  
        // Initialize the scheme if not already added
        if (!schemesById[schemeId]) {
          schemesById[schemeId] = {
            SCHEMEID: row.SCHEMEID,
            SCHEMENAME: row.SCHEMENAME,
            SCHEMETYPE: row.SCHEMETYPE,
            DURATION_MONTHS: row.duration_months,
            FIXED: row.fixed,
            SCHEME_PLAN_TYPE_ID: row.scheme_plan_type_id,
            
            SCHEMENO: row.SCHEMENO,
            REGNO: row.REGNO,
            ACTIVE: row.ACTIVE,
            BRANCHID: row.BRANCHID,
            INS_TYPE: row.INS_TYPE,
            DESCRIPTION: row.DESCRIPTION,
            SLOGAN: row.SLOGAN,
            IMAGE: row.IMAGE,
            ICON: row.ICON,
            chits: [],
            branch: [],
          };
        }
  
        // Add chit if FIXED and present
        if (row.CHITID !== null) {
          schemesById[schemeId].chits.push({
            CHITID: row.CHITID,
            AMOUNT: row.AMOUNT,
            NOINS: row.NOINS,
            TOTALMEMBERS: row.TOTALMEMBERS,
            REGNO: row.chitREGNO,
            ACTIVE: row.chitActive,
            METID: row.METID,
            GROUPCODE: row.GROUPCODE,
            PAYMENT_FREQUENCY_ID: row.payment_frequency_id,
            PAYMENT_FREQUENCY: row.PAYMENTFREQUENCY,
          });
        }
  
        // Add branch if not already added
        if (row.branchId !== null) {
          const exists = schemesById[schemeId].branch.some(
            (b) => b.branchId === row.branchId
          );
          if (!exists) {
            schemesById[schemeId].branch.push({
              branchId: row.branchId,
              customBranchId: row.customBranchId,
              branchName: row.branchName,
              branchAddress: row.branchAddress,
              branchCity: row.branchCity,
              branchState: row.branchState,
              branchCountry: row.branchCountry,
              branchPhone: row.branchPhone,
              branchActive: row.branchActive,
            });
          }
        }
      });
  
      return Object.values(schemesById);
    } catch (error) {
      console.error("Error in getAll schemes:", error.message);
      logger.error(error);
      throw new Error("Failed to fetch schemes. Please try again later.");
    }
  },
  getschemePlan: async () => {
    try {
      console.log("scheme oa")
        // Fetch Scheme Plan Types
        const schemePlanTypeQuery = `SELECT * FROM scheme_plan_types`;
        const [schemePlanTypeData] = await db.query(schemePlanTypeQuery);

        if (!Array.isArray(schemePlanTypeData)) {
            throw new Error("Invalid response from scheme_plan_types.");
        }

        // Fetch Payment Frequencies
        const paymentFrequencyQuery = `SELECT * FROM payment_frequencies`;
        const [paymentFrequencyData] = await db.query(paymentFrequencyQuery);

        if (!Array.isArray(paymentFrequencyData)) {
            throw new Error("Invalid response from payment_frequencies.");
        }

        // Organize Response Data
        const responseData = {
            scheme_plan_types: schemePlanTypeData, // 🔹 Only scheme plan types
            payment_frequencies: paymentFrequencyData, // 🔹 Only payment frequencies
        };

        return responseData;
    } catch (error) {
        console.error("Error in getSchemePlan:", error.message);
        logger.error(error);
        throw new Error("Failed to fetch scheme plan types and payment frequencies. Please try again later.");
    }
},

  

  getById: async (schemeId) => {
    try {
      const sql = `
        SELECT DISTINCT c.id,
          s.id as SCHEMEID,
          s.SCHEMENAME,
          s.SCHEMETYPE,
          s.duration_months,
          s.fixed,
          s.scheme_plan_type_id,
          st.name AS schemeTypeName,
          c.payment_frequency as payment_frequency_id,
          pf.name AS PAYMENTFREQUENCY,
          s.SCHEMENO,
          s.REGNO,
          s.ACTIVE,
          s.BRANCHID,
          s.INS_TYPE,
          s.DESCRIPTION,
          s.SLOGAN,
          s.IMAGE,
          s.ICON,
          c.id as CHITID,
          c.AMOUNT,
          c.NOINS,
          c.TOTALMEMBERS,
          c.REGNO AS chitREGNO,
          c.ACTIVE AS chitActive,
          c.METID,
          c.GROUPCODE,
          b.id AS branchId,
          b.branchid AS customBranchId,
          b.branch_name AS branchName,
          b.address AS branchAddress,
          b.city AS branchCity,
          b.state AS branchState,
          b.country AS branchCountry,
          b.phone AS branchPhone,
          b.active AS branchActive
        FROM schemes s
        LEFT JOIN chits c ON s.id = c.SchemeId
        LEFT JOIN branches b ON s.BRANCHID = b.branchid
        LEFT JOIN payment_frequencies pf ON c.payment_frequency = pf.id
        LEFT JOIN scheme_plan_types st ON s.scheme_plan_type_id = st.id
        WHERE s.id = ?
        ORDER BY c.id DESC;
      `;
  
      const [results] = await db.query(sql, [schemeId]);
      if (results.length === 0) return null;
  
      const scheme = {
        SCHEMEID: results[0].SCHEMEID,
        SCHEMENAME: results[0].SCHEMENAME,
        SCHEMETYPE: results[0].SCHEMETYPE,
        DURATION_MONTHS: results[0].duration_months,
        FIXED: results[0].fixed,
        SCHEME_PLAN_TYPE_ID: results[0].scheme_plan_type_id,
        SCHEME_TYPE_NAME: results[0].schemeTypeName,
        SCHEMENO: results[0].SCHEMENO,
        REGNO: results[0].REGNO,
        ACTIVE: results[0].ACTIVE,
        BRANCHID: results[0].BRANCHID,
        INS_TYPE: results[0].INS_TYPE,
        DESCRIPTION: results[0].DESCRIPTION,
        SLOGAN: results[0].SLOGAN,
        IMAGE: results[0].IMAGE,
        ICON: results[0].ICON,
        chits: [],
        branch: [],
      };
  
      results.forEach((row) => {
        // Only push chits if scheme is FIXED
        if (row.CHITID !== null) {
          scheme.chits.push({
            CHITID: row.CHITID,
            AMOUNT: row.AMOUNT,
            NOINS: row.NOINS,
            TOTALMEMBERS: row.TOTALMEMBERS,
            REGNO: row.chitREGNO,
            ACTIVE: row.chitActive,
            METID: row.METID,
            GROUPCODE: row.GROUPCODE,
            PAYMENT_FREQUENCY_ID: row.payment_frequency_id,
            PAYMENT_FREQUENCY: row.PAYMENTFREQUENCY,
          });
        }
  
        if (row.branchId !== null) {
          const exists = scheme.branch.some(b => b.branchId === row.branchId);
          if (!exists) {
            scheme.branch.push({
              branchId: row.branchId,
              customBranchId: row.customBranchId,
              branchName: row.branchName,
              branchAddress: row.branchAddress,
              branchCity: row.branchCity,
              branchState: row.branchState,
              branchCountry: row.branchCountry,
              branchPhone: row.branchPhone,
              branchActive: row.branchActive,
            });
          }
        }
      });
  
      return scheme;
    } catch (error) {
      console.error("Error in getById:", error.message);
      logger.error(error);
      throw new Error("Failed to fetch scheme details. Please try again later.");
    }
  },
  

  // Update a scheme record by SCHEMEID
  update: async (schemeId, schemeData) => {
    try {
      console.log("schemedata",JSON.stringify(schemeData),schemeData.SCHEMENAME)
      const [existingScheme] = await db.query("SELECT IMAGE, ICON FROM schemes WHERE id = ?", [schemeId]);
  
      if (!existingScheme || existingScheme.length === 0) {
        throw new Error("Scheme not found");
      }
  
      // Validation
      if (!schemeData.SCHEMENAME || !schemeData.SCHEMETYPE || !schemeData.duration_months || !schemeData.scheme_plan_type_id) {
        throw new Error("Missing required fields: SCHEMENAME, SCHEMETYPE, duration_months, scheme_plan_type_id, or payment_frequency_id");
      }
  //  // Conditional validation: payment_frequency_id is required ONLY if scheme_plan_type_id === 1
  //  if (parseInt(schemeData.scheme_plan_type_id) === 1 && !schemeData.payment_frequency_id) {
  //   throw new Error("Missing required field: payment_frequency_id is mandatory when scheme_plan_type_id is 1");
  // }

      // Construct update payload
      const data = {
        SCHEMENAME: schemeData.SCHEMENAME,
        SCHEMETYPE: schemeData.SCHEMETYPE.toUpperCase(),
        SCHEMENO: schemeData.SCHEMENO,
        REGNO: schemeData.REGNO,
        ACTIVE: schemeData.ACTIVE,
        BRANCHID: schemeData.BRANCHID,
        INS_TYPE: schemeData.INS_TYPE,
        DESCRIPTION: schemeData.DESCRIPTION,
        SLOGAN: schemeData.SLOGAN,
        fixed: schemeData.fixed !== undefined ? schemeData.fixed : null, // decimal(10,2)
        duration_months: schemeData.duration_months,
        scheme_plan_type_id: schemeData.scheme_plan_type_id,
        IMAGE: schemeData.IMAGE || existingScheme[0].IMAGE || "/uploads/astalakshmi.png",
        ICON: schemeData.ICON || existingScheme[0].ICON || "/uploads/saveasgoldproduct.png",
      };
  
      const sql = "UPDATE schemes SET ? WHERE id = ?";
      const [result] = await db.query(sql, [data, schemeId]);
  
      if (result.affectedRows === 0) {
        throw new Error("Failed to update scheme.");
      }
  
      return result;
    } catch (err) {
      logger.error(err)
      console.error("Error updating scheme:", err.message);
      throw err;
    }
  },  

  // Delete a scheme record by SCHEMEID
  delete: async (schemeId) => {
    try {
      // Validate that the scheme exists
      const [existing] = await db.query("SELECT id FROM schemes WHERE id = ?", [schemeId]);
      if (!existing || existing.length === 0) {
        throw new Error("Scheme not found or already deleted.");
      }
  
      // Soft delete the scheme
      const schemeUpdateSql = "UPDATE schemes SET ACTIVE = 'N', DELETED_AT = NOW() WHERE id = ?";
      const [schemeResult] = await db.query(schemeUpdateSql, [schemeId]);
  
      if (schemeResult.affectedRows === 0) {
        throw new Error("Failed to update scheme status.");
      }
  
      // Attempt to soft delete associated chits (if any)
      const chitUpdateSql = "UPDATE chits SET ACTIVE = 'N' WHERE SchemeId  = ?";
      const [chitResult] = await db.query(chitUpdateSql, [schemeId]);
  
      return {
        message:
          chitResult.affectedRows > 0
            ? "Scheme and associated chits soft-deleted successfully"
            : "Scheme soft-deleted successfully (no associated chits)",
        schemeUpdated: schemeResult.affectedRows,
        chitsUpdated: chitResult.affectedRows,
      };
  
    } catch (error) {
      console.error("Error soft-deleting scheme:", error);
      logger.error(error);
      throw error;
    }
  },
  
  
  // New helper to get noofinstallments by chitid
  getInstype: async (schemeid) => {
    const sql = "SELECT * FROM schemes WHERE id = ?";
    const [rows] = await db.query(sql, [schemeid]);
    return rows.length > 0 ? rows[0].INS_TYPE : null;
  },

  getActiveSchemes: async () => {
    const connection = await db.getConnection();
    try {
      const [rows] = await connection.query(
        `SELECT 
          s.id,
          s.SCHEMENAME as schemeName,
          s.SCHEMETYPE as type,
          s.DESCRIPTION as description,
          s.IMAGE as image,
          s.ICON as icon,
          s.scheme_plan_type_id,
          s.ACTIVE as status,
          s.created_at,
          s.updated_at,
          spt.name as plan_type_name
        FROM schemes s
        LEFT JOIN scheme_plan_types spt ON s.scheme_plan_type_id = spt.id
        WHERE s.ACTIVE = 'Y' 
        ORDER BY s.created_at DESC`
      );
      return rows;
    } catch (error) {
      logger.error('Error getting active schemes:', error);
      throw error;
    } finally {
      connection.release();
    }
  }
};

module.exports = Scheme;
