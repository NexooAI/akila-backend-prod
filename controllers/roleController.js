const roleModel = require("../models/roleModel");
const rolePermissionModel=require('../models/rolePermissionModel')
const createRole = async (req, res) => {
    try {
        const { roleName, description } = req.body;
        await roleModel.createRole(roleName, description);
        res.json({ message: "Role created successfully" });
    } catch (error) {
        res.status(500).json({ message: "Error creating role", error });
    }
};

const getAllRoles = async (req, res) => {
    try {
        const [roles] = await roleModel.getAllRoles();
        res.json(roles);
    } catch (error) {
        res.status(500).json({ message: "Error fetching roles", error });
    }
};

const deleteRole = async (req, res) => {
    try {
        const { id } = req.params;
        await roleModel.deleteRole(id);
        res.json({ message: "Role deleted successfully" });
    } catch (error) {
        res.status(500).json({ message: "Error deleting role", error });
    }
};
const assignPermissionToRole = async (req, res) => {
    try {
        const { roleId, permissionIds } = req.body;
        
        if (!roleId || !Array.isArray(permissionIds) || permissionIds.length === 0) {
            return res.status(400).json({ message: "Role ID and at least one permission are required" });
        }

        // Assign multiple permissions
        await rolePermissionModel.assignPermissions(roleId, permissionIds);
        
        res.json({ message: "Permissions assigned successfully", assignedPermissions: permissionIds });
    } catch (error) {
        res.status(500).json({ message: "Error assigning permissions", error: error.message });
    }
};

// Get permissions assigned to a role
const getRolePermissions = async (req, res) => {
    try {
        const { roleId } = req.params;
        if (!roleId) {
            return res.status(400).json({ message: "Role ID is required" });
        }

        const permissions = await rolePermissionModel.getPermissions(roleId);
        res.json({ roleId, permissions });
    } catch (error) {
        res.status(500).json({ message: "Error fetching role permissions", error: error.message });
    }
};
module.exports = { createRole, getAllRoles, deleteRole,assignPermissionToRole,getRolePermissions };
