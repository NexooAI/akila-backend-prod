const amqp = require('amqplib');
const admin = require('firebase-admin');
const db = require('../config/db'); // MySQL connection pool
require('dotenv').config();

// Firebase Admin SDK initialization
const serviceAccount = JSON.parse(process.env.FIREBASEPATH)

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

async function startWorker() {
  try {
    const connection = await amqp.connect(process.env.RABBITMQ_URL_AWS);
    const channel = await connection.createChannel();
    await channel.assertQueue('notification_queue');

    console.log('[x] Waiting for messages in notification_queue...');

    channel.consume('notification_queue', async (msg) => {
      if (!msg) return;

      const content = msg.content.toString();
      let payload;
      console.log("content",content)
      try {
        payload = JSON.parse(content);
      } catch (err) {
        console.error('Invalid JSON:', err);
        channel.ack(msg);
        return;
      }

      const { userId, title, body,investment_id,missedDateStr } = payload;

      try {
        // Fetch user's latest FCM token
        const [rows] = await db.query(
          `SELECT token FROM fcm_tokens WHERE userId = ? ORDER BY createAt DESC LIMIT 1`,
          [userId]
        );
        console.log("rows",JSON.stringify(rows))
        if (rows.length === 0) {
          console.warn(`No FCM token found for user ${userId}`);
          channel.ack(msg);
          return;
        }
         const [alreadySent] = await db.query(`
          SELECT 1 FROM notification_logs 
          WHERE userId = ? AND investmentId = ? AND missed_date = ?
          LIMIT 1
        `, [userId, investment_id, missedDateStr]);

        if (alreadySent.length > 0) {
          console.log(`[i] Notification already sent for user ${userId} on ${missedDateStr}, skipping.`);
          channel.ack(msg);
          return;
        }

        const token = rows[0].token;

        const message = {
          token,
          notification: {
            title,
            body,
          },
        };

        const response = await admin.messaging().send(message);
        console.log(`[✔] Notification sent to user ${userId}: ${response}`);

        // Optional: Log success
        await db.query(
          `INSERT INTO notification_logs (userId, title, body, token, status, createdAt,investmentId,missed_date) VALUES (?, ?, ?, ?, ?, NOW(),?,?)`,
          [userId, title, body, token, 'sent',investment_id,missedDateStr]
        );

      } catch (err) {
        console.error(`[✖] Failed to send notification to user ${userId}:`, err.message);

        // Optional: Log failure
        await db.query(
          `INSERT INTO notification_logs (userId, title, body, token, status, createdAt,investmentId,missed_date) VALUES (?, ?, ?, ?, ?, NOW(),?,?)`,
          [userId, title, body, null, 'failed',investment_id,missedDateStr]
        );
      }

      channel.ack(msg);
    });
  } catch (error) {
    console.error('Worker error:', error);
    process.exit(1);
  }
}
module.exports={
    startWorker
}

