const admin = require("../services/firebaseService");

// Temporary in-memory storage for tokens
const tokenStore = {}; // key: userId, value: FCM token

/**
 * Save FCM token sent from the frontend
 * @route POST /save-fcm-token
 */
exports.saveToken = (req, res) => {
  const { userId, token } = req.body;

  if (!userId || !token) {
    return res
      .status(400)
      .json({ success: false, message: "Missing userId or token" });
  }

  tokenStore[userId] = token;
  return res.json({ success: true, message: "Token saved successfully" });
};

/**
 * Send a push notification to the given userId
 * @route POST /send-notification
 */
exports.sendNotification = async (req, res) => {
  const { userId, title, body } = req.body;

  const token = tokenStore[userId];
  if (!token) {
    return res
      .status(404)
      .json({
        success: false,
        message: "Token not found for userId: " + userId,
      });
  }

  const message = {
    token: token,
    notification: {
      title: title || "Default Title",
      body: body || "Default body message",
    },
  };

  try {
    const response = await admin.messaging().send(message);
    return res.json({ success: true, response });
  } catch (error) {
    return res
      .status(500)
      .json({
        success: false,
        message: "Error sending notification",
        error: error.message,
      });
  }
};

/**
 * Send a push notification to all users
 * @route POST /notifications/send-all
 */
exports.sendNotificationToAll = async (req, res) => {
  const { title, body, data } = req.body;

  if (!title || !body) {
    return res.status(400).json({
      success: false,
      message: 'Title and body are required'
    });
  }

  // Get all FCM tokens from tokenStore
  const tokens = Object.values(tokenStore);

  if (tokens.length === 0) {
    return res.status(404).json({
      success: false,
      message: 'No users registered with FCM tokens'
    });
  }

  const responses = [];
  let successCount = 0;

  try {
    // Send to all tokens in batches (Firebase recommends max 500 tokens per batch)
    for (let i = 0; i < tokens.length; i += 500) {
      const batchTokens = tokens.slice(i, i + 500);
      
      const message = {
        tokens: batchTokens,
        notification: {
          title: title,
          body: body
        },
        data: data || {}
      };
      
      const response = await admin.messaging().sendMulticast(message);
      responses.push(response);
      successCount += response.successCount;
    }

    return res.json({
      success: true,
      message: 'Notifications sent successfully',
      totalSent: successCount,
      totalRecipients: tokens.length,
      responses: responses
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: 'Error sending notifications',
      error: error.message
    });
  }
};
