const Branch = require("../models/branchModel");

exports.createBranch = async (req, res) => {
  try {
    const result = await Branch.create(req.body);
    res.json({ message: "Branch created successfully", result });
  } catch (err) {
    console.error("Error creating branch:", err);
    res.status(500).json({ error: err.sqlMessage || err });
  }
};

exports.getAllBranches = async (req, res) => {
  try {
    const branches = await Branch.getAll();
    res.json({ data: branches, status: 200 });
  } catch (err) {
    res.status(500).json({ error: err.sqlMessage || err });
  }
};

exports.getBranchById = async (req, res) => {
  const id = req.params.id;
  try {
    const branch = await Branch.getById(id);
    if (!branch) return res.status(404).json({ message: "Branch not found" });
    res.json(branch);
  } catch (err) {
    res.status(500).json({ error: err.sqlMessage || err });
  }
};

exports.updateBranch = async (req, res) => {
  const id = req.params.id;
  try {
    const result = await Branch.update(id, req.body);
    res.json({ message: "Branch updated successfully", result });
  } catch (err) {
    res.status(500).json({ error: err.sqlMessage || err });
  }
};

exports.deleteBranch = async (req, res) => {
  const id = req.params.id;
  try {
    const result = await Branch.delete(id);
    res.json({ message: "Branch deleted successfully", result });
  } catch (err) {
    res.status(500).json({ error: err.sqlMessage || err });
  }
};
