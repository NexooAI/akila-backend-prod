const Poster = require('../models/posterModel');
const logger = require('../middlewares/logger');
const fs = require('fs').promises;
const path = require('path');

// Create a new poster with image upload
exports.createPoster = async (req, res) => {
  try {
    logger.info('Create poster request body:', req.body);
    logger.info('Create poster file:', req.file);

    const { title, startDate, endDate } = req.body;

    // Validate required fields
    if (!req.file || !title || !startDate || !endDate) {
      logger.warn('Missing required fields:', { 
        hasFile: !!req.file, 
        hasTitle: !!title, 
        hasStartDate: !!startDate, 
        hasEndDate: !!endDate 
      });
      return res.status(400).json({
        success: false,
        error: 'All fields (image, title, startDate, endDate) are required'
      });
    }

    // Prepare data for database
    const posterData = {
      title,
      image_path: `/uploads/posters/${req.file.filename}`,
      start_date: startDate,
      end_date: endDate,
      status: 1
    };

    logger.info('Poster data prepared:', posterData);

    // Create the poster
    const result = await Poster.create(posterData);
    logger.info('Poster creation result:', result);

    if (!result.success) {
      // If poster creation fails, delete the uploaded file
      try {
        await fs.unlink(req.file.path);
        logger.info('Deleted uploaded file after failed poster creation');
      } catch (fileError) {
        logger.error('Error deleting file after failed poster creation:', fileError);
      }

      return res.status(500).json({
        success: false,
        error: result.message || 'Failed to create poster'
      });
    }

    res.status(201).json({
      success: true,
      message: 'Poster created successfully',
      data: {
        id: result.posterId,
        title: posterData.title,
        image: posterData.image_path,
        startDate: posterData.start_date,
        endDate: posterData.end_date,
        status: posterData.status
      }
    });
  } catch (error) {
    logger.error('Error in createPoster:', error);
    res.status(500).json({
      success: false,
      error: error.message || 'Server error while creating poster'
    });
  }
};

// Get all posters
exports.getAllPosters = async (req, res) => {
  try {
    const posters = await Poster.getAll();
    res.status(200).json({
      success: true,
      data: posters
    });
  } catch (error) {
    logger.error('Error in getAllPosters:', error);
    res.status(500).json({
      success: false,
      error: 'Error while fetching posters'
    });
  }
};

// Get poster by ID
exports.getPosterById = async (req, res) => {
  try {
    const poster = await Poster.getById(req.params.id);

    if (!poster) {
      return res.status(404).json({
        success: false,
        error: 'Poster not found'
      });
    }

    res.status(200).json({
      success: true,
      data: poster
    });
  } catch (error) {
    logger.error('Error in getPosterById:', error);
    res.status(500).json({
      success: false,
      error: 'Error while fetching poster'
    });
  }
};

// Delete poster by ID
exports.deletePoster = async (req, res) => {
  try {
    const result = await Poster.delete(req.params.id);

    if (!result.success) {
      return res.status(404).json({
        success: false,
        error: result.message
      });
    }

    // Delete associated file
    if (result.poster && result.poster.image_path) {
      try {
        const filePath = path.join(__dirname, '..', result.poster.image_path);
        await fs.unlink(filePath);
        logger.info(`Deleted file: ${filePath}`);
      } catch (fileError) {
        logger.error(`Error deleting file for poster ${req.params.id}:`, fileError);
      }
    }

    res.status(200).json({
      success: true,
      message: 'Poster deleted successfully'
    });
  } catch (error) {
    logger.error('Error in deletePoster:', error);
    res.status(500).json({
      success: false,
      error: 'Error while deleting poster'
    });
  }
};

// Get active posters
exports.getActivePosters = async (req, res) => {
  try {
    logger.info('Fetching active posters');
    const posters = await Poster.getActive();
    
    logger.info('Active posters retrieved:', {
      count: posters.length,
      posters: posters.map(p => ({
        id: p.id,
        title: p.title,
        startDate: p.startDate,
        endDate: p.endDate,
        status: p.status
      }))
    });

    // If no posters found, return a more informative response
    if (posters.length === 0) {
      return res.status(200).json({
        success: true,
        message: 'No active posters found',
        data: []
      });
    }

    res.status(200).json({
      success: true,
      message: `Found ${posters.length} active poster(s)`,
      data: posters
    });
  } catch (error) {
    logger.error('Error in getActivePosters:', {
      error: error.message,
      stack: error.stack,
      timestamp: new Date().toISOString()
    });
    res.status(500).json({
      success: false,
      error: 'Error while fetching active posters',
      details: process.env.NODE_ENV === 'development' ? error.message : undefined
    });
  }
}; 