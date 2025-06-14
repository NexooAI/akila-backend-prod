const db = require("../config/db");

const createPermission = async (permissionName, description) => {
    return db.query("INSERT INTO permissions (permission_name, description) VALUES (?, ?)", [permissionName, description]);
};

const getAllPermissions = async () => {
    return db.query("SELECT * FROM permissions");
};

const deletePermission = async (id) => {
    return db.query("DELETE FROM permissions WHERE id = ?", [id]);
};

module.exports = { createPermission, getAllPermissions, deletePermission };
