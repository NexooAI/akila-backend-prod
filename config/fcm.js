const admin = require('firebase-admin');
const path = require('path');

// Initialize Firebase Admin SDK
try {
    // First try to get service account from environment variable
    const serviceAccount = process.env.FIREBASE_SERVICE_ACCOUNT 
        ? JSON.parse(process.env.FIREBASE_SERVICE_ACCOUNT)
        : require(path.join(__dirname, 'service-account.json'));

    if (!serviceAccount.project_id) {
        throw new Error('Service account must contain project_id');
    }

    admin.initializeApp({
        credential: admin.credential.cert(serviceAccount)
    });

    const fcm = admin.messaging();
    module.exports = fcm;
} catch (error) {
    console.error('Error initializing Firebase Admin:', error);
    throw new Error('Failed to initialize Firebase Admin. Please ensure service-account.json is present in the config directory and contains valid credentials.');
}
