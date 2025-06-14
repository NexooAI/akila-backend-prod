const db = require("../config/db");

const NotificationModel = {
  saveOrUpdateToken: async (userId, token, device_type) => {
    try {
      // Input validation
      if (!userId || !token || !device_type) {
        throw new Error('Missing required fields: userId, token, and device_type are required');
      }

      // Validate device_type
      const validDeviceTypes = ['ios', 'android', 'web'];
      const deviceType = device_type.toLowerCase();
      if (!validDeviceTypes.includes(deviceType)) {
        throw new Error('Invalid device_type. Must be one of: ios, android, web');
      }

      const [rows] = await db.query(
        "SELECT * FROM fcm_tokens WHERE userId = ? AND token = ?",
        [userId, token]
      );

      if (rows.length > 0) {
        const [result] = await db.query(
          `UPDATE fcm_tokens 
           SET device_type = ?, 
               status = 'active', 
               updateAt = NOW() 
           WHERE userId = ? AND token = ?`,
          [deviceType, userId, token]
        );
        return result;
      } else {
        const [result] = await db.query(
          `INSERT INTO fcm_tokens 
           (userId, token, device_type, status, createAt, updateAt) 
           VALUES (?, ?, ?, 'active', NOW(), NOW())`,
          [userId, token, deviceType]
        );
        return result;
      }
    } catch (error) {
      console.error('Error in saveOrUpdateToken:', error);
      throw error;
    }
  },

  getAllTokens: async () => {
    try {
      const [results] = await db.query(`
        SELECT id, userId, token, device_type, status, 
               DATE_FORMAT(createAt, '%Y-%m-%d %H:%i:%s') as createAt,
               DATE_FORMAT(updateAt, '%Y-%m-%d %H:%i:%s') as updateAt
        FROM fcm_tokens 
        WHERE status = 'active'
      `);
      return results;
    } catch (error) {
      console.error('Error in getAllTokens:', error);
      throw error;
    }
  },

  getTokensByUserId: async (userId) => {
    try {
      if (!userId) {
        throw new Error('User ID is required');
      }

      const [results] = await db.query(`
        SELECT id, token, device_type, status, 
               DATE_FORMAT(createAt, '%Y-%m-%d %H:%i:%s') as createAt,
               DATE_FORMAT(updateAt, '%Y-%m-%d %H:%i:%s') as updateAt
        FROM fcm_tokens 
        WHERE userId = ? AND status = 'active'
      `, [userId]);
      return results;
    } catch (error) {
      console.error('Error in getTokensByUserId:', error);
      throw error;
    }
  },

  deleteTokenById: async (id) => {
    try {
      if (!id) {
        throw new Error('Token ID is required');
      }
      
      const [result] = await db.query(
        "DELETE FROM fcm_tokens WHERE id = ?",
        [id]
      );
      
      if (result.affectedRows === 0) {
        return { success: false, message: 'No token found with the specified ID' };
      }
      return { success: true, message: 'Token deleted successfully' };
    } catch (error) {
      console.error('Error in deleteTokenById:', error);
      throw error;
    }
  },

  deleteTokenByUserId: async (userId) => {
    try {
      if (!userId) {
        throw new Error('User ID is required');
      }
      
      const [result] = await db.query(
        "DELETE FROM fcm_tokens WHERE userId = ?",
        [userId]
      );
      
      return {
        success: true,
        message: `Successfully deleted ${result.affectedRows} token(s)`
      };
    } catch (error) {
      console.error('Error in deleteTokenByUserId:', error);
      throw error;
    }
  },

  updateToken: async (id, updateData) => {
    try {
      if (!id) {
        throw new Error('Token ID is required');
      }

      // Validate device_type if provided
      if (updateData.device_type) {
        const validDeviceTypes = ['ios', 'android', 'web'];
        const deviceType = updateData.device_type.toLowerCase();
        if (!validDeviceTypes.includes(deviceType)) {
          throw new Error('Invalid device_type. Must be one of: ios, android, web');
        }
        updateData.device_type = deviceType;
      }

      // Build the SET clause for the update query
      const setClause = Object.keys(updateData)
        .map(key => `${key} = ?`)
        .join(', ');
      
      if (!setClause) {
        throw new Error('No valid fields provided for update');
      }

      const values = [...Object.values(updateData), id];
      const [result] = await db.query(
        `UPDATE fcm_tokens 
         SET ${setClause}, updateAt = NOW() 
         WHERE id = ?`,
        values
      );
      
      if (result.affectedRows === 0) {
        return { success: false, message: 'No token found with the specified ID' };
      }
      return { 
        success: true, 
        message: 'Token updated successfully',
        affectedRows: result.affectedRows
      };
    } catch (error) {
      console.error('Error in updateToken:', error);
      throw error;
    }
  },

  updateTokenStatus: async (token, status) => {
    try {
      if (!token || !status) {
        throw new Error('Token and status are required');
      }
      
      const validStatuses = ['active', 'inactive'];
      if (!validStatuses.includes(status)) {
        throw new Error('Invalid status. Must be one of: active, inactive');
      }
      
      const [result] = await db.query(
        `UPDATE fcm_tokens 
         SET status = ?, 
             updateAt = NOW() 
         WHERE token = ?`,
        [status, token]
      );
      
      if (result.affectedRows === 0) {
        return { success: false, message: 'No token found with the specified value' };
      }
      return { success: true, message: 'Token status updated successfully' };
    } catch (error) {
      console.error('Error in updateTokenStatus:', error);
      throw error;
    }
  }
};

module.exports = NotificationModel;
