const db = require("../config/db");
const logger = require("../middlewares/logger");

const Video = {
  // Create a new video record
  create: async (videoData) => {
    // If the new record is active, update all currently active videos to inactive.
    if (videoData.status && videoData.status.toLowerCase() === "active") {
      const updateSql =
        "UPDATE videos SET status='inactive' WHERE status='active'";
      await db.query(updateSql);
    }
    // Insert the new video record
    const data = {
      title: videoData.title,
      subtitle: videoData.subtitle,
      video_url: videoData.video_url,
      status: videoData.status || "active",
    };
    const sql = "INSERT INTO videos SET ?";
    const [result] = await db.query(sql, data);
    return result;
  },

  // Retrieve all videos, ordered by created_at descending
  getAll: async () => {
    const sql = "SELECT * FROM videos ORDER BY created_at DESC";
    const [results] = await db.query(sql);
    return results;
  },

  getAllActive: async () => {
    const sql = "SELECT * FROM videos where status='active' ORDER BY created_at DESC";
    const [results] = await db.query(sql);
    return results;
  },
  // Retrieve a single video by id
  getById: async (id) => {
    const sql = "SELECT * FROM videos WHERE id = ?";
    const [results] = await db.query(sql, [id]);
    if (results.length === 0) return null;
    return results[0];
  },

  // Update a video record by id
  update: async (id, videoData) => {
    const data = {
      title: videoData.title,
      subtitle: videoData.subtitle,
      video_url: videoData.video_url,
      status: videoData.status,
    };

    // If the new status is active, force all other active videos to inactive.
    if (videoData.status && videoData.status.toLowerCase() === "active") {
      const updateOthersSql =
        "UPDATE videos SET status = 'inactive' WHERE id != ? AND status = 'active'";
      await db.query(updateOthersSql, [id]);
    }

    const sql = "UPDATE videos SET ? WHERE id = ?";
    const [result] = await db.query(sql, [data, id]);
    return result;
  },

  // Delete a video record by id
  delete: async (id) => {
    const sql = "DELETE FROM videos WHERE id = ?";
    const [result] = await db.query(sql, [id]);
    return result;
  },

  async getActive() {
    let connection;
    try {
      logger.info('Fetching active videos');
      connection = await db.getConnection();
      
      const [rows] = await connection.query(
        `SELECT * FROM videos 
         WHERE status = 'active' 
         ORDER BY created_at DESC`
      );
      
      if (!rows || rows.length === 0) {
        logger.info('No active videos found in the database');
        return [];
      }
      
      logger.info(`Found ${rows.length} active videos:`, rows.map(v => ({ id: v.id, title: v.title })));
      return rows;
    } catch (err) {
      logger.error('Error in getActive:', err);
      throw new Error(err.sqlMessage || err.message || 'Database error occurred');
    } finally {
      if (connection) {
        try {
          await connection.release();
          logger.info('Database connection released');
        } catch (releaseErr) {
          logger.error('Error releasing database connection:', releaseErr);
        }
      }
    }
  },
};

module.exports = Video;
