// models/kycModel.js
const db = require("../config/db");

const Kyc = {
  // Create a new KYC record
  create: async (data) => {
    const sql = "INSERT INTO kyc SET ?";
    const [result] = await db.query(sql, data);
    return result;
  },

  // Retrieve all KYC records
  getAll: async () => {
    const sql = "SELECT * FROM kyc";
    const [rows] = await db.query(sql);
    return rows;
  },

  // Retrieve a single KYC record by id
  getById: async (id) => {
    const sql = "SELECT * FROM kyc WHERE id = ?";
    const [rows] = await db.query(sql, [id]);
    if (rows.length === 0) return null;
    return rows[0];
  },

  // Update a KYC record by id
  update: async (id, data) => {
    const sql = "UPDATE kyc SET ? WHERE id = ?";
    const [result] = await db.query(sql, [data, id]);
    return result;
  },
  getStatusAndDataByUserId: async (userId) => {
    const sql = "SELECT * FROM kyc WHERE user_id = ?";
    const [rows] = await db.query(sql, [userId]);
    if (rows.length > 0) {
      return { status: "Completed", data: rows[0] };
    } else {
      return { status: "Not Completed", data: null };
    }
  },
  // Delete a KYC record by id
  delete: async (id) => {
    const sql = "DELETE FROM kyc WHERE id = ?";
    const [result] = await db.query(sql, [id]);
    return result;
  },
};

module.exports = Kyc;
