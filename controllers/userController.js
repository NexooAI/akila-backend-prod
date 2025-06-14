const userModel = require("../models/userModel");

// Create a new user (with optional referred_by)
const createUser = async (req, res) => {
  try {
    const { name, email, mobile_number, user_type, referred_by } = req.body;
    const userData = { name, email, mobile_number, user_type, referred_by };
    const result = await userModel.createUser(userData);
    res.status(201).json({
      message: "User created successfully",
      data: {
        id: result.insertId,
        name,
        email,
        mobile_number,
        user_type,
        referred_by: referred_by || null,
      },
    });
  } catch (error) {
    console.error("Error creating user:", error);
    res.status(500).json({ error: "Failed to create user" });
  }
};
const searchUsers = async (req, res) => {
  try {
    const { mobile_number } = req.body;
    if (!mobile_number) {
      return res.status(400).json({ error: "Mobile number is required." });
    }
    // Validate mobile_number before proceeding
    if (!mobile_number || typeof mobile_number !== "string" || !/^\d{10}$/.test(mobile_number)) {
      return res.status(400).json({ error: "Invalid mobile number format. It must be a 10-digit string." });
    }

    const results = await userModel.searchUsers(mobile_number);

    if (!results.length) {
      return res.status(404).json({ error: "No user found with the provided mobile number." });
    }

    results.forEach((user) => {
      if (typeof user.kyc_data === "string") {
        try {
          user.kyc_data = JSON.parse(user.kyc_data);
        } catch (err) {
          console.error("Error parsing kyc_data:", err);
          user.kyc_data = {};
        }
      }
    });

    res.status(200).json({
      message: "Users fetched successfully",
      data: results,
    });
  } catch (error) {
    console.error("Error fetching users:", error);
    res.status(500).json({ error: "Failed to fetch users" });
  }
};

// Get all users
const getUsers = async (req, res) => {
  try {
    const results = await userModel.getAllUsers();
    if (typeof results.kyc_data === "string") {
      try {
        results.kyc_data = JSON.parse(results.kyc_data);
      } catch (err) {
        console.error("Error parsing kyc_data:", err);
        results.kyc_data = {};
      }
    }
    res.status(200).json({
      message: "Users fetched successfully",
      data: results,
    });
  } catch (error) {
    console.error("Error fetching users:", error);
    res.status(500).json({ error: "Failed to fetch users" });
  }
};

// Get a single user by ID
const getUserById = async (req, res) => {
  try {
    const { user_id } = req.params;
    const results = await userModel.getUserById(user_id);
    if (!results || results.length === 0) {
      return res.status(404).json({ error: "User not found" });
    }
    res.status(200).json({
      message: "User fetched successfully",
      data: results[0],
    });
  } catch (error) {
    console.error("Error fetching user:", error);
    res.status(500).json({ error: "Failed to fetch user" });
  }
};

// Update user details (with optional referred_by)
const updateUser = async (req, res) => {
  try {
    const { user_id } = req.params;
    const userData = req.body;
    console.log("Updating user with data:", userData);
    const result = await userModel.updateUser(user_id, userData);
    if (result.affectedRows === 0) {
      return res.status(404).json({ error: "User not found" });
    }
    res.status(200).json({
      message: "User updated successfully",
      data: result,
    });
  } catch (error) {
    console.error("Error updating user:", error);
    res.status(500).json({ error: "Failed to update user" });
  }
};

// Delete a user
const deleteUser = async (req, res) => {
  try {
    const { user_id } = req.params;
    const result = await userModel.deleteUser(user_id);
    if (result.affectedRows === 0) {
      return res.status(404).json({ error: "User not found" });
    }
    res.status(200).json({
      message: "User deleted successfully",
    });
  } catch (error) {
    console.error("Error deleting user:", error);
    res.status(500).json({ error: "Failed to delete user" });
  }
};

// const getUserAggregatedData = async (req, res) => {
//   try {
//     const userId = req.params.user_id;
//     const data = await userModel.getAggregatedData(userId);
//     if (!data) {
//       return res.status(404).json({ message: "User not found" });
//     }
//     res.status(200).json({ data });
//   } catch (err) {
//     console.error("Error fetching aggregated user data:", err);
//     res.status(500).json({ error: "Failed to fetch user data" });
//   }
// };
const getUserAggregatedData = async (req, res) => {
  try {
    const userId = req.params.user_id;
    const data = await userModel.getAggregatedData(userId);

    // If no data is found
    if (!data) {
      return res.status(404).json({ message: "User not found" });
    }

    // Ensure that kyc_data and investment_data are parsed correctly (if they are strings)
    if (typeof data.kyc_data === "string") {
      try {
        data.kyc_data = JSON.parse(data.kyc_data);
      } catch (err) {
        console.error("Error parsing kyc_data:", err);
        data.kyc_data = {}; // Assign an empty object if parsing fails
      }
    }

    if (typeof data.investment_data === "string") {
      try {
        data.investment_data = JSON.parse(data.investment_data);
      } catch (err) {
        console.error("Error parsing investment_data:", err);
        data.investment_data = []; // Assign an empty array if parsing fails
      }
    }

    res.status(200).json({ data });
  } catch (err) {
    console.error("Error fetching aggregated user data:", err);
    res.status(500).json({ error: "Failed to fetch user data" });
  }
};

module.exports = {
  createUser,
  getUsers,
  getUserById,
  updateUser,
  deleteUser,
  getUserAggregatedData,
  searchUsers
};
