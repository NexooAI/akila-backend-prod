const db = require("../config/db");

const Analytics = {
  getCounts: async () => {
    const sql = `
      SELECT
        (SELECT COUNT(*) FROM users) AS total_users,
        (SELECT COUNT(*) FROM kyc) AS total_kyc,
        (SELECT COUNT(*) FROM investments) AS total_investments,
        (SELECT COUNT(*) FROM payments) AS total_payments,
        (SELECT COUNT(*) FROM offers) AS total_offers,
        (SELECT COUNT(*) FROM policies) AS total_policies,
        (SELECT COUNT(*) FROM branches) AS total_branches,
        (SELECT COUNT(*) FROM schemes) AS total_schemes,
        (SELECT COUNT(*) FROM chits) AS total_chits
    `;
    const [rows] = await db.query(sql);
    return rows[0];
  },
};

module.exports = Analytics;
