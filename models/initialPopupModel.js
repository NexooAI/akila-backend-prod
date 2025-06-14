const db = require("../config/db");

const InitialPopup = {
  // Helper function to normalize paths
  normalizePath: (path) => {
    return path.replace(/\\/g, '/');
  },

  // Create a new popup
  create: async (data) => {
    try {
      const { title, image_url, link_url, status, startDate, endDate } = data;
      
      // Normalize image path
      const normalizedImageUrl = InitialPopup.normalizePath(image_url);
      
      const [result] = await db.query(
        `INSERT INTO initial_popups (title, image_url, link_url, status, start_date, end_date) 
         VALUES (?, ?, ?, ?, ?, ?)`,
        [title, normalizedImageUrl, link_url, status, startDate, endDate]
      );
      
      return { 
        success: true, 
        message: 'Initial popup created successfully',
        popupId: result.insertId 
      };
    } catch (error) {
      console.error('Error in create initial popup:', error);
      throw error;
    }
  },

  // Get all popups
  getAll: async () => {
    try {
      const [popups] = await db.query(`
        SELECT id, title, image_url, link_url, status, 
               DATE_FORMAT(start_date, '%Y-%m-%d %H:%i:%s') as start_date,
               DATE_FORMAT(end_date, '%Y-%m-%d %H:%i:%s') as end_date,
               DATE_FORMAT(created_at, '%Y-%m-%d %H:%i:%s') as created_at,
               DATE_FORMAT(updated_at, '%Y-%m-%d %H:%i:%s') as updated_at
        FROM initial_popups
        ORDER BY created_at DESC
      `);

      // Return popups with normalized paths
      return popups.map(popup => ({
        ...popup,
        image_url: InitialPopup.normalizePath(popup.image_url)
      }));
    } catch (error) {
      console.error('Error in get all popups:', error);
      throw error;
    }
  },

  // Get active popups
  getActive: async () => {
    try {
      const [popups] = await db.query(`
        SELECT id, title, image_url, link_url, status, 
               DATE_FORMAT(start_date, '%Y-%m-%d %H:%i:%s') as start_date,
               DATE_FORMAT(end_date, '%Y-%m-%d %H:%i:%s') as end_date,
               DATE_FORMAT(created_at, '%Y-%m-%d %H:%i:%s') as created_at,
               DATE_FORMAT(updated_at, '%Y-%m-%d %H:%i:%s') as updated_at
        FROM initial_popups
        WHERE status = 'active'
        AND (start_date IS NULL OR start_date <= NOW())
        AND (end_date IS NULL OR end_date >= NOW())
        ORDER BY created_at DESC
      `);

      // Return popups with normalized paths
      return popups.map(popup => ({
        ...popup,
        image_url: InitialPopup.normalizePath(popup.image_url)
      }));
    } catch (error) {
      console.error('Error in get active popups:', error);
      throw error;
    }
  },

  // Get popup by ID
  getById: async (id) => {
    try {
      const [popups] = await db.query(`
        SELECT id, title, image_url, link_url, status,
               DATE_FORMAT(start_date, '%Y-%m-%d %H:%i:%s') as start_date,
               DATE_FORMAT(end_date, '%Y-%m-%d %H:%i:%s') as end_date,
               DATE_FORMAT(created_at, '%Y-%m-%d %H:%i:%s') as created_at,
               DATE_FORMAT(updated_at, '%Y-%m-%d %H:%i:%s') as updated_at
        FROM initial_popups
        WHERE id = ?
      `, [id]);

      if (popups.length === 0) {
        return null;
      }

      // Return popup with normalized path
      const popup = popups[0];
      return {
        ...popup,
        image_url: InitialPopup.normalizePath(popup.image_url)
      };
    } catch (error) {
      console.error('Error in get popup by id:', error);
      throw error;
    }
  },

  // Update popup
  update: async (id, data) => {
    try {
      const { title, image_url, link_url, status, start_date, end_date } = data;
      
      // Normalize image path if provided
      const normalizedImageUrl = image_url ? InitialPopup.normalizePath(image_url) : undefined;
      
      const [result] = await db.query(
        `UPDATE initial_popups 
         SET title = COALESCE(?, title),
             image_url = COALESCE(?, image_url),
             link_url = COALESCE(?, link_url),
             status = COALESCE(?, status),
             start_date = COALESCE(?, start_date),
             end_date = COALESCE(?, end_date),
             updated_at = CURRENT_TIMESTAMP
         WHERE id = ?`,
        [title, normalizedImageUrl, link_url, status, start_date, end_date, id]
      );

      if (result.affectedRows === 0) {
        return { success: false, message: 'Popup not found' };
      }

      return { 
        success: true, 
        message: 'Popup updated successfully',
        affectedRows: result.affectedRows
      };
    } catch (error) {
      console.error('Error in update popup:', error);
      throw error;
    }
  },

  // Delete popup
  delete: async (id) => {
    try {
      const [result] = await db.query(
        'DELETE FROM initial_popups WHERE id = ?',
        [id]
      );

      if (result.affectedRows === 0) {
        return { success: false, message: 'Popup not found' };
      }

      return { 
        success: true, 
        message: 'Popup deleted successfully',
        affectedRows: result.affectedRows
      };
    } catch (error) {
      console.error('Error in delete popup:', error);
      throw error;
    }
  },

  // Deactivate all active popups
  deactivateAllActive: async () => {
    try {
      const [result] = await db.query(
        `UPDATE initial_popups 
         SET status = 'inactive', 
             updated_at = CURRENT_TIMESTAMP
         WHERE status = 'active'`
      );
      
      return { 
        success: true, 
        message: 'All active popups deactivated successfully',
        affectedRows: result.affectedRows 
      };
    } catch (error) {
      console.error('Error in deactivateAllActive:', error);
      throw error;
    }
  }
};

module.exports = InitialPopup; 