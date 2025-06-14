const db = require("../config/db");

const Chit = {
  // Create a new chit
  // create: async (chitData) => {
  //   const data = {
  //     id: chitData.id,
  //     SchemeId: chitData.SCHEMEID,
  //     AMOUNT: chitData.AMOUNT,
  //     NOINS: chitData.NOINS,
  //     TOTALMEMBERS: chitData.TOTALMEMBERS,
  //     REGNO: chitData.REGNO,
  //     ACTIVE: chitData.ACTIVE||'Y',
  //     METID: chitData.METID,
  //     GROUPCODE: chitData.GROUPCODE,
  //   };

  //   const sql = "INSERT INTO chits SET ?";
  //   const [result] = await db.query(sql, data);
  //   return result;
  // },
  create: async (chitData) => {
  const connection = await db.getConnection();

  try {
    await connection.beginTransaction();

    const { SCHEMEID, AMOUNT, NOINS, TOTALMEMBERS, REGNO, ACTIVE, METID, GROUPCODE, payment_frequency } = chitData;

    if (!Array.isArray(payment_frequency) || payment_frequency.length === 0) {
      throw new Error("Invalid payment frequency data.");
    }

    const sql = "INSERT INTO chits (SchemeId, AMOUNT, NOINS, TOTALMEMBERS, REGNO, ACTIVE, METID, GROUPCODE, payment_frequency) VALUES ?";
    const values = payment_frequency.map(freq => [
      SCHEMEID, AMOUNT, NOINS, TOTALMEMBERS, REGNO, ACTIVE || 'Y', METID, GROUPCODE, freq
    ]);

    await connection.query(sql, [values]);
    await connection.commit();

    return { success: true, message: "Chits created successfully." };
  } catch (error) {
    await connection.rollback();
    console.error("Error creating chits:", error);
    return { error: true, message: "Database error occurred." };
  } finally {
    connection.release();
  }
},


  // Retrieve all chits
  getAll: async () => {
    const sql = `
      SELECT c.*, s.SCHEMENAME 
      FROM chits c 
      LEFT JOIN schemes s ON c.SchemeId = s.id order by c.id desc
    `;
    const [results] = await db.query(sql);
    return results;
  },

  // Retrieve a single chit by id
  getById: async (id) => {
    const sql = `
      SELECT c.*, s.SCHEMENAME 
      FROM chits c 
      LEFT JOIN schemes s ON c.SchemeId = s.id 
      WHERE c.id = ? order by c.id desc
    `;
    const [results] = await db.query(sql, [id]);
    if (results.length === 0) return null;
    return results[0];
  },
  // New helper to get noofinstallments by id
  getNoOfInstallments: async (id) => {
    const sql = "SELECT * FROM chits WHERE id = ?";
    const [rows] = await db.query(sql, [id]);
    return rows.length > 0 ? rows[0].NOINS : null;
  },
  // Update a chit by id
  // update: async (id, updateData) => {
  //   const data = {
  //     SchemeId: updateData.SCHEMEID,
  //     AMOUNT: updateData.AMOUNT,
  //     NOINS: updateData.NOINS,
  //     TOTALMEMBERS: updateData.TOTALMEMBERS,
  //     REGNO: updateData.REGNO,
  //     ACTIVE: updateData.ACTIVE,
  //     METID: updateData.METID,
  //     GROUPCODE: updateData.GROUPCODE,
  //   };

  //   const sql = "UPDATE chits SET ? WHERE id = ?";
  //   const [result] = await db.query(sql, [data, id]);
  //   return result;
  // },
update: async (id, updateData) => {
    const connection = await db.getConnection();
  
    try {
        await connection.beginTransaction();

        const data = {
            SchemeId: updateData.SCHEMEID,
            AMOUNT: updateData.AMOUNT,
            NOINS: updateData.NOINS,
            TOTALMEMBERS: updateData.TOTALMEMBERS,
            REGNO: updateData.REGNO,
            ACTIVE: updateData.ACTIVE,
            METID: updateData.METID,
            GROUPCODE: updateData.GROUPCODE,
            "payment_frequency": updateData.payment_frequency
        };

        // Step 1: Update base chit details
        const sql = "UPDATE chits SET ? WHERE id = ?";
        await connection.query(sql, [data, id]);

        
        

        await connection.commit();
        return { success: true, message: "Chit updated successfully with payment frequencies." };

    } catch (error) {
        await connection.rollback();
        console.error("Error updating chit:", error);
        return { error: true, message: "Database error occurred." };
    } finally {
        connection.release();
    }
},

  // Delete a chit by id
  delete: async (id) => {
    const sql = "DELETE FROM chits WHERE id = ?";
    const [result] = await db.query(sql, [id]);
    return result;
  },
};

module.exports = Chit;
