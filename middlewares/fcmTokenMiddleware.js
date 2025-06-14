const NotificationService = require('../services/notificationService');

// Middleware to update FCM token for a user
const updateFcmToken = async (req, res, next) => {
    try {
        const { fcmToken } = req.body;
        const userId = req.user.id; // Assuming you have user ID in the request

        if (fcmToken) {
            // Update user's FCM token in your database
            // You'll need to implement this based on your user model
            // For example:
            // await User.update({ fcmToken }, { where: { id: userId } });
            
            // Subscribe to topics if needed
            await NotificationService.sendToTopic('all', 'FCM Token Updated', 'Your device token has been updated');
        }

        next();
    } catch (error) {
        next(error);
    }
};

module.exports = {
    updateFcmToken
};
