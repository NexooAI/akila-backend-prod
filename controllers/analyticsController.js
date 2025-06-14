const Analytics = require("../models/analyticsModel");

exports.getAnalyticsCounts = async (req, res) => {
  try {
    const counts = await Analytics.getCounts();
    res.status(200).json({ data: counts });
  } catch (error) {
    console.error("Error fetching analytics counts:", error);
    res.status(500).json({ error: error.sqlMessage || error.message });
  }
};
