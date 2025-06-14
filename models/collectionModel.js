const db = require("../config/db");
const logger = require("../middlewares/logger");

// Initialize collections table
const initializeTable = async () => {
  const connection = await db.getConnection();
  try {
    // Check if table exists
    const [tables] = await connection.execute(
      "SHOW TABLES LIKE 'collections'"
    );

    if (tables.length === 0) {
      // Create table if it doesn't exist
      await connection.execute(`
        CREATE TABLE collections (
          id INT PRIMARY KEY AUTO_INCREMENT,
          name VARCHAR(255) NOT NULL,
          thumbnail VARCHAR(255) NOT NULL,
          status_images TEXT,
          status ENUM('active', 'inactive') DEFAULT 'active',
          created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
          updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
          deleted_at DATETIME DEFAULT NULL
        )
      `);
      logger.info('Collections table created successfully');
    }
  } catch (error) {
    logger.error('Error initializing collections table:', error);
    throw error;
  } finally {
    connection.release();
  }
};

// Initialize table on module load
initializeTable().catch(error => {
  logger.error('Failed to initialize collections table:', error);
});

// Log table structure
const logTableStructure = async () => {
  const connection = await db.getConnection();
  try {
    const [columns] = await connection.query('SHOW COLUMNS FROM collections');
    logger.info('Collections table structure:', columns);
    return columns;
  } catch (error) {
    logger.error('Error getting table structure:', error);
    throw error;
  } finally {
    connection.release();
  }
};

// Log structure on module load
logTableStructure().catch(error => {
  logger.error('Failed to log table structure:', error);
});

const Collection = {
  // Helper function to normalize paths
  normalizePath: (path) => {
    if (!path) return '';
    return path.replace(/\\/g, '/');
  },

  // Helper function to safely parse JSON
  safeJsonParse: (str) => {
    if (!str) return [];
    try {
      // If it's already an array, return it
      if (Array.isArray(str)) return str;
      // If it's a string path, return it as a single item array
      if (typeof str === 'string' && !str.startsWith('[')) {
        return [str];
      }
      // Try to parse as JSON
      return JSON.parse(str);
    } catch (error) {
      // If parsing fails, return as single item array
      return [str];
    }
  },

  // Create a new collection
  create: async (data) => {
    const connection = await db.getConnection();
    try {
      await connection.beginTransaction();

      const {
        name,
        thumbnail,
        status_images = []
      } = data;

      // Ensure status_images is stored as JSON array
      const statusImagesJson = Array.isArray(status_images) 
        ? JSON.stringify(status_images)
        : JSON.stringify([status_images]);

      const [result] = await connection.query(
        'INSERT INTO collections (name, thumbnail, status_images, created_at, updated_at) VALUES (?, ?, ?, NOW(), NOW())',
        [name, Collection.normalizePath(thumbnail), statusImagesJson]
      );

      await connection.commit();
      return result;
    } catch (error) {
      await connection.rollback();
      logger.error('Error creating collection:', error);
      throw error;
    } finally {
      connection.release();
    }
  },

  // Get all collections
  getAll: async () => {
    const connection = await db.getConnection();
    try {
      const [results] = await connection.query(
        'SELECT id, name, thumbnail, status_images, created_at, updated_at FROM collections ORDER BY created_at DESC'
      );
      return results.map(collection => ({
        ...collection,
        thumbnail: Collection.normalizePath(collection.thumbnail),
        status_images: collection.status_images ? 
          Collection.safeJsonParse(collection.status_images).map(img => Collection.normalizePath(img)) : 
          []
      }));
    } catch (error) {
      logger.error('Error fetching collections:', error);
      return [];
    } finally {
      connection.release();
    }
  },

  // Get collection by ID
  getById: async (id) => {
    const connection = await db.getConnection();
    try {
      const [results] = await connection.query(
        'SELECT id, name, thumbnail, status_images, created_at, updated_at FROM collections WHERE id = ?',
        [id]
      );
      if (!results.length) return null;
      
      const collection = results[0];
      return {
        ...collection,
        thumbnail: Collection.normalizePath(collection.thumbnail),
        status_images: collection.status_images ? 
          Collection.safeJsonParse(collection.status_images).map(img => Collection.normalizePath(img)) : 
          []
      };
    } catch (error) {
      logger.error('Error fetching collection by ID:', error);
      return null;
    } finally {
      connection.release();
    }
  },

  // Update collection
  update: async (id, data) => {
    const connection = await db.getConnection();
    try {
      await connection.beginTransaction();

      const {
        name,
        thumbnail,
        status_images
      } = data;

      // Ensure status_images is stored as JSON array
      const statusImagesJson = Array.isArray(status_images) 
        ? JSON.stringify(status_images)
        : JSON.stringify([status_images]);

      const [result] = await connection.query(
        'UPDATE collections SET name = ?, thumbnail = ?, status_images = ?, updated_at = NOW() WHERE id = ?',
        [name, Collection.normalizePath(thumbnail), statusImagesJson, id]
      );

      await connection.commit();
      return result;
    } catch (error) {
      await connection.rollback();
      logger.error('Error updating collection:', error);
      throw error;
    } finally {
      connection.release();
    }
  },

  // Delete collection
  delete: async (id) => {
    const connection = await db.getConnection();
    try {
      await connection.beginTransaction();

      const [result] = await connection.query(
        'DELETE FROM collections WHERE id = ?',
        [id]
      );

      await connection.commit();
      return result;
    } catch (error) {
      await connection.rollback();
      logger.error('Error deleting collection:', error);
      throw error;
    } finally {
      connection.release();
    }
  },

  getActiveCollections: async () => {
    const connection = await db.getConnection();
    try {
      // First, get the table structure
      const [columns] = await connection.query('SHOW COLUMNS FROM collections');
      const columnNames = columns.map(col => col.Field);
      logger.info('Available columns:', columnNames);

      // Build the SELECT query based on available columns
      const selectColumns = ['id', 'name', 'thumbnail', 'status_images', 'created_at', 'updated_at']
        .filter(col => columnNames.includes(col))
        .join(', ');

      const [rows] = await connection.query(
        `SELECT ${selectColumns} FROM collections ORDER BY created_at DESC`
      );
      
      return rows.map(collection => ({
        ...collection,
        thumbnail: Collection.normalizePath(collection.thumbnail),
        status_images: collection.status_images ? 
          Collection.safeJsonParse(collection.status_images).map(img => Collection.normalizePath(img)) : 
          []
      }));
    } catch (error) {
      logger.error('Error getting active collections:', error);
      throw error;
    } finally {
      connection.release();
    }
  }
};

module.exports = Collection; 