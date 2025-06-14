const { json } = require("express");
const Scheme = require("../models/schemeModel");

// exports.createScheme = async (req, res) => {
//   try {
//     const result = await Scheme.create(req.body);
//     res.json({
//       message: "Scheme created successfully",
//       data: result,
//       status: 200,
//     });
//   } catch (err) {
//     console.error("Error creating scheme:", err);
//     res.status(500).json({ error: err.sqlMessage || err });
//   }
// };
exports.createScheme = async (req, res) => {
  try {
    const {
      SCHEMENAME,
      SCHEMETYPE,
      SCHEMENO,
      REGNO,
      ACTIVE,
      BRANCHID,
      INS_TYPE,
      DESCRIPTION,
      SLOGAN,
      fixed,
      duration_months,
      type,
      scheme_plan_type_id,
      payment_frequency_id,
    } = req.body;

    // Validate required fields
    const requiredFields = ['SCHEMENAME', 'SCHEMETYPE', 'SCHEMENO', 'REGNO', 'BRANCHID', 'INS_TYPE', 'duration_months', 'scheme_plan_type_id'];
    const missingFields = requiredFields.filter(field => !req.body[field]);

    if (missingFields.length > 0) {
      return res.status(400).json({
        success: false,
        message: `Missing required fields: ${missingFields.join(', ')}`
      });
    }

    // Validate payment_frequency_id only if SCHEMETYPE is FIXED
    if (SCHEMETYPE === 'FIXED' && !payment_frequency_id) {
      return res.status(400).json({
        success: false,
        message: 'payment_frequency_id is required for FIXED scheme type'
      });
    }

    // File handling from multer fields
    const IMAGE = req.files?.IMAGE ? `/uploads/${req.files.IMAGE[0].filename}` : null;
    const ICON = req.files?.ICON ? `/uploads/${req.files.ICON[0].filename}` : null;

    const schemeData = {
      SCHEMENAME,
      SCHEMETYPE,
      SCHEMENO,
      REGNO,
      ACTIVE: ACTIVE || 'Y',
      BRANCHID,
      INS_TYPE,
      DESCRIPTION: DESCRIPTION || null,
      SLOGAN: SLOGAN || null,
      IMAGE,
      ICON,
      fixed: fixed || null,
      duration_months: parseInt(duration_months),
      type: type || 'gold',
      scheme_plan_type_id: parseInt(scheme_plan_type_id),
      payment_frequency_id: JSON.parse(payment_frequency_id)
    };

    const result = await Scheme.createSchemeAndChits(schemeData);
if(result.success)
{
res.status(201).json({
      success: true,
      message: 'Scheme created successfully',
      data: result,
      imagePath: IMAGE,
    });
}
else
{
  res.status(500).json({
      success: false,
      message: 'Something went wrong while creating the scheme',
      error: result,
    });
}
    

  } catch (error) {
    console.error('Error creating scheme:', error);
    res.status(500).json({
      success: false,
      message: 'Something went wrong while creating the scheme',
      error: error.sqlMessage || error.message || error,
    });
  }
};

exports.getAllSchemes = async (req, res) => {
  try {
    const schemes = await Scheme.getAll();
    res.json({ data: schemes, status: 200 });
  } catch (err) {
    res.status(500).json({ error: err.sqlMessage || err });
  }
};

exports.getSchemeplan = async (req, res) => {
  try {
 
    // Fetch scheme data
    const schemes = await Scheme.getschemePlan();

    // Validate response
    if (!schemes || schemes.length === 0) {
      return res.status(404).json({
        status: 404,
        message: "No scheme plans found.",
      });
    }

    // Send success response
    res.status(200).json({
      status: 200,
      data: schemes,
      message: "Scheme plans retrieved successfully.",
    });
  } catch (err) {
    console.error("Error fetching scheme plans:", err);

    // Send structured error response
    res.status(500).json({
      status: 500,
      message: "Internal server error while fetching scheme plans.",
      error: err.sqlMessage || err.message || "Unknown error occurred",
    });
  }
};


exports.getSchemeById = async (req, res) => {
  try {
    const schemeId = req.params.id;
    const scheme = await Scheme.getById(schemeId);
    if (!scheme) {
      return res.status(404).json({ message: "Scheme not found", status: 404 });
    }
    res.json({ data: scheme, status: 200 });
  } catch (err) {
    res.status(500).json({ error: err.sqlMessage || err });
  }
};

exports.updateScheme = async (req, res) => {
  try {
    const schemeId = req.params.id;

    const {
      SCHEMENAME,
      SCHEMETYPE,
      SCHEMENO,
      REGNO,
      ACTIVE,
      BRANCHID,
      INS_TYPE,
      DESCRIPTION,
      SLOGAN,
      fixed,
      duration_months,
      scheme_plan_type_id,
      payment_frequency_id,
    } = req.body;

    // Validate required fields
    if (!SCHEMENAME || !SCHEMETYPE || !duration_months || !scheme_plan_type_id || !payment_frequency_id) {
      return res.status(400).json({ error: "Missing required fields" });
    }

    // Handle uploaded image and icon files
    const IMAGE =
      req.files && req.files.IMAGE && req.files.IMAGE.length > 0
        ? `/uploads/${req.files.IMAGE[0].filename}`
        : undefined;

    const ICON =
      req.files && req.files.ICON && req.files.ICON.length > 0
        ? `/uploads/${req.files.ICON[0].filename}`
        : undefined;

    const schemeData = {
      SCHEMENAME,
      SCHEMETYPE: SCHEMETYPE.toUpperCase(),
      SCHEMENO,
      REGNO,
      ACTIVE,
      BRANCHID,
      INS_TYPE,
      DESCRIPTION,
      SLOGAN,
      fixed: fixed !== undefined ? parseFloat(fixed) : null,
      duration_months: parseInt(duration_months),
      scheme_plan_type_id: parseInt(scheme_plan_type_id),
      payment_frequency_id: JSON.parse(payment_frequency_id),
      IMAGE,
      ICON,
    };

    const result = await Scheme.updateSchemeAndAddChits(schemeId, schemeData);

    res.status(200).json({
      message: "Scheme updated successfully",
      data: result,
      imagePath: IMAGE || null,
    });

  } catch (error) {
    console.error("Error updating scheme:", error);
    res.status(500).json({ error: error.sqlMessage || error.message || error });
  }
};


exports.deleteScheme = async (req, res) => {
  try {
    const schemeId = req.params.id;

    if (!schemeId || isNaN(schemeId)) {
      return res.status(400).json({
        error: "Invalid or missing scheme ID.",
        status: 400,
      });
    }

    const result = await Scheme.delete(schemeId);

    res.status(200).json({
      message: result.message || "Scheme soft-deleted successfully",
      data: result.result || result,
      status: 200,
    });

  } catch (err) {
    console.error("Error deleting scheme:", err);
    res.status(500).json({
      error: err.message || "Internal server error",
      status: 500,
    });
  }
};

