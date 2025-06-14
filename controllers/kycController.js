// controllers/kycController.js
const Kyc = require("../models/kycModel");

// Create a new KYC record
exports.createKyc = async (req, res) => {
  try {
    const result = await Kyc.create(req.body);
    res.status(201).json({
      message: "KYC record created successfully",
      data: result,
    });
  } catch (err) {
    console.error("Error creating KYC record:", err);
    res.status(500).json({ error: "Failed to create KYC record" });
  }
};

// Get all KYC records
exports.getAllKyc = async (req, res) => {
  try {
    const records = await Kyc.getAll();
    res.status(200).json({ data: records });
  } catch (err) {
    console.error("Error fetching KYC records:", err);
    res.status(500).json({ error: "Failed to fetch KYC records" });
  }
};

// Get a single KYC record by id
exports.getKycById = async (req, res) => {
  try {
    const id = req.params.id;
    const record = await Kyc.getById(id);
    if (!record) {
      return res.status(404).json({ message: "KYC record not found" });
    }
    res.status(200).json({ data: record });
  } catch (err) {
    console.error("Error fetching KYC record:", err);
    res.status(500).json({ error: "Failed to fetch KYC record" });
  }
};

// Update a KYC record by id
exports.updateKyc = async (req, res) => {
  try {
    const id = req.params.id;
    const result = await Kyc.update(id, req.body);
    res.status(200).json({
      message: "KYC record updated successfully",
      data: result,
    });
  } catch (err) {
    console.error("Error updating KYC record:", err);
    res.status(500).json({ error: "Failed to update KYC record" });
  }
};
exports.getKycStatus = async (req, res) => {
  try {
    const userId = req.params.user_id;
    const status = await Kyc.getStatusAndDataByUserId(userId);
    res
      .status(200)
      .json({ user_id: userId, kyc_status: status.status, data: status.data });
  } catch (err) {
    console.error("Error fetching KYC status:", err);
    res.status(500).json({ error: "Failed to fetch KYC status" });
  }
};
// Delete a KYC record by id
exports.deleteKyc = async (req, res) => {
  try {
    const id = req.params.id;
    const result = await Kyc.delete(id);
    res.status(200).json({
      message: "KYC record deleted successfully",
      data: result,
    });
  } catch (err) {
    console.error("Error deleting KYC record:", err);
    res.status(500).json({ error: "Failed to delete KYC record" });
  }
};
