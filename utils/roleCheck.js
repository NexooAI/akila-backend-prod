const jwt = require("jsonwebtoken");
const db = require("../config/db"); // Ensure correct DB connection
const { SECRET_KEY } = process.env; // Use environment variable for security

const checkPermission = (permission) => {
  return async (req, res, next) => {
    try {
      // Extract JWT token
      const token = req.headers.authorization?.split(" ")[1];
      if (!token) {
        return res.status(401).json({ success: false, message: "Unauthorized: No token provided" });
      }

      // Verify and decode the token
      const decoded = jwt.verify(token, SECRET_KEY);
      req.user = decoded;
      const userId = decoded.id;

      // Get User Role
      const [roles] = await db.query(
        `SELECT r.role_name FROM roles r
         JOIN user_roles ur ON ur.role_id = r.id
         WHERE ur.user_id = ?`, 
        [userId]
      );

      if (roles.length === 0) {
        return res.status(403).json({ success: false, message: "Access Denied! No role assigned." });
      }

      // Get User Permissions
      const [permissions] = await db.query(
        `SELECT p.permission_name FROM permissions p
         JOIN role_permissions rp ON rp.permission_id = p.id
         WHERE rp.role_id IN (SELECT role_id FROM user_roles WHERE user_id = ?)`, 
        [userId]
      );

      const userPermissions = permissions.map(p => p.permission_name);

      // Check if user has required permission
      if (!userPermissions.includes(permission)) {
        return res.status(403).json({ success: false, message: "You do not have permission!" });
      }

      next(); // Proceed to the next middleware or route handler
    } catch (error) {
      console.error("Permission Check Error:", error);
      return res.status(401).json({ success: false, message: "Invalid or expired token" });
    }
  };
};

module.exports = checkPermission;
