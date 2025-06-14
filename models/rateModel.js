const db = require("../config/db");
const logger = require("../middlewares/logger");

const Rate = {
  // Create a new rate record, enforcing only one active record at a time.
  create: async (data) => {
    // if (data.status && data.status.toLowerCase() === "active") {
    const updateSql =
      "UPDATE rates SET status = 'inactive' WHERE status = 'active'";
    await db.query(updateSql);
    // }
    const sql = "INSERT INTO rates SET ?";
    const [result] = await db.query(sql, data);
    return result;
  },

  // Retrieve all rate records (history) ordered by created_at descending
  getAll: async () => {
    const sql = "SELECT * FROM rates ORDER BY created_at DESC";
    const [results] = await db.query(sql);
    return results;
  },

  // Retrieve a rate record by its id
  getById: async (id) => {
    const sql = "SELECT * FROM rates WHERE id = ?";
    const [results] = await db.query(sql, [id]);
    if (results.length === 0) return null;
    return results[0];
  },

  // Retrieve the current active rate record
  getCurrent: async () => {
    console.log("getCurrent((((((((((((((((((((((()))))))))))))))))))))))))");
    const sql =
      "SELECT * FROM rates WHERE status = 'active' ORDER BY updated_at DESC LIMIT 1";
    const [results] = await db.query(sql);
    if (results.length === 0) return null;
    console.log(results[0]);
    return results[0];
  },

  // Update a rate record by id, enforcing one active record if updated status is active.
  update: async (id, data) => {
    if (data.status && data.status.toLowerCase() === "active") {
      const updateOthersSql =
        "UPDATE rates SET status = 'inactive' WHERE id != ? AND status = 'active'";
      await db.query(updateOthersSql, [id]);
    }
    const sql = "UPDATE rates SET ? WHERE id = ?";
    const [result] = await db.query(sql, [data, id]);
    return result;
  },

  // Delete a rate record by id
  delete: async (id) => {
    const sql = "DELETE FROM rates WHERE id = ?";
    const [result] = await db.query(sql, [id]);
    return result;
  },

  getCurrentRates: async () => {
    const connection = await db.getConnection();
    try {
      const [rows] = await connection.query(
        `SELECT 
          id,
          gold_rate,
          silver_rate,
          status,
          created_at,
          updated_at
        FROM rates 
        WHERE status = 'active' 
        ORDER BY updated_at DESC 
        LIMIT 1`
      );
      return rows[0] || null;
    } catch (error) {
      logger.error('Error getting current rates:', error);
      throw error;
    } finally {
      connection.release();
    }
  }
};

module.exports = Rate;
