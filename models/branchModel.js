const db = require("../config/db");

const Branch = {
  // Create a new branch record
  create: async (branchData) => {
    const data = {
      branchid: branchData.branchid, // Custom branch identifier
      branch_name: branchData.branch_name,
      address: branchData.address,
      city: branchData.city,
      state: branchData.state,
      country: branchData.country || "India",
      phone: branchData.phone,
      active: branchData.active || "Y",
    };

    const sql = "INSERT INTO branches SET ?";
    const [result] = await db.query(sql, data);
    return result;
  },

  // Retrieve all branches
  getAll: async () => {
    const sql = "SELECT * FROM branches";
    const [results] = await db.query(sql);
    return results;
  },

  // Retrieve a branch by its auto-increment id
  getById: async (id) => {
    const sql = "SELECT * FROM branches WHERE id = ?";
    const [results] = await db.query(sql, [id]);
    if (results.length === 0) return null;
    return results[0];
  },

  // Update a branch record by id
  update: async (id, branchData) => {
    const data = {
      branchid: branchData.branchid,
      branch_name: branchData.branch_name,
      address: branchData.address,
      city: branchData.city,
      state: branchData.state,
      country: branchData.country,
      phone: branchData.phone,
      active: branchData.active,
    };

    const sql = "UPDATE branches SET ? WHERE id = ?";
    const [result] = await db.query(sql, [data, id]);
    return result;
  },

  // Delete a branch record by id
  delete: async (id) => {
    const sql = "DELETE FROM branches WHERE id = ?";
    const [result] = await db.query(sql, [id]);
    return result;
  },
};

module.exports = Branch;
