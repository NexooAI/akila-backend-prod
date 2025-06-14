const adminUserModel = require("../models/adminUserModel");

const getAdminUser = async (req, res) => {
    try {
        const user = await adminUserModel.getAdminUserById(req.params.id);
        console.log("user",user)
        if (!user) return res.status(404).json({ message: "User not found" });
        res.json(user);
    } catch (error) {
        res.status(500).json({ message: "Internal Server Error" });
    }
};
const getAllAdminUser = async (req, res) => {
    try {
        
        const users = await adminUserModel.getAllAdminUser();
        console.log("Fetched admin users:", users);

        if (!users || users.length === 0) {
            return res.status(404).json({ message: "No admin users found" });
        }

        res.status(200).json({ success:true,message: "Admin users fetched successfully", data: users });
    } catch (error) {
        console.error("Error in getAllAdminUser:", error);
        res.status(500).json({ message: "Internal Server Error" });
    }
};


const createAdminUser = async (req, res) => {
    try {
        const userId = await adminUserModel.createAdminUser(req.body);
        res.status(201).json({ message: "User created successfully", userId });
    } catch (error) {
        console.log('error',error)
        res.status(500).json({ message: "Error creating user" });
    }
};

const updateAdminUser = async (req, res) => {
    try {
        await adminUserModel.updateAdminUser(req.params.id, req.body);
        res.json({ message: "User updated successfully" });
    } catch (error) {
        res.status(500).json({ message: "Error updating user" });
    }
};

const deleteAdminUser = async (req, res) => {
    try {
        await adminUserModel.deleteAdminUser(req.params.id);
        res.json({ message: "User deleted successfully" });
    } catch (error) {
        res.status(500).json({ message: "Error deleting user" });
    }
};
const deactivateAdminUser = async (req, res) => {
    try {
        const { userId=req.user.id, id, description } = req.body;
        console.log('userId',userId)
        // Validate input
        if (!id || !description) {
            return res.status(400).json({ message: "Missing required fields" });
        }

        // Deactivate user in the database
        const result = await adminUserModel.deactivateAdminUser(id, userId, description);
console.log(result)

        // Check if the user was found and updated
        if (result.affectedRows === 0) {
            return res.status(404).json({ message: "User not found or already inactive" });
        }

        res.json({success:true, message: "User deactivated successfully" });
    } catch (error) {
        console.error("Error deactivating user:", error);
        res.status(500).json({ message: "Error deactivating user" });
    }
};


module.exports = {
    getAdminUser,
    createAdminUser,
    updateAdminUser,
    deleteAdminUser,
    deactivateAdminUser,
    getAllAdminUser
};
