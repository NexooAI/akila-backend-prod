const db = require('../config/db');
const logger = require('../middlewares/logger');

const FlashNews = {
    create: async (data) => {
        const connection = await db.getConnection();
        try {
            await connection.beginTransaction();

            const {
                fNews,
                startDate,
                endDate,
                status = 'active'
            } = data;

            const [result] = await connection.query(
                'INSERT INTO flash_news (f_news, start_date, end_date, status, created_at, updated_at) VALUES (?, ?, ?, ?, NOW(), NOW())',
                [fNews, startDate, endDate, status]
            );

            await connection.commit();
            return result;
        } catch (error) {
            await connection.rollback();
            logger.error('Error creating flash news:', error);
            throw error;
        } finally {
            connection.release();
        }
    },

    getAll: async () => {
        const connection = await db.getConnection();
        try {
            const [results] = await connection.query(
                'SELECT * FROM flash_news ORDER BY created_at DESC'
            );
            return results;
        } catch (error) {
            logger.error('Error fetching flash news:', error);
            return [];
        } finally {
            connection.release();
        }
    },

    getById: async (id) => {
        const connection = await db.getConnection();
        try {
            const [results] = await connection.query(
                'SELECT * FROM flash_news WHERE id = ?',
                [id]
            );
            return results[0] || null;
        } catch (error) {
            logger.error('Error fetching flash news by ID:', error);
            return null;
        } finally {
            connection.release();
        }
    },

    update: async (id, data) => {
        const connection = await db.getConnection();
        try {
            await connection.beginTransaction();

            const {
                fNews,
                startDate,
                endDate,
                status
            } = data;

            const [result] = await connection.query(
                'UPDATE flash_news SET f_news = ?, start_date = ?, end_date = ?, status = ?, updated_at = NOW() WHERE id = ?',
                [fNews, startDate, endDate, status, id]
            );

            await connection.commit();
            return result;
        } catch (error) {
            await connection.rollback();
            logger.error('Error updating flash news:', error);
            throw error;
        } finally {
            connection.release();
        }
    },

    delete: async (id) => {
        const connection = await db.getConnection();
        try {
            await connection.beginTransaction();

            const [result] = await connection.query(
                'DELETE FROM flash_news WHERE id = ?',
                [id]
            );

            await connection.commit();
            return result;
        } catch (error) {
            await connection.rollback();
            logger.error('Error deleting flash news:', error);
            throw error;
        } finally {
            connection.release();
        }
    },

    getActive: async () => {
        const connection = await db.getConnection();
        try {
            const [results] = await connection.query(
                'SELECT * FROM flash_news WHERE status = ? AND start_date <= NOW() AND end_date >= NOW() ORDER BY created_at DESC',
                ['active']
            );
            return results || [];
        } catch (error) {
            logger.error('Error fetching active flash news:', error);
            return [];
        } finally {
            connection.release();
        }
    },

    getActiveFlashNews: async () => {
        const connection = await db.getConnection();
        try {
           const [results] = await connection.query(
                'SELECT *,f_news as title,start_date as startDate,end_date as endDate,created_at as createdAt,updated_at as updatedAt FROM flash_news WHERE status = ? AND start_date <= NOW() AND end_date >= NOW() ORDER BY created_at DESC',
                ['active']
            );
            return results;
        } catch (error) {
            logger.error('Error getting active flash news:', error);
            throw error;
        } finally {
            connection.release();
        }
    }
};

module.exports = FlashNews;
