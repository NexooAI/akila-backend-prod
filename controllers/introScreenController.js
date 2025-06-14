const IntroScreen = require('../models/introScreenModel');
const multer = require('multer');
const path = require('path');
const fs = require('fs').promises;
const logger = require('../utils/logger');

// Configure multer for image upload
const storage = multer.diskStorage({
    destination: async (req, file, cb) => {
        try {
            const uploadDir = path.join(__dirname, '../uploads/Intro');
            await fs.mkdir(uploadDir, { recursive: true });
            cb(null, uploadDir);
        } catch (error) {
            cb(error);
        }
    },
    filename: (req, file, cb) => {
        try {
            // Create a more descriptive filename
            const isIntro = req.body.isIntro === 'true' || req.body.isIntro === true;
            const title = req.body.title ? req.body.title.replace(/[^a-zA-Z0-9]/g, '-').toLowerCase() : 'untitled';
            const originalExt = path.extname(file.originalname);
            const timestamp = Date.now();
            
            // Create filename format: type_title_timestamp.ext
            const prefix = isIntro ? 'intro' : 'intro';
            const filename = `${prefix}_${title}_${timestamp}${originalExt}`;
            
            cb(null, filename);
        } catch (error) {
            cb(error);
        }
    }
});

const upload = multer({
    storage: storage,
    limits: {
        fileSize: 5 * 1024 * 1024 // 5MB limit
    },
    fileFilter: (req, file, cb) => {
        // Accept images only
        if (!file.originalname.match(/\.(jpg|jpeg|png|gif)$/)) {
            return cb(new Error('Only image files are allowed!'), false);
        }
        cb(null, true);
    }
}).single('image');

exports.create = async (req, res) => {
    try {
        upload(req, res, async (err) => {
            if (err instanceof multer.MulterError) {
                if (err.code === 'LIMIT_FILE_SIZE') {
                    return res.status(400).json({ 
                        success: false,
                        error: 'File size too large. Maximum size is 5MB.' 
                    });
                }
                return res.status(400).json({ 
                    success: false,
                    error: err.message 
                });
            } else if (err) {
                return res.status(400).json({ 
                    success: false,
                    error: err.message 
                });
            }

            // Validate required fields
            if (!req.body.title) {
                return res.status(400).json({ 
                    success: false,
                    error: 'Title is required' 
                });
            }
            if (!req.file) {
                return res.status(400).json({ 
                    success: false,
                    error: 'Image file is required' 
                });
            }
            if (!req.body.startDate) {
                return res.status(400).json({ 
                    success: false,
                    error: 'Start date is required' 
                });
            }
            if (!req.body.endDate) {
                return res.status(400).json({ 
                    success: false,
                    error: 'End date is required' 
                });
            }

            // Handle isIntro flag properly
            const isIntro = req.body.isIntro === 'true' || req.body.isIntro === true;

            const data = {
                title: req.body.title,
                image: req.file.filename,
                startDate: req.body.startDate,
                endDate: req.body.endDate,
                status: req.body.status || 'active',
                isIntro: isIntro
            };

            try {
                const result = await IntroScreen.create(data);
                res.status(201).json({
                    success: true,
                    message: 'Intro screen created successfully',
                    data: {
                        id: result.id,
                        title: result.title,
                        image: result.image,
                        startDate: result.start_date,
                        endDate: result.end_date,
                        status: result.status,
                        isIntro: result.is_intro,
                        createdAt: result.created_at,
                        updatedAt: result.updated_at
                    }
                });
            } catch (dbError) {
                // If database operation fails, delete the uploaded file
                if (req.file) {
                    try {
                        await fs.unlink(req.file.path);
                    } catch (unlinkError) {
                        logger.error('Error deleting uploaded file:', unlinkError);
                    }
                }
                throw dbError;
            }
        });
    } catch (error) {
        logger.error('Error in create:', error);
        res.status(500).json({ 
            success: false,
            error: error.message || 'Internal server error'
        });
    }
};

exports.getAll = async (req, res) => {
    try {
        const introScreens = await IntroScreen.getAll();
        res.json({
            success: true,
            data: introScreens
        });
    } catch (error) {
        logger.error('Error getting all intro screens:', error);
        res.status(500).json({ 
            success: false,
            error: error.message 
        });
    }
};

exports.getById = async (req, res) => {
    try {
        const introScreen = await IntroScreen.getById(req.params.id);
        if (!introScreen) {
            return res.status(404).json({ 
                success: false,
                error: 'Intro screen not found' 
            });
        }
        res.json({
            success: true,
            data: introScreen
        });
    } catch (error) {
        logger.error('Error getting intro screen by id:', error);
        res.status(500).json({ 
            success: false,
            error: error.message 
        });
    }
};

