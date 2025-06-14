// models/policyModel.js
const db = require("../config/db");

const Policy = {
  // ✅ Create policy and mark old as inactive (with transactions)
  create: async (policyData) => {
    const { type, title, subtitle, description } = policyData;

    let connection;
    try {
      connection = await db.getConnection(); // Get a connection
      await connection.beginTransaction(); // Start transaction

      // Mark existing policies as inactive
      await connection.query(
        "UPDATE policies SET status = 'inactive' WHERE type = ?",
        [type]
      );

      // Insert new policy as active
      const sql = `
        INSERT INTO policies (type, title, subtitle, description, status)
        VALUES (?, ?, ?, ?, 'active')
      `;
      const [result] = await connection.query(sql, [
        type,
        title,
        subtitle,
        description,
      ]);

      await connection.commit(); // ✅ Commit the transaction
      return { id: result.insertId, type, title, subtitle, description };
    } catch (error) {
      if (connection) await connection.rollback(); // 🔴 Rollback if error occurs
      throw error;
    } finally {
      if (connection) connection.release(); // ✅ Release connection
    }
  },

  // ✅ Get all active policies
  getAll: async () => {
    const sql =
      "SELECT * FROM policies WHERE status = 'active' ORDER BY created_at DESC";
    const [results] = await db.query(sql);
    return results.map(Policy.format);
  },

  // ✅ Get policy by ID
  getById: async (id) => {
    const sql = "SELECT * FROM policies WHERE id = ?";
    const [results] = await db.query(sql, [id]);
    if (results.length === 0) return null;
    return Policy.format(results[0]);
  },

  // Retrieve a single active policy by type
  getByType: async (policyType) => {
    const sql = `
    SELECT * FROM policies 
    WHERE type = ? AND status = 'active' 
    ORDER BY created_at DESC 
    LIMIT 1`; // Return only the latest record
    const [results] = await db.query(sql, [policyType]);
    return results.length ? Policy.format(results[0]) : null;
  },

  // ✅ Update a policy by ID
  update: async (id, policyData) => {
    const { type, title, subtitle, description } = policyData;
    const sql = `
      UPDATE policies
      SET type = ?, title = ?, subtitle = ?, description = ?
      WHERE id = ?
    `;
    const [result] = await db.query(sql, [
      type,
      title,
      subtitle,
      description,
      id,
    ]);
    return result;
  },

  // ✅ Delete policy by ID
  delete: async (id) => {
    const sql = "DELETE FROM policies WHERE id = ?";
    const [result] = await db.query(sql, [id]);
    return result;
  },

  // ✅ Format policy object
  format: (policy) => ({
    id: policy.id,
    type: policy.type,
    title: policy.title,
    subtitle: policy.subtitle,
    description: policy.description,
    status: policy.status,
    createdAt: policy.created_at,
  }),
};

module.exports = Policy;
