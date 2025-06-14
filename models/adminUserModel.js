const db = require("../config/db");
const bcrypt = require("bcrypt");

const getAdminUserById = async (id) => {
    const [rows] = await db.query(
        `SELECT au.*, r.role_name FROM adminuser au 
        LEFT JOIN roles r ON au.role_id = r.id WHERE au.id = ?`, 
        [id]
    );
    return rows[0];
};
const getAllAdminUser = async () => {
    try {
        const [rows] = await db.query(
            `SELECT au.*, r.role_name FROM adminuser au 
             LEFT JOIN roles r ON au.role_id = r.id 
             ORDER BY au.id DESC`
        );

        if (!rows || rows.length === 0) {
            return {success:false,message:"No admin users found"}
        }

        return rows; // return all rows, not just the first
    } catch (error) {
        console.error("Error fetching admin users:", error.message);
        throw new Error("Failed to retrieve admin users. Please try again later.");
    }
};


const createAdminUser = async (userData) => {
    const { mobileNumber, fname, lname, email, password, empid, roleId, status } = userData;
    const hashedPassword = await bcrypt.hash(password, 10);

    const [result] = await db.query(
        `INSERT INTO adminuser (mobile_number, Fname, lname, email, password, empid, role_id, status) 
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
        [mobileNumber, fname, lname, email, hashedPassword, empid, roleId, status]
    );
    return result.insertId;
};

const updateAdminUser = async (id, userData) => {
    const { fname, lname, email, roleId, status } = userData;
    const [result] = await db.query(
        `UPDATE adminuser SET Fname=?, lname=?, email=?, role_id=?, status=?, updatedAt=NOW() WHERE id=?`,
        [fname, lname, email, roleId, status, id]
    );
    return result;
};

const deleteAdminUser = async (id) => {
    const [result] = await db.query(`DELETE FROM adminuser WHERE id = ?`, [id]);
    return result;
};

const deactivateAdminUser = async (id, userId, description) => {
    const [result] = await db.query(
        `UPDATE adminuser 
         SET status = 'inactive', updaterId = ?, descriptaion = ?, updatedAt = NOW() 
         WHERE id = ?`, 
        [userId, description, id]
    );
    return result;
};
module.exports = {
    getAdminUserById,
    createAdminUser,
    updateAdminUser,
    deleteAdminUser,
    deactivateAdminUser,
    getAllAdminUser
};
