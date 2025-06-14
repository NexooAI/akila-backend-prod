// controllers/policyController.js
const Policy = require("../models/policyModel");

// ✅ Create policy controller
exports.createPolicy = async (req, res) => {
  try {
    const result = await Policy.create(req.body);
    res.status(201).json({
      success: true,
      message: "Policy created successfully",
      data: result,
    });
  } catch (error) {
    console.error("Error creating policy:", error);
    res.status(500).json({
      success: false,
      message: error.sqlMessage || "Internal Server Error",
    });
  }
};

// ✅ Get all policies
exports.getAllPolicies = async (req, res) => {
  try {
    const policies = await Policy.getAll();
    res.status(200).json({
      success: true,
      data: policies,
    });
  } catch (error) {
    console.error("Error fetching policies:", error);
    res.status(500).json({
      success: false,
      message: error.sqlMessage || "Internal Server Error",
    });
  }
};

// ✅ Get policy by ID
exports.getPolicyById = async (req, res) => {
  try {
    const policy = await Policy.getById(req.params.id);
    if (!policy) {
      return res.status(404).json({
        success: false,
        message: "Policy not found",
      });
    }
    res.status(200).json({
      success: true,
      data: policy,
    });
  } catch (error) {
    console.error("Error fetching policy:", error);
    res.status(500).json({
      success: false,
      message: error.sqlMessage || "Internal Server Error",
    });
  }
};

// ✅ Get policies by type
exports.getPoliciesByType = async (req, res) => {
  try {
    const policies = await Policy.getByType(req.params.type);
    res.status(200).json({
      success: true,
      data: policies,
    });
  } catch (error) {
    console.error("Error fetching policies by type:", error);
    res.status(500).json({
      success: false,
      message: error.sqlMessage || "Internal Server Error",
    });
  }
};

// ✅ Update policy
exports.updatePolicy = async (req, res) => {
  try {
    const result = await Policy.update(req.params.id, req.body);
    res.status(200).json({
      success: true,
      message: "Policy updated successfully",
      data: result,
    });
  } catch (error) {
    console.error("Error updating policy:", error);
    res.status(500).json({
      success: false,
      message: error.sqlMessage || "Internal Server Error",
    });
  }
};

// ✅ Delete policy
exports.deletePolicy = async (req, res) => {
  try {
    const result = await Policy.delete(req.params.id);
    res.status(200).json({
      success: true,
      message: "Policy deleted successfully",
      data: result,
    });
  } catch (error) {
    console.error("Error deleting policy:", error);
    res.status(500).json({
      success: false,
      message: error.sqlMessage || "Internal Server Error",
    });
  }
};