exports.update = async (req, res) => {
    try {
        // First, get the existing record to check for file changes
        const existingIntroScreen = await IntroScreen.getById(req.params.id);
        if (!existingIntroScreen) {
            return res.status(404).json({ 
                success: false,
                error: 'Intro screen not found' 
            });
        }

        upload(req, res, async (err) => {
            if (err) {
                return res.status(400).json({ 
                    success: false,
                    error: err.message 
                });
            }

            // Handle isIntro flag
            const isIntro = req.body.isIntro === 'true' || req.body.isIntro === true;
            
            // Prepare data for update
            const data = {
                title: req.body.title,
                startDate: req.body.startDate,
                endDate: req.body.endDate,
                status: req.body.status,
                isIntro: isIntro
            };
            
            // Handle image file
            if (req.file) {
                // New file uploaded - use the new filename
                data.image = req.file.filename;
                
                // If there was an existing image, delete it
                if (existingIntroScreen.image) {
                    try {
                        const existingImagePath = path.resolve(existingIntroScreen.image);
                        await fs.unlink(existingImagePath);
                    } catch (fileError) {
                        logger.warn('Could not delete previous image:', fileError.message);
                    }
                }
            } else if (!req.body.keepExistingImage && existingIntroScreen.image) {
                // If the type (intro vs regular) changed but no new file was uploaded,
                // we should rename the existing file to follow the naming convention
                const oldImagePath = path.resolve(existingIntroScreen.image);
                const oldImageExt = path.extname(existingIntroScreen.image);
                
                // Only rename if the intro screen type changed (intro vs regular)
                const wasIntro = path.basename(existingIntroScreen.image).startsWith('intro_');
                if (wasIntro !== isIntro) {
                    const title = req.body.title || existingIntroScreen.title;
                    const sanitizedTitle = title.replace(/[^a-zA-Z0-9]/g, '-').toLowerCase();
                    const timestamp = Date.now();
                    const prefix = isIntro ? 'intro' : 'intro';
                    const newFilename = `${prefix}_${sanitizedTitle}_${timestamp}${oldImageExt}`;
                    const newImagePath = path.join(path.dirname(oldImagePath), newFilename);
                    
                    try {
                        // Rename the file
                        await fs.rename(oldImagePath, newImagePath);
                        data.image = newImagePath;
                    } catch (renameError) {
                        logger.warn('Could not rename image file:', renameError.message);
                        // Keep the existing image path if rename fails
                        data.image = existingIntroScreen.image;
                    }
                } else {
                    // Keep the existing image path if no type change
                    data.image = existingIntroScreen.image;
                }
            }

            const result = await IntroScreen.update(req.params.id, data);
            res.json({
                success: true,
                message: 'Intro screen updated successfully',
                data: {
                    id: result.id,
                    title: result.title,
                    image: result.image,
                    startDate: result.start_date,
                    endDate: result.end_date,
                    status: result.status,
                    isIntro: result.is_intro,
                    createdAt: result.created_at,
                    updatedAt: result.updated_at
                }
            });
        });
    } catch (error) {
        logger.error('Error updating intro screen:', error);
        res.status(500).json({ 
            success: false,
            error: error.message 
        });
    }
};

exports.delete = async (req, res) => {
    try {
        const result = await IntroScreen.delete(req.params.id);
        res.json({
            success: true,
            message: 'Intro screen deleted successfully',
            data: {
                affectedRows: result.affectedRows
            }
        });
    } catch (error) {
        logger.error('Error deleting intro screen:', error);
        res.status(500).json({ 
            success: false,
            error: error.message 
        });
    }
};

exports.getActive = async (req, res) => {
    try {
        console.log("Getting active screens");
        const activeScreens = await IntroScreen.getActive();
        
        // Log the response for debugging
        logger.debug('Active screens response:', activeScreens);

        // Always return success with data array
        return res.status(200).json({
            success: true,
            data: Array.isArray(activeScreens) ? activeScreens : []
        });
    } catch (error) {
        logger.error('Error getting active intro screens:', error);
        return res.status(500).json({
            success: false,
            message: 'Error getting active intro screens',
            error: error.message
        });
    }
};

exports.getInitialPopup = async (req, res) => {
    try {
        const popup = await IntroScreen.getInitialPopup();
        
        // Log the response for debugging
        logger.debug('Initial popup response:', popup);

        return res.status(200).json({
            success: true,
            data: popup || null
        });
    } catch (error) {
        logger.error('Error getting initial popup:', error);
        return res.status(500).json({
            success: false,
            message: 'Error getting initial popup',
            error: error.message
        });
    }
};

exports.getIntroScreen = async (req, res) => {
    try {
        const introScreen = await IntroScreen.getIntroScreen();
        if (!introScreen) {
            return res.status(404).json({ error: 'No intro screen found' });
        }
        res.json(introScreen);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

exports.setIntroScreen = async (req, res) => {
    try {
        const { id } = req.params;
        
        // Check if intro screen exists
        const introScreen = await IntroScreen.getById(id);
        if (!introScreen) {
            return res.status(404).json({ error: 'Intro screen not found' });
        }
        
        const result = await IntroScreen.setIntroScreen(id);
        res.json({
            success: true,
            message: 'Intro screen set successfully',
            affectedRows: result.affectedRows
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};
