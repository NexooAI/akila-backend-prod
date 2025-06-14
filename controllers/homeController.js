const userModel = require("../models/userModel");
const investmentModel = require("../models/investmentModel");
const analyticsModel = require("../models/analyticsModel");
const introScreenModel = require("../models/introScreenModel");
const paymentModel = require("../models/paymentModel");
const rateModel = require("../models/rateModel");
const collectionModel = require("../models/collectionModel");
const posterModel = require("../models/posterModel");
const flashNewsModel = require("../models/flashNewsModel");
const initialPopup=require('../models/initialPopupModel')
const schemeModel = require("../models/schemeModel");
const logger = require("../middlewares/logger");
const Video = require("../models/videoModel");

// exports.getHomeData = async (req, res) => {
//     try {
//         logger.info("Starting getHomeData function");

//         // Test with only current rates first
//         let currentRates = null;
//         try {
//             logger.info("Fetching current rates...");
//             currentRates = await rateModel.getCurrentRates();
//             logger.info("Current rates fetched successfully");
//         } catch (error) {
//             logger.error("Error fetching current rates:", error);
//         }

//         // Test collections
//         let collections = [];
//         try {
//             logger.info("Fetching collections...");
//             collections = await collectionModel.getActiveCollections();
//             logger.info("Collections fetched successfully");
//         } catch (error) {
//             logger.error("Error fetching collections:", error);
//         }

//         // Test posters
//         let posters = [];
//         try {
//             logger.info("Fetching posters...");
//             posters = await posterModel.getActivePosters();
//             logger.info("Posters fetched successfully");
//         } catch (error) {
//             logger.error("Error fetching posters:", error);
//         }

//         // Test flash news
//         let flashNews = [];
//         try {
//             logger.info("Fetching flash news...");
//             flashNews = await flashNewsModel.getActiveFlashNews();
//             logger.info("Flash news fetched successfully");
//         } catch (error) {
//             logger.error("Error fetching flash news:", error);
//         }

//         // Test intro screen
//         let introScreen = null;
//         try {
//             logger.info("Fetching intro screen...");
//             introScreen = await introScreenModel.getInitialPopup();
//             logger.info("Intro screen fetched successfully");
//         } catch (error) {
//             logger.error("Error fetching intro screen:", error);
//         }


//         let initialPopups=[]
//          try {
//             logger.info("Fetching intro screen...");
//             initialPopups = await initialPopup.getActive()
//             logger.info("Intro screen fetched successfully");
//         } catch (error) {
//             logger.error("Error fetching intro screen:", error);
//         }

        
//         let investments=[]
//          try {
//             logger.info("Fetching intro screen...");
//             investments = await investmentModel.getAllInvestments()
//             logger.info("Intro screen fetched successfully");
//         } catch (error) {
//             logger.error("Error fetching intro screen:", error);
//         }
//         let videos=[]
//         try {
//             logger.info("Fetching intro screen..");
//             videos = await Video.getAll();
//             logger.info("Intro screen fetched successfully");
//         } catch (error) {
//             logger.error("Error fetching intro screen:", error);
//         }


//         // Combine all data
//         const responseData = {
//             success: true,
//             data: {
//                 currentRates: currentRates ? {
//                     goldRate: currentRates.gold_rate,
//                     silverRate: currentRates.silver_rate,
//                     lastUpdated: currentRates.updated_at
//                 } : null,
//                 collections: collections.map(col => {
//                     const collection = {
//                         id: col.id || null,
//                         name: col.name || '',
//                         thumbnail: col.thumbnail || '',
//                         status_images: Array.isArray(col.status_images) ? col.status_images : [],
//                         created_at: col.created_at || null,
//                         updated_at: col.updated_at || null
//                     };
//                     return collection;
//                 }),
//                 posters: posters.map(poster => ({
//                     id: poster.id,
//                     title: poster.title,
//                     image: poster.image,
//                     startDate: poster.startDate,
//                     endDate: poster.endDate,
//                     status: poster.status,
//                     createdAt: poster.createdAt,
//                     updatedAt: poster.updatedAt
//                 })),
//                 flashNews: flashNews.map(news => ({
//                     id: news.id,
//                     title: news.title,
//                     content: news.content,
//                     status: news.status,
//                     startDate: news.start_date,
//                     endDate: news.end_date
//                 })),
//                 introScreen: introScreen ? {
//                     title: introScreen.title,
//                     image: introScreen.image,
//                     startDate: introScreen.startDate,
//                     endDate: introScreen.endDate
//                 } : null
//             }
//         };

//         logger.info("Sending response data");
//         res.status(200).json(responseData);

//     } catch (error) {
//         logger.error("Error in getHomeData:", error);
//         res.status(500).json({
//             success: false,
//             message: "Error fetching home page data",
//             error: error.message
//         });
//     }
// }; 

const validateData = (data, fields) => {
    if (!data) return [];
    return fields.reduce((obj, field) => {
        obj[field] = data[field] || null;
        return obj;
    }, {});
};

exports.getHomeData = async (req, res) => {
    try {
        console.log("howme controller")
        logger.info("Starting getHomeData function");
        const userId = req.params.userId || req.query.userId; // Extract userId from request
        if (!userId || isNaN(userId)) {
            return res.status(400).json({ success: false, message: "Invalid user ID" });
        }
        const fetchDataSafely = async (modelFunction, dataLabel,userId) => {
            try {
                logger.info(`Fetching ${dataLabel}...`);
                const data =userId ? await modelFunction(userId) : await modelFunction();
                logger.info(`${dataLabel} fetched successfully`);
                return data||[];
            } catch (error) {
                logger.error(`Error fetching ${dataLabel}:`, error);
                return null; // Return `null` in case of failure
            }
        };

        const [
            currentRates,
            collections,
            posters,
            flashNews,
            introScreen,
            initialPopups,
            investments,
            videos
        ] = await Promise.all([
            fetchDataSafely(rateModel.getCurrentRates, "current rates"),
            fetchDataSafely(collectionModel.getActiveCollections, "collections"),
            fetchDataSafely(posterModel.getActivePosters, "posters"),
            fetchDataSafely(flashNewsModel.getActiveFlashNews, "flash news"),
            fetchDataSafely(introScreenModel.getInitialPopup, "intro screen"),
            fetchDataSafely(initialPopup.getActive, "initial popups"),
            fetchDataSafely(investmentModel.getInvestmentsByUser, "investments",userId),
            fetchDataSafely(Video.getAllActive, "videos")
        ]);

        const responseData = {
            success: true,
            data: {
                currentRates: validateData(currentRates, ["gold_rate", "silver_rate", "updated_at"]),
                collections: collections.map(col => validateData(col, ["id", "name", "thumbnail", "status_images", "created_at", "updated_at"])),
                posters: posters.map(poster => validateData(poster, ["id", "title", "image", "startDate", "endDate", "status", "createdAt", "updatedAt"])),
                flashNews: flashNews.map(news => validateData(news, ["id", "title", "status", "startDate", "endDate"])),
                introScreen: validateData(introScreen, ["title", "image", "startDate", "endDate"]),
                initialPopups: initialPopups.map(popup => validateData(popup, ["id", "title", "image_url", "link_url", "status", "start_date", "end_date"])),
                investments: investments,
                investmentsCount:investments.length,
                videos: videos.map(video => validateData(video, ["id", "title", "url", "created_at"]))
            }
        };

        logger.info("Sending response data");
        res.status(200).json(responseData);

    } catch (error) {
        logger.error("Error in getHomeData:", error);
        res.status(500).json({
            success: false,
            message: "Error fetching home page data",
            error: error.message
        });
    }
};