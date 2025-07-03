// config/db.js
const mysql = require("mysql2/promise");

const db = mysql.createPool({
  // host: process.env.DB_HOST || "localhost",
  // user: process.env.DB_USER || "root",
  // password: process.env.DB_PASSWORD || "",
  // database: process.env.DB_NAME || "jwl_db_flexi",
 // database:"ramcarmo_jwl_db_flexi",
  //   prod
  host: "localhost",
  user: "akilajew_flexi",
  password: "26pV-9m5*fRu",
  database: "akilajew_gold_savings",
  waitForConnections: true,
  connectionLimit: 10, // Adjust based on traffic
  queueLimit: 0,
  connectTimeout: 10000,
});

// You can test the connection with an async IIFE if needed
// const db = mysql.createPool({
//   host: "mysql_container",
//   user: "root",
//   password: "Nex00_G0ld_Market",
//   database: "dc_jwl_gold",
//   //   prod
//   // host: "localhost",
//   // user: "ramcarmo_jwl",
//   // password: "$^cX_vI}}M6Z",
//   // database: "ramcarmo_jwl_gold",
//   waitForConnections: true,
//   connectionLimit: 10, // Adjust based on traffic
//   queueLimit: 0,
//   connectTimeout: 10000,
// });

(async () => {
  try {
    const connection = await db.getConnection();
    console.log("Connected to the database");
    connection.release();
  } catch (err) {
    console.error("Error connecting to the database:", err);
  }
})();

module.exports = db;
