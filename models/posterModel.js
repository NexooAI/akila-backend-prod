const db = require('../config/db');
const logger = require('../middlewares/logger');

// Initialize posters table
const initializeTable = async () => {
  const connection = await db.getConnection();
  try {
    // Check if table exists
    const [tables] = await connection.execute(
      "SHOW TABLES LIKE 'posters'"
    );

    if (tables.length === 0) {
      // Create table if it doesn't exist
      await connection.execute(`
        CREATE TABLE posters (
          id INT PRIMARY KEY AUTO_INCREMENT,
          title VARCHAR(255) NOT NULL,
          image_path VARCHAR(255) NOT NULL,
          start_date DATE NOT NULL,
          end_date DATE NOT NULL,
          status TINYINT DEFAULT 1,
          created_at DATETIME NOT NULL,
          updated_at DATETIME NOT NULL
        )
      `);
      logger.info('Posters table created successfully');
    }
  } catch (error) {
    logger.error('Error initializing posters table:', error);
    throw error;
  } finally {
    connection.release();
  }
};

// Initialize table on module load
initializeTable().catch(error => {
  logger.error('Failed to initialize posters table:', error);
});

const Poster = {
  // Create a new poster
  create: async (data) => {
    const connection = await db.getConnection();
    try {
      await connection.beginTransaction();

      const {
        title,
        image_path,
        start_date,
        end_date,
        status = 1
      } = data;

      // Validate required fields
      if (!title || !image_path || !start_date || !end_date) {
        logger.warn('Missing required fields:', { data });
        return {
          success: false,
          message: 'Missing required fields'
        };
      }

      // Validate dates
      const startDate = new Date(start_date);
      const endDate = new Date(end_date);
      
      if (isNaN(startDate.getTime()) || isNaN(endDate.getTime())) {
        logger.warn('Invalid date format:', { start_date, end_date });
        return {
          success: false,
          message: 'Invalid date format'
        };
      }

      if (startDate > endDate) {
        logger.warn('Invalid date range:', { start_date, end_date });
        return {
          success: false,
          message: 'Start date cannot be after end date'
        };
      }

      const createdAt = new Date().toISOString().slice(0, 19).replace('T', ' ');
      const updateAt = new Date().toISOString().slice(0, 19).replace('T', ' ');

      const sql = `
        INSERT INTO posters (
          title,
          image_path,
          start_date,
          end_date,
          status,
          created_at,
          updated_at
        ) VALUES (?, ?, ?, ?, ?, ?, ?)
      `;

      const params = [
        title,
        image_path,
        start_date,
        end_date,
        status,
        createdAt,
        updateAt
      ];

      logger.info('Creating poster with params:', params);

      const [result] = await connection.execute(sql, params);

      if (!result || !result.insertId) {
        throw new Error('Failed to insert poster: No insert ID returned');
      }

      // Verify the insert
      const [insertedPoster] = await connection.execute(
        'SELECT * FROM posters WHERE id = ?',
        [result.insertId]
      );

      if (!insertedPoster || insertedPoster.length === 0) {
        throw new Error('Poster was not properly inserted');
      }

      await connection.commit();
      logger.info('Poster created successfully:', { id: result.insertId });
      
      return { 
        success: true, 
        posterId: result.insertId,
        data: insertedPoster[0]
      };

    } catch (error) {
      await connection.rollback();
      logger.error('Poster creation failed:', {
        error: error.message,
        stack: error.stack,
        code: error.code,
        sqlMessage: error.sqlMessage
      });
      
      return {
        success: false,
        message: error.sqlMessage || error.message || 'Error while creating the poster'
      };
    } finally {
      connection.release();
    }
  },

  // Get all posters
  getAll: async () => {
    const connection = await db.getConnection();
    try {
      const sql = `
        SELECT 
          id,
          title,
          image_path as image,
          start_date as startDate,
          end_date as endDate,
          status,
          created_at as createdAt,
          updated_at as updatedAt
        FROM posters 
        ORDER BY created_at DESC
      `;
      const [results] = await connection.execute(sql);
      return results;
    } catch (error) {
      logger.error('Error fetching posters:', error);
      throw new Error('Unable to retrieve posters');
    } finally {
      connection.release();
    }
  },

  // Get poster by ID
  getById: async (id) => {
    const connection = await db.getConnection();
    try {
      const sql = `
        SELECT 
          id,
          title,
          image_path as image,
          start_date as startDate,
          end_date as endDate,
          status,
          created_at as createdAt,
          updated_at as updatedAt
        FROM posters 
        WHERE id = ?
      `;
      const [results] = await connection.execute(sql, [id]);

      if (results.length === 0) {
        return null;
      }

      return results[0];
    } catch (error) {
      logger.error(`Error fetching poster with ID ${id}:`, error);
      throw new Error('Unable to retrieve poster');
    } finally {
      connection.release();
    }
  },

  // Delete poster
  delete: async (id) => {
    const connection = await db.getConnection();
    try {
      await connection.beginTransaction();

      // Get poster details first
      const [poster] = await connection.execute(
        'SELECT * FROM posters WHERE id = ?',
        [id]
      );

      if (poster.length === 0) {
        return { 
          success: false, 
          message: 'Poster not found' 
        };
      }

      // Delete the poster
      const [result] = await connection.execute(
        'DELETE FROM posters WHERE id = ?',
        [id]
      );

      await connection.commit();
      
      return { 
        success: true, 
        message: 'Poster deleted successfully',
        poster: poster[0] // Return poster details for file cleanup
      };
    } catch (error) {
      await connection.rollback();
      logger.error(`Error deleting poster with ID ${id}:`, error);
      return { 
        success: false, 
        message: 'Error while deleting the poster' 
      };
    } finally {
      connection.release();
    }
  },

  // Get active posters
  getActive: async () => {
    const connection = await db.getConnection();
    try {
      const currentDate = new Date().toISOString().slice(0, 10);
      logger.info('Fetching active posters for date:', currentDate);

      // First, let's check all posters to diagnose the issue
      const [allPosters] = await connection.execute(`
        SELECT 
          id,
          title,
          image_path,
          start_date,
          end_date,
          status,
          created_at,
          updated_at
        FROM posters
      `);

      logger.info('Total posters in database:', allPosters.length);
      logger.info('Sample poster data:', allPosters[0]);

      // Now get active posters with proper date handling
      const sql = `
        SELECT 
          id,
          title,
          image_path as image,
          DATE_FORMAT(start_date, '%Y-%m-%d') as startDate,
          DATE_FORMAT(end_date, '%Y-%m-%d') as endDate,
          status,
          DATE_FORMAT(created_at, '%Y-%m-%d %H:%i:%s') as createdAt,
          DATE_FORMAT(updated_at, '%Y-%m-%d %H:%i:%s') as updatedAt
        FROM posters 
        WHERE status = 1 
        AND start_date <= CURDATE()
        AND end_date >= CURDATE()
        ORDER BY created_at DESC
      `;

      logger.info('Executing active posters query:', sql);
      const [results] = await connection.execute(sql);
      
      logger.info('Active posters found:', results.length);
      if (results.length > 0) {
        logger.info('First active poster:', results[0]);
      }

      return results;
    } catch (error) {
      logger.error('Error fetching active posters:', {
        error: error.message,
        stack: error.stack,
        code: error.code,
        sqlMessage: error.sqlMessage
      });
      throw new Error('Unable to retrieve active posters');
    } finally {
      connection.release();
    }
  },

  getActivePosters: async () => {
    const connection = await db.getConnection();
    try {
      const [rows] = await connection.query(
        `SELECT 
            id,
            title,
            image_path as image,
            status,
            start_date as startDate,
            end_date as endDate,
            created_at as createdAt,
            updated_at as updatedAt
        FROM posters 
        WHERE status = 1 
        ORDER BY created_at DESC`
      );
      return rows;
    } catch (error) {
      logger.error('Error getting active posters:', error);
      throw error;
    } finally {
      connection.release();
    }
  }
};

module.exports = Poster; 