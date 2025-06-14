const db = require('../config/db');
const logger = require('../middlewares/logger');
const path = require('path');
const fs = require('fs').promises;

// Initialize the Intro screens table
async function initialize() {
    try {
        const connection = await db.getConnection();
        
        // First, check if the table exists
        const [tables] = await connection.query(`
            SELECT TABLE_NAME 
            FROM information_schema.tables 
            WHERE table_schema = DATABASE() 
            AND TABLE_NAME = 'intro_screens'
        `);

        if (tables.length === 0) {
            // Create table if it doesn't exist
            await connection.query(`
                CREATE TABLE intro_screens (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    title VARCHAR(255) NOT NULL,
                    image VARCHAR(255) NOT NULL,
                    start_date DATETIME NOT NULL,
                    end_date DATETIME NOT NULL,
                    status ENUM('active', 'inactive') DEFAULT 'active',
                    is_intro BOOLEAN DEFAULT FALSE,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
                )
            `);
        } else {
            // Check if is_intro column exists
            const [columns] = await connection.query(`
                SELECT COLUMN_NAME 
                FROM information_schema.columns 
                WHERE table_schema = DATABASE() 
                AND TABLE_NAME = 'intro_screens' 
                AND COLUMN_NAME = 'is_intro'
            `);

            // Add is_intro column if it doesn't exist
            if (columns.length === 0) {
                await connection.query(`
                    ALTER TABLE intro_screens 
                    ADD COLUMN is_intro BOOLEAN DEFAULT FALSE
                `);
            }
        }
        
        connection.release();
    } catch (error) {
        logger.error('Error initializing Intro screens table:', error);
        throw error;
    }
}

// Initialize the table when the module loads
initialize();

