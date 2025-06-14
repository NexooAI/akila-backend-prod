const Rate = require("../models/rateModel");

exports.createRate = async (req, res) => {
  try {
    const result = await Rate.create(req.body, (req.body.status = "active"));
    res.json({ message: "Rate created successfully", result });
  } catch (err) {
    console.error("Error creating rate:", err);
    res.status(500).json({ error: err.sqlMessage || err });
  }
};

exports.getAllRates = async (req, res) => {
  try {
    const rates = await Rate.getAll();
    res.json({ data: rates, status: 200 });
  } catch (err) {
    res.status(500).json({ error: err.sqlMessage || err });
  }
};

exports.getRateById = async (req, res) => {
  const id = req.params.id;
  try {
    const rate = await Rate.getById(id);
    if (!rate) {
      return res.status(404).json({ message: "Rate not found" });
    }
    res.json({ data: rate, status: 200 });
  } catch (err) {
    res.status(500).json({ error: err.sqlMessage || err });
  }
};

exports.getCurrentRate = async (req, res) => {
  try {
    const rate = await Rate.getCurrent();
    if (!rate) {
      return res.status(404).json({ message: "Current rate not found" });
    }
    res.json({ data: rate, status: 200 });
  } catch (err) {
    res.status(500).json({ error: err.sqlMessage || err });
  }
};

exports.updateRate = async (req, res) => {
  const id = req.params.id;
  try {
    const result = await Rate.update(id, req.body);
    res.json({ message: "Rate updated successfully", result });
  } catch (err) {
    res.status(500).json({ error: err.sqlMessage || err });
  }
};

exports.deleteRate = async (req, res) => {
  const id = req.params.id;
  try {
    const result = await Rate.delete(id);
    res.json({ message: "Rate deleted successfully", result });
  } catch (err) {
    res.status(500).json({ error: err.sqlMessage || err });
  }
};
