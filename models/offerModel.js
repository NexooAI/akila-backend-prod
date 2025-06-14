const db = require("../config/db");
const fs = require("fs");
const path = require("path");
class Offer {
  static async getAllOffers() {
    const [rows] = await db.query("SELECT * FROM offers");
    return rows;
  }

  static async getOfferById(id) {
    const [rows] = await db.query("SELECT *, DATE_FORMAT(start_date, '%Y-%m-%d') AS start_date,DATE_FORMAT(end_date, '%Y-%m-%d') AS end_date FROM offers WHERE id = ?", [id]);
    console.log('rows',rows)
    return rows.length ? rows[0] : null;
  }

  static async createOffer(offerData) {
    let { title, subtitle, discount, start_date, end_date, image } =
      offerData;
    // Set a default file path if image_url is not provided
    // if (!image_url) {
    //   const image = req.file ? `/uploads/offers/${req.file.filename}` : "/uploads/default.jpg";
    // }
    const [result] = await db.query(
      "INSERT INTO offers (title, subtitle, discount, start_date, end_date, image_url) VALUES (?, ?, ?, ?, ?, ?)",
      [title, subtitle, discount, start_date, end_date, image]
    );
    console.log("createOffer", result);
    return result.insertId;
  }

  


  static async updateOffer(id, offerData, file) {
    try {
      const { title, subtitle, discount, start_date, end_date, status } = offerData;

      // Fetch existing offer details
      const existingOffer = await this.getOfferById(id);
      if (!existingOffer) {
        return { success: false, message: "Offer not found, image not uploaded" };
      }

      let imagePath = existingOffer.image_url; // Retain the existing image by default

      // If a new image is uploaded, process it
      if (file) {
        imagePath = `/uploads/offers/${file.filename}`;

        // Delete old image if it's not the default
        if (existingOffer.image_url && existingOffer.image_url !== "/uploads/default.jpg") {
          const oldImageFullPath = path.join(__dirname, "..", existingOffer.image_url);
          if (fs.existsSync(oldImageFullPath)) {
            fs.unlinkSync(oldImageFullPath);
          }
        }
      }

      // Update the offer in the database
      await db.query(
        "UPDATE offers SET title = ?, subtitle = ?, discount = ?, start_date = ?, end_date = ?, status = ?, image_url = ? WHERE id = ?",
        [title, subtitle, discount, start_date, end_date, status, imagePath, id]
      );

      return { success: true, message: "Offer updated successfully", imagePath };
    } catch (error) {
      console.error("Error updating offer:", error);
      return { success: false, message: "Internal Server Error" };
    }
  }




  static async deleteOffer(id) {
    await db.query("DELETE FROM offers WHERE id = ?", [id]);
  }
}

module.exports = Offer;
