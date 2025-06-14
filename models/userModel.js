const db = require("../config/db");

// Create a new user (with optional referred_by)
const createUser = async (userData) => {
  const { name, email, mobile_number, user_type='user', referred_by } = userData;
  const query =
    "INSERT INTO users (name, email, mobile_number, user_type, referred_by) VALUES (?, ?, ?, ?, ?)";
  const [result] = await db.query(query, [
    name,
    email,
    mobile_number,
    user_type || "user",
    referred_by || null, // if not provided, use null
  ]);
  return result;
};

const getAllUsers = async () => {
  // const query = "SELECT id, email, mobile_number, created_at, name FROM users";
  const query = `
  SELECT 
  u.id, 
  u.email, 
  u.mobile_number, 
  u.created_at, 
  u.name,
  u.referral_code,
  u.kyc_status,
  
  IF(
    k.user_id IS NOT NULL, 
    JSON_OBJECT(
      'id', k.id,
      'doorno', k.doorno,
      'street', k.street,
      'area', k.area,
      'city', k.city,
      'district', k.district,
      'state', k.state,
      'country', k.country,
      'pincode', k.pincode,
      'dob', k.dob,
      'addressproof', k.addressproof,
      'enternumber', k.enternumber,
      'nominee_name', k.nominee_name,
      'nominee_relationship', k.nominee_relationship
    ),
    '{}'
  ) AS kyc_data
FROM users u
LEFT JOIN kyc k ON k.user_id = u.id 
ORDER BY u.created_at DESC
LIMIT 10 OFFSET 0;
`;
  const [results] = await db.query(query);
  return results;
};

// Get a user by ID
const getUserById = async (userId) => {
  const query = "SELECT * FROM users WHERE id = ?";
  const [results] = await db.query(query, [userId]);
  return results;
};

// Update a user by ID (with optional referred_by)
const updateUser = async (userId, userData) => {
  const { name, email, mobile_number, referred_by } = userData;
  // Validate required fields
  if (!name || !email || !mobile_number) {
    throw new Error("Missing required fields: name, email, mobile_number");
  }
  const query =
    "UPDATE users SET name = ?, email = ?, mobile_number = ?, referred_by = ? WHERE id = ?";
  const [result] = await db.query(query, [
    name,
    email,
    mobile_number,
    referred_by || null,
    userId,
  ]);
  return result;
};

// Delete a user by ID
const deleteUser = async (userId) => {
  const query = "DELETE FROM users WHERE id = ?";
  const [result] = await db.query(query, [userId]);
  return result;
};

const getAggregatedData = async (userId) => {
  const sql = `
  SELECT 
    u.id AS user_id,
    u.name,
    u.email,
    u.mobile_number,
    u.user_type,
    IFNULL(
      (
        SELECT JSON_OBJECT(
          'id', k.id,
          'doorno', k.doorno,
          'street', k.street,
          'area', k.area,
          'city', k.city,
          'district', k.district,
          'state', k.state,
          'country', k.country,
          'pincode', k.pincode,
          'dob', k.dob,
          'addressproof', k.addressproof,
          'enternumber', k.enternumber,
          'nominee_name', k.nominee_name,
          'nominee_relationship', k.nominee_relationship
        )
        FROM kyc k 
        WHERE k.user_id = u.id
        LIMIT 1
      ),
      JSON_OBJECT()
    ) AS kyc_data,
    IFNULL(
      (
        SELECT JSON_ARRAYAGG(
          JSON_OBJECT(
            'id', i.id,
            'schemeid', i.schemeid,
            'chitid', i.chitid,
            'accountname', i.accountname,
            'joiningdate', i.joiningdate,
            'goldrate', i.goldrate,
            'paymentstatus', i.paymentstatus,
            'scheme', IFNULL(
              (
                SELECT JSON_OBJECT(
                  'SCHEMEID', s.SCHEMEID,
                  'SCHEMENAME', s.SCHEMENAME,
                  'SCHEMETYPE', s.SCHEMETYPE,
                  'SCHEMENO', s.SCHEMENO,
                  'REGNO', s.REGNO,
                  'ACTIVE', s.ACTIVE,
                  'BRANCHID', s.BRANCHID,
                  'INS_TYPE', s.INS_TYPE,
                  'DESCRIPTION', s.DESCRIPTION,
                  'SLOGAN', s.SLOGAN,
                  'IMAGE', s.IMAGE,
                  'ICON', s.ICON
                )
                FROM schemes s 
                WHERE s.SCHEMEID = i.schemeid
                LIMIT 1
              ),
              JSON_OBJECT()
            ),
            'chit', IFNULL(
              (
                SELECT JSON_OBJECT(
                  'CHITID', c.CHITID,
                  'AMOUNT', c.AMOUNT,
                  'NOINS', c.NOINS,
                  'TOTALMEMBERS', c.TOTALMEMBERS,
                  'REGNO', c.REGNO,
                  'ACTIVE', c.ACTIVE,
                  'METID', c.METID,
                  'GROUPCODE', c.GROUPCODE
                )
                FROM chits c 
                WHERE c.CHITID = i.chitid
                LIMIT 1
              ),
              JSON_OBJECT()
            )
          )
        )
        FROM investments i 
        WHERE i.userid = u.id
      ),
      JSON_ARRAY()
    ) AS investment_data
  FROM users u
  WHERE u.id = ?;
  `;
  const [rows] = await db.query(sql, [userId]);
  return rows[0]; // returns aggregated data for the user
};
const searchUsers = async (mobile_number) => {
  try {
    // Validate mobile_number before proceeding
    if (!mobile_number || typeof mobile_number !== "string" || !/^\d{10}$/.test(mobile_number)) {
      throw new Error("Invalid mobile number format. It must be a 10-digit string.");
    }

    const query = `
      SELECT 
        u.id, 
        u.email, 
        u.mobile_number, 
        u.created_at, 
        u.name,
        u.referral_code,
        u.kyc_status,
        
        IF(
          k.user_id IS NOT NULL, 
          JSON_OBJECT(
            'id', k.id,
            'doorno', k.doorno,
            'street', k.street,
            'area', k.area,
            'city', k.city,
            'district', k.district,
            'state', k.state,
            'country', k.country,
            'pincode', k.pincode,
            'dob', k.dob,
            'addressproof', k.addressproof,
            'enternumber', k.enternumber,
            'nominee_name', k.nominee_name,
            'nominee_relationship', k.nominee_relationship
          ),
          '{}'
        ) AS kyc_data
      FROM users u
      LEFT JOIN kyc k ON k.user_id = u.id 
      WHERE mobile_number = ?
    `;

    const [results] = await db.query(query, [mobile_number]);

    if (!results.length) {
      throw new Error("No user found with the provided mobile number.");
    }

    return results;
  } catch (error) {

    logger.error(error)
    console.error("Error searching for users:", error.message);
    return { error: error.message };
  }
};

module.exports = {
  createUser,
  getAllUsers,
  getUserById,
  updateUser,
  deleteUser,
  getAggregatedData,
  searchUsers
};