const IntroScreen = {
    create: async (data) => {
        const connection = await db.getConnection();
        try {
            await connection.beginTransaction();

            const {
                title,
                image,
                startDate,
                endDate,
                status = 'active',
                isIntro = false
            } = data;

            // If this is set as intro screen, unset any existing intro screens
            if (isIntro) {
                await connection.query('UPDATE intro_screens SET is_intro = false WHERE is_intro = true');
            }

            // Create Intro directory if it doesn't exist
            const introDir = path.join(__dirname, '../uploads/Intro');
            await fs.mkdir(introDir, { recursive: true });
            
            const [result] = await connection.query(
                'INSERT INTO intro_screens (title, image, start_date, end_date, status, is_intro, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?, NOW(), NOW())',
                [title, image, startDate, endDate, status, isIntro]
            );

            // Get the created record
            const [createdRecord] = await connection.query(
                'SELECT * FROM intro_screens WHERE id = ?',
                [result.insertId]
            );

            await connection.commit();
            return createdRecord[0];
        } catch (error) {
            await connection.rollback();
            logger.error('Error creating Intro screen:', error);
            throw error;
        } finally {
            connection.release();
        }
    },

    getAll: async () => {
        const connection = await db.getConnection();
        try {
            const [rows] = await connection.query(
                'SELECT * FROM intro_screens ORDER BY created_at DESC'
            );
            return rows;
        } catch (error) {
            logger.error('Error getting all Intro screens:', error);
            throw error;
        } finally {
            connection.release();
        }
    },

    getById: async (id) => {
        const connection = await db.getConnection();
        try {
            const [rows] = await connection.query(
                'SELECT * FROM intro_screens WHERE id = ?',
                [id]
            );
            return rows[0] || null;
        } catch (error) {
            logger.error('Error getting Intro screen by id:', error);
            throw error;
        } finally {
            connection.release();
        }
    },

    update: async (id, data) => {
        const connection = await db.getConnection();
        try {
            await connection.beginTransaction();

            // Check if we're setting this as intro screen
            if (data.isIntro) {
                // First, unset any existing intro screens
                await connection.query('UPDATE intro_screens SET is_intro = false WHERE is_intro = true');
            }

            const updateFields = [];
            const values = [];

            if (data.title) {
                updateFields.push('title = ?');
                values.push(data.title);
            }
            if (data.image) {
                updateFields.push('image = ?');
                values.push(data.image);
            }
            if (data.startDate) {
                updateFields.push('start_date = ?');
                values.push(data.startDate);
            }
            if (data.endDate) {
                updateFields.push('end_date = ?');
                values.push(data.endDate);
            }
            if (data.status) {
                updateFields.push('status = ?');
                values.push(data.status);
            }
            if (data.isIntro !== undefined) {
                updateFields.push('is_intro = ?');
                values.push(data.isIntro);
            }

            values.push(id);

            await connection.query(
                `UPDATE intro_screens SET ${updateFields.join(', ')}, updated_at = NOW() WHERE id = ?`,
                values
            );

            // Get the updated record
            const [updatedRecord] = await connection.query(
                'SELECT * FROM intro_screens WHERE id = ?',
                [id]
            );

            await connection.commit();
            return updatedRecord[0];
        } catch (error) {
            await connection.rollback();
            logger.error('Error updating Intro screen:', error);
            throw error;
        } finally {
            connection.release();
        }
    },

    delete: async (id) => {
        const connection = await db.getConnection();
        try {
            await connection.beginTransaction();

            const [rows] = await connection.query(
                'SELECT image FROM intro_screens WHERE id = ?',
                [id]
            );

            if (rows[0]) {
                // Delete associated image file
                const imagePath = path.join(__dirname, '../uploads/Intro', rows[0].image);
                try {
                    await fs.unlink(imagePath);
                } catch (unlinkError) {
                    logger.warn('Could not delete image file:', unlinkError);
                }
            }

            const [result] = await connection.query(
                'DELETE FROM intro_screens WHERE id = ?',
                [id]
            );

            await connection.commit();
            return result;
        } catch (error) {
            await connection.rollback();
            logger.error('Error deleting Intro screen:', error);
            throw error;
        } finally {
            connection.release();
        }
    },

    getActive: async () => {
        const connection = await db.getConnection();
        try {
            // Get all active intro screens that are within their date range
            const [rows] = await connection.query(`
                SELECT 
                    id,
                    title,
                    image,
                    DATE_FORMAT(start_date, '%Y-%m-%d') as startDate,
                    DATE_FORMAT(end_date, '%Y-%m-%d') as endDate,
                    status,
                    is_intro as isIntro,
                    DATE_FORMAT(created_at, '%Y-%m-%d %H:%i:%s') as createdAt,
                    DATE_FORMAT(updated_at, '%Y-%m-%d %H:%i:%s') as updatedAt
                FROM intro_screens 
                WHERE status = 'active'
                AND start_date <= CURRENT_TIMESTAMP
                AND end_date >= CURRENT_TIMESTAMP
                ORDER BY 
                    CASE 
                        WHEN is_intro = true THEN 1
                        ELSE 2
                    END,
                    created_at DESC
            `);

            logger.debug('Active screens query result:', rows);
            return rows;
        } catch (error) {
            logger.error('Error getting active Intro screens:', error);
            throw error;
        } finally {
            connection.release();
        }
    },

    getInitialPopup: async () => {
        const connection = await db.getConnection();
        try {
            // Get the most recent active intro screen that is set as initial popup
            const [rows] = await connection.query(`
                SELECT 
                    id,
                    title,
                    image,
                    DATE_FORMAT(start_date, '%Y-%m-%d') as startDate,
                    DATE_FORMAT(end_date, '%Y-%m-%d') as endDate,
                    status,
                    is_intro as isIntro,
                    DATE_FORMAT(created_at, '%Y-%m-%d %H:%i:%s') as createdAt,
                    DATE_FORMAT(updated_at, '%Y-%m-%d %H:%i:%s') as updatedAt
                FROM intro_screens 
                WHERE status = 'active'
                AND is_intro = true
                AND start_date <= CURRENT_TIMESTAMP
                AND end_date >= CURRENT_TIMESTAMP
                ORDER BY created_at DESC
                LIMIT 1
            `);

            return rows[0] || null;
        } catch (error) {
            logger.error('Error getting initial popup:', error);
            throw error;
        } finally {
            connection.release();
        }
    },
    
    getIntroScreen: async () => {
        const connection = await db.getConnection();
        try {
            const [rows] = await connection.query(
                'SELECT * FROM intro_screens WHERE is_intro = true AND status = "active" LIMIT 1'
            );
            return rows[0] || null;
        } catch (error) {
            logger.error('Error getting intro screen:', error);
            throw error;
        } finally {
            connection.release();
        }
    },
    
    setIntroScreen: async (id) => {
        const connection = await db.getConnection();
        try {
            await connection.beginTransaction();
            
            // First, unset any existing intro screens
            await connection.query('UPDATE intro_screens SET is_intro = false WHERE is_intro = true');
            
            // Then set the new intro screen
            const [result] = await connection.query(
                'UPDATE intro_screens SET is_intro = true WHERE id = ?',
                [id]
            );
            
            await connection.commit();
            return result;
        } catch (error) {
            await connection.rollback();
            logger.error('Error setting intro screen:', error);
            throw error;
        } finally {
            connection.release();
        }
    }
};

module.exports = IntroScreen;
