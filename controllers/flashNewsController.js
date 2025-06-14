const FlashNews = require('../models/flashNewsModel');

exports.createFlashNews = async (req, res) => {
    try {
        const { fNews, startDate, endDate, status } = req.body;

        // Validate required fields
        if (!fNews || !startDate || !endDate || !status) {
            return res.status(400).json({
                status: 'error',
                message: 'All fields are required'
            });
        }

        const result = await FlashNews.create({
            fNews,
            startDate,
            endDate,
            status
        });
        
        res.status(201).json({
            status: 'success',
            data: result
        });
    } catch (error) {
        console.error('Error creating flash news:', error);
        res.status(500).json({
            status: 'error',
            message: 'Error creating flash news'
        });
    }
};

exports.getFlashNews = async (req, res) => {
    try {
        const flashNews = await FlashNews.getAll();
        
        res.status(200).json({
            status: 'success',
            data: flashNews
        });
    } catch (error) {
        console.error('Error fetching flash news:', error);
        res.status(500).json({
            status: 'error',
            message: 'Error fetching flash news'
        });
    }
};

exports.getFlashNewsById = async (req, res) => {
    try {
        const { id } = req.params;
        const flashNews = await FlashNews.getById(id);
        
        if (!flashNews) {
            return res.status(404).json({
                status: 'error',
                message: 'Flash news not found'
            });
        }

        res.status(200).json({
            status: 'success',
            data: flashNews
        });
    } catch (error) {
        console.error('Error fetching flash news by ID:', error);
        res.status(500).json({
            status: 'error',
            message: 'Error fetching flash news'
        });
    }
};

exports.updateFlashNews = async (req, res) => {
    try {
        const { id } = req.params;
        const { fNews, startDate, endDate, status } = req.body;

        const result = await FlashNews.update(id, {
            fNews,
            startDate,
            endDate,
            status
        });

        res.status(200).json({
            status: 'success',
            data: result
        });
    } catch (error) {
        console.error('Error updating flash news:', error);
        res.status(500).json({
            status: 'error',
            message: 'Error updating flash news'
        });
    }
};

exports.deleteFlashNews = async (req, res) => {
    try {
        const { id } = req.params;
        const result = await FlashNews.delete(id);

        res.status(200).json({
            status: 'success',
            data: result
        });
    } catch (error) {
        console.error('Error deleting flash news:', error);
        res.status(500).json({
            status: 'error',
            message: 'Error deleting flash news'
        });
    }
};

exports.getActiveFlashNews = async (req, res) => {
    console.log("---------------------active");
    try {
        const flashNews = await FlashNews.getActive();
        
        res.status(200).json({
            status: 'success',
            data: flashNews || []
        });
    } catch (error) {
        console.error('Error fetching active flash news:', error);
        res.status(500).json({
            status: 'error',
            message: 'Error fetching active flash news'
        });
    }
};
