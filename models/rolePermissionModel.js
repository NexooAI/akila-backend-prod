const db = require("../config/db");

// Assign multiple permissions to a role
const assignPermissions = async (roleId, permissionIds) => {
    // Remove existing permissions for this role to avoid duplicates
    await db.query("DELETE FROM role_permissions WHERE role_id = ?", [roleId]);

    if (permissionIds.length > 0) {
        const values = permissionIds.map((permissionId) => [roleId, permissionId]);
        await db.query("INSERT INTO role_permissions (role_id, permission_id) VALUES ?", [values]);
    }
};

// Get permissions assigned to a role
const getPermissions = async (roleId) => {
    const [rows] = await db.query(
        `SELECT p.id, p.permission_name 
         FROM permissions p 
         INNER JOIN role_permissions rp ON p.id = rp.permission_id 
         WHERE rp.role_id = ?`,
        [roleId]
    );
    return rows;
};

module.exports = { assignPermissions, getPermissions };
