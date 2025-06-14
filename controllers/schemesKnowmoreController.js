// controllers/schemesKnowmoreController.js
const schemeModel = require("../models/schemesKnowmoreModel");

exports.createSchemeKnowmore = async (req, res) => {
  console.log(req.body);
  try {
    const { scheme_id, title, subtitle, description, status } = req.body;
    // If an image file is uploaded, save its path; otherwise, null.
    const image = req.file ? `/uploads/${req.file.filename}` : null;
    const schemeData = {
      scheme_id,
      title,
      subtitle,
      description,
      image,
      status,
    };
    console.log(schemeData);
    const result = await schemeModel.createScheme(schemeData);
    res.status(201).json({
      success: true,
      data: { id: result.insertId, ...schemeData },
      message: "SchemeKnowmore created successfully",
    });
  } catch (error) {
    console.error("Error creating schemeKnowmore:", error);
    res
      .status(500)
      .json({ success: false, data: null, message: "Server error" });
  }
};

exports.getAllSchemeKnowmore = async (req, res) => {
  try {
    const schemes = await schemeModel.getAllSchemes();
    res.status(200).json({
      success: true,
      data: schemes,
      message: "SchemesKnowmore fetched successfully",
    });
  } catch (error) {
    console.error("Error fetching schemesKnowmore:", error);
    res
      .status(500)
      .json({ success: false, data: null, message: "Server error" });
  }
};

exports.getSchemeKnowmoreById = async (req, res) => {
  try {
    const { id } = req.params;
    const results = await schemeModel.getSchemeById(id);
    if (!results || results.length === 0) {
      return res.status(404).json({
        success: false,
        data: null,
        message: "SchemeKnowmore not found",
      });
    }
    res.status(200).json({
      success: true,
      data: results[0],
      message: "SchemeKnowmore fetched successfully",
    });
  } catch (error) {
    console.error("Error fetching schemeKnowmore by id:", error);
    res
      .status(500)
      .json({ success: false, data: null, message: "Server error" });
  }
};

exports.getSchemeKnowmoreBySchemeId = async (req, res) => {
  try {
    const { scheme_id } = req.params;
    const results = await schemeModel.getSchemeBySchemeId(scheme_id);
    if (!results || results.length === 0) {
      return res.status(404).json({
        success: false,
        data: null,
        message: "No SchemeKnowmore found for this scheme_id",
      });
    }
    res.status(200).json({
      success: true,
      data: results,
      message: "SchemeKnowmore details retrieved successfully",
    });
  } catch (error) {
    console.error("Error fetching schemeKnowmore by scheme_id:", error);
    res
      .status(500)
      .json({ success: false, data: null, message: "Server error" });
  }
};

exports.updateSchemeKnowmore = async (req, res) => {
  try {
    const { id } = req.params;
    const { scheme_id, title, subtitle, description, status } = req.body;
    // If a new image is uploaded, update the image path.
    const image = req.file ? `/uploads/${req.file.filename}` : undefined;
    let schemeData = { scheme_id, title, subtitle, description, status };
    if (image !== undefined) {
      schemeData.image = image;
    }
    const result = await schemeModel.updateScheme(id, schemeData);
    if (result.affectedRows === 0) {
      return res.status(404).json({
        success: false,
        data: null,
        message: "SchemeKnowmore not found",
      });
    }
    res.status(200).json({
      success: true,
      data: { id, ...schemeData },
      message: "SchemeKnowmore updated successfully",
    });
  } catch (error) {
    console.error("Error updating schemeKnowmore:", error);
    res
      .status(500)
      .json({ success: false, data: null, message: "Server error" });
  }
};

exports.deleteSchemeKnowmore = async (req, res) => {
  try {
    const { id } = req.params;
    const result = await schemeModel.deleteScheme(id);
    if (result.affectedRows === 0) {
      return res.status(404).json({
        success: false,
        data: null,
        message: "SchemeKnowmore not found",
      });
    }
    res.status(200).json({
      success: true,
      data: null,
      message: "SchemeKnowmore deleted successfully",
    });
  } catch (error) {
    console.error("Error deleting schemeKnowmore:", error);
    res
      .status(500)
      .json({ success: false, data: null, message: "Server error" });
  }
};
