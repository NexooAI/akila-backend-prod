const db = require("../config/db");

const createRole = async (roleName, description) => {
    return db.query("INSERT INTO roles (role_name, description) VALUES (?, ?)", [roleName, description]);
};

const getAllRoles = async () => {
    return db.query("SELECT * FROM roles");
};

const deleteRole = async (id) => {
    return db.query("DELETE FROM roles WHERE id = ?", [id]);
};

module.exports = { createRole, getAllRoles, deleteRole };
