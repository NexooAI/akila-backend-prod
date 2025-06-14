const db = require("../config/db");

// Create a new scheme record
const createScheme = async (schemeData) => {
  const { scheme_id, title, subtitle, description, image, status } = schemeData;
  const query = `
    INSERT INTO schemesKnowmore (scheme_id, title, subtitle, description, image, status)
    VALUES (?, ?, ?, ?, ?, ?)
  `;
  const [result] = await db.query(query, [
    scheme_id,
    title,
    subtitle,
    description,
    image,
    status || "active",
  ]);
  return result;
};

// Retrieve all scheme records
const getAllSchemes = async () => {
  const query = "SELECT * FROM schemesKnowmore";
  const [results] = await db.query(query);
  return results;
};

// Retrieve a single scheme record by primary key id
const getSchemeById = async (id) => {
  const query = "SELECT * FROM schemesKnowmore WHERE id = ?";
  const [results] = await db.query(query, [id]);
  return results;
};

// Retrieve scheme record(s) by scheme_id (may return multiple rows)
const getSchemeBySchemeId = async (scheme_id) => {
  const query = "SELECT * FROM schemesKnowmore WHERE scheme_id = ?";
  const [results] = await db.query(query, [scheme_id]);
  return results;
};

// Update a scheme by primary key id
const updateScheme = async (id, schemeData) => {
  const { scheme_id, title, subtitle, description, image, status } = schemeData;
  const [existingScheme] = await db.query(
    "SELECT image FROM schemesKnowmore WHERE id = ?",
    [id]
  );
  if (!existingScheme || existingScheme.length === 0) {
    throw new Error("Scheme not found");
  }
  const query = `
    UPDATE schemesKnowmore 
    SET scheme_id = ?, title = ?, subtitle = ?, description = ?, image = ?, status = ?
    WHERE id = ?
  `;
  
  const [result] = await db.query(query, [
    scheme_id,
    title,
    subtitle,
    description,
    image?image:existingScheme[0].image,
    status,
    id,
  ]);
  return result;
};

// Delete a scheme by primary key id
const deleteScheme = async (id) => {
  const query = "DELETE FROM schemesKnowmore WHERE id = ?";
  const [result] = await db.query(query, [id]);
  return result;
};

module.exports = {
  createScheme,
  getAllSchemes,
  getSchemeById,
  getSchemeBySchemeId,
  updateScheme,
  deleteScheme,
};
