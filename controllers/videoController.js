const Video = require("../models/videoModel");
const logger = require("../middlewares/logger");

exports.createVideo = async (req, res) => {
  try {
    logger.info('Creating new video:', req.body);
    
    // Validate required fields
    if (!req.body.title || !req.body.video_url) {
      return res.status(400).json({
        success: false,
        message: "Title and video_url are required",
        status: 400
      });
    }

    const result = await Video.create(req.body);
    logger.info('Video created successfully:', result);

    res.status(201).json({
      success: true,
      message: "Video created successfully",
      data: result,
      status: 201
    });
  } catch (err) {
    logger.error('Error creating video:', err);
    res.status(500).json({
      success: false,
      message: "Error creating video",
      error: err.sqlMessage || err.message || err,
      status: 500
    });
  }
};

exports.getAllVideos = async (req, res) => {
  try {
    logger.info('Fetching all videos');
    const videos = await Video.getAll();
    logger.info(`Found ${videos.length} videos`);

    res.status(200).json({
      success: true,
      data: videos,
      status: 200
    });
  } catch (err) {
    logger.error('Error fetching videos:', err);
    res.status(500).json({
      success: false,
      message: "Error fetching videos",
      error: err.sqlMessage || err.message || err,
      status: 500
    });
  }
};

exports.getVideoById = async (req, res) => {
  const id = req.params.id;
  try {
    logger.info(`Fetching video with ID: ${id}`);
    const video = await Video.getById(id);
    
    if (!video) {
      logger.warn(`Video not found with ID: ${id}`);
      return res.status(404).json({
        success: false,
        message: "Video not found",
        status: 404
      });
    }

    logger.info('Video found:', video);
    res.status(200).json({
      success: true,
      data: video,
      status: 200
    });
  } catch (err) {
    logger.error(`Error fetching video with ID ${id}:`, err);
    res.status(500).json({
      success: false,
      message: "Error fetching video",
      error: err.sqlMessage || err.message || err,
      status: 500
    });
  }
};

exports.updateVideo = async (req, res) => {
  const id = req.params.id;
  try {
    logger.info(`Updating video with ID: ${id}`, req.body);
    
    // Check if video exists
    const existingVideo = await Video.getById(id);
    if (!existingVideo) {
      logger.warn(`Video not found with ID: ${id}`);
      return res.status(404).json({
        success: false,
        message: "Video not found",
        status: 404
      });
    }

    const result = await Video.update(id, req.body);
    logger.info('Video updated successfully:', result);

    res.status(200).json({
      success: true,
      message: "Video updated successfully",
      data: result,
      status: 200
    });
  } catch (err) {
    logger.error(`Error updating video with ID ${id}:`, err);
    res.status(500).json({
      success: false,
      message: "Error updating video",
      error: err.sqlMessage || err.message || err,
      status: 500
    });
  }
};

exports.deleteVideo = async (req, res) => {
  const id = req.params.id;
  try {
    logger.info(`Deleting video with ID: ${id}`);
    
    // Check if video exists
    const existingVideo = await Video.getById(id);
    if (!existingVideo) {
      logger.warn(`Video not found with ID: ${id}`);
      return res.status(404).json({
        success: false,
        message: "Video not found",
        status: 404
      });
    }

    const result = await Video.delete(id);
    logger.info('Video deleted successfully:', result);

    res.status(200).json({
      success: true,
      message: "Video deleted successfully",
      data: result,
      status: 200
    });
  } catch (err) {
    logger.error(`Error deleting video with ID ${id}:`, err);
    res.status(500).json({
      success: false,
      message: "Error deleting video",
      error: err.sqlMessage || err.message || err,
      status: 500
    });
  }
};

exports.getActiveVideos = async (req, res) => {
  try {
    logger.info('Fetching active videos');
    const videos = await Video.getActive();
    
    if (!videos || videos.length === 0) {
      logger.info('No active videos found');
      return res.status(200).json({
        success: true,
        message: "No active videos found",
        data: [],
        status: 200
      });
    }

    logger.info(`Successfully retrieved ${videos.length} active videos`);
    return res.status(200).json({
      success: true,
      message: "Active videos retrieved successfully",
      data: videos,
      status: 200
    });
  } catch (err) {
    logger.error('Error fetching active videos:', err);
    
    // Handle specific database errors
    if (err.message.includes('ER_NO_SUCH_TABLE')) {
      return res.status(500).json({
        success: false,
        message: "Database table not found",
        error: "The videos table does not exist",
        status: 500
      });
    }
    
    if (err.message.includes('ECONNREFUSED')) {
      return res.status(500).json({
        success: false,
        message: "Database connection failed",
        error: "Could not connect to the database",
        status: 500
      });
    }

    return res.status(500).json({
      success: false,
      message: "Error fetching active videos",
      error: err.message || "An unexpected error occurred",
      status: 500
    });
  }
};
