const NotificationModel = require("../models/notificationModel");

exports.saveToken = async (req, res) => {
  try {
    const { userId, token, device_type } = req.body;
    
    if (!userId || !token || !device_type) {
      return res.status(400).json({
        success: false,
        error: "Missing required fields: userId, token, and device_type are required"
      });
    }

    await NotificationModel.saveOrUpdateToken(userId, token, device_type);
    res.json({
      success: true,
      message: "Token saved or updated successfully"
    });
  } catch (error) {
    console.error('Error in saveToken:', error);
    res.status(500).json({
      success: false,
      error: error.message || "Internal server error"
    });
  }
};

exports.getTokens = async (req, res) => {
  try {
    const tokens = await NotificationModel.getAllTokens();
    res.json({
      success: true,
      data: tokens
    });
  } catch (error) {
    console.error('Error in getTokens:', error);
    res.status(500).json({
      success: false,
      error: error.message || "Internal server error"
    });
  }
};

exports.getUserTokens = async (req, res) => {
  try {
    const userId = req.params.userId;
    if (!userId) {
      return res.status(400).json({
        success: false,
        error: "User ID is required"
      });
    }

    const tokens = await NotificationModel.getTokensByUserId(userId);
    res.json({
      success: true,
      data: tokens
    });
  } catch (error) {
    console.error('Error in getUserTokens:', error);
    res.status(500).json({
      success: false,
      error: error.message || "Internal server error"
    });
  }
};

exports.deleteToken = async (req, res) => {
  try {
    const id = req.params.id;
    if (!id) {
      return res.status(400).json({
        success: false,
        error: "Token ID is required"
      });
    }

    const result = await NotificationModel.deleteTokenById(id);
    res.json(result);
  } catch (error) {
    console.error('Error in deleteToken:', error);
    res.status(500).json({
      success: false,
      error: error.message || "Internal server error"
    });
  }
};

exports.deleteUserTokens = async (req, res) => {
  try {
    const userId = req.params.userId;
    if (!userId) {
      return res.status(400).json({
        success: false,
        error: "User ID is required"
      });
    }

    const result = await NotificationModel.deleteTokenByUserId(userId);
    res.json(result);
  } catch (error) {
    console.error('Error in deleteUserTokens:', error);
    res.status(500).json({
      success: false,
      error: error.message || "Internal server error"
    });
  }
};

exports.updateToken = async (req, res) => {
  try {
    const tokenId = req.params.id;
    const updateData = req.body;

    if (!tokenId) {
      return res.status(400).json({
        success: false,
        error: "Token ID is required"
      });
    }

    if (!updateData || Object.keys(updateData).length === 0) {
      return res.status(400).json({
        success: false,
        error: "No update data provided"
      });
    }

    const result = await NotificationModel.updateToken(tokenId, updateData);
    res.json(result);
  } catch (error) {
    console.error('Error in updateToken:', error);
    res.status(500).json({
      success: false,
      error: error.message || "Internal server error"
    });
  }
};

exports.updateTokenStatus = async (req, res) => {
  try {
    const { token, status } = req.body;

    if (!token || !status) {
      return res.status(400).json({
        success: false,
        error: "Token and status are required"
      });
    }

    const result = await NotificationModel.updateTokenStatus(token, status);
    res.json(result);
  } catch (error) {
    console.error('Error in updateTokenStatus:', error);
    res.status(500).json({
      success: false,
      error: error.message || "Internal server error"
    });
  }
};