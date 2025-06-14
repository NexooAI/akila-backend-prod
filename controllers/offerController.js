const Offer = require("../models/offerModel");
const fs = require("fs");
const path = require("path");
const offerController = {
  // Retrieve all offers
  getOffers: async (req, res) => {
    try {
      const offers = await Offer.getAllOffers();
      res.status(200).json({
        success: true,
        data: offers,
        message: "Offers retrieved successfully",
      });
    } catch (error) {
      console.error("Error fetching offers:", error);
      res.status(500).json({
        success: false,
        data: null,
        message: "Failed to fetch offers",
      });
    }
  },

  // Retrieve a single offer by id
  getOfferById: async (req, res) => {
    try {
      const { id } = req.params;
      const offer = await Offer.getOfferById(id);
      if (!offer) {
        return res.status(404).json({
          success: false,
          data: null,
          message: "Offer not found",
        });
      }
      res.status(200).json({
        success: true,
        data: offer,
        message: "Offer retrieved successfully",
      });
    } catch (error) {
      console.error("Error fetching offer:", error);
      res.status(500).json({
        success: false,
        data: null,
        message: "Failed to fetch offer",
      });
    }
  },

  // Create a new offer
  createOffer: async (req, res) => {
    console.log(req.file);
    try {
      const { title, subtitle, discount, start_date, end_date } = req.body;
      const image_url = req.file ? req.file.path : null;
      if (!title || discount === undefined || !start_date || !end_date) {
        return res.status(400).json({
          success: false,
          data: null,
          message: "Missing required fields",
        });
      }
      console.log('startdate',start_date,end_date)
      const image = req.file ? `/uploads/offers/${req.file.filename}` : "/uploads/default.jpg";
      const offerId = await Offer.createOffer({
        title,
        subtitle,
        discount,
        start_date,
        end_date,
        image,
      });

      res.status(201).json({
        success: true,
        data: { id: offerId,imagePath:image},
        message: "Offer created successfully",
      });
    } catch (error) {
      console.error("Error creating offer:", error);
      res.status(500).json({
        success: false,
        data: null,
        message: "Failed to create offer",
      });
    }
  },

  // Update an existing offer
   updateOffer:async (req, res)=> {
   try {
      const { id } = req.params;

      // Call the model method to update the offer
      const result = await Offer.updateOffer(id, req.body, req.file);

      if (!result.success) {
        // If the offer doesn't exist, remove the uploaded image to prevent unnecessary storage
        if (req.file) {
          const uploadedFilePath = path.join(__dirname, "..", `/uploads/offers/${req.file.filename}`);
          if (fs.existsSync(uploadedFilePath)) {
            fs.unlinkSync(uploadedFilePath);
          }
        }
        return res.status(404).json(result);
      }

      return res.status(200).json(result);
    } catch (error) {
      console.error("Error updating offer:", error);
      return res.status(500).json({ success: false, message: "Internal Server Error" });
    }
  
  },

  // Delete an offer
  deleteOffer: async (req, res) => {
    try {
      const { id } = req.params;
      await Offer.deleteOffer(id);
      res.status(200).json({
        success: true,
        data: null,
        message: "Offer deleted successfully",
      });
    } catch (error) {
      console.error("Error deleting offer:", error);
      res.status(500).json({
        success: false,
        data: null,
        message: "Failed to delete offer",
      });
    }
  },
};

module.exports = offerController;
