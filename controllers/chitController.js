const Chit = require("../models/chitModel");

exports.createChit = async (req, res) => {
  try {
    const result = await Chit.create(req.body);
    res.json({ message: "Chit created successfully", result });
  } catch (err) {
    console.error("Error creating chit:", err);
    res.status(500).json({ error: err.sqlMessage || err });
  }
};

exports.getAllChits = async (req, res) => {
  try {
    const results = await Chit.getAll();
    res.json({ data: results, status: 200 });
  } catch (err) {
    res.status(500).json({ error: err.sqlMessage || err });
  }
};

exports.getChitById = async (req, res) => {
  try {
    const chitId = req.params.id;
    const result = await Chit.getById(chitId);
    if (!result) {
      return res.status(404).json({ message: "Chit not found" });
    }
    res.json(result);
  } catch (err) {
    res.status(500).json({ error: err.sqlMessage || err });
  }
};

exports.updateChit = async (req, res) => {
  try {
    const chitId = req.params.id;
    const result = await Chit.update(chitId, req.body);
    res.json({ message: "Chit updated successfully", result });
  } catch (err) {
    res.status(500).json({ error: err.sqlMessage || err });
  }
};

exports.deleteChit = async (req, res) => {
  try {
    const chitId = req.params.id;
    const result = await Chit.delete(chitId);
    res.json({ message: "Chit deleted successfully", result });
  } catch (err) {
    res.status(500).json({ error: err.sqlMessage || err });
  }
};
