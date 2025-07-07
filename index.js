const express = require("express");
const app = express();
const cors = require("cors");
const morgan = require('morgan');
const logger = require('./middlewares/logger');
const path = require("path");
const { swaggerUi, specs, swaggerOptions } = require("./swagger/swagger");
const http = require("http");
const { Server } = require("socket.io");
const { trackMissedPayments, trackMissedPaymentsNew } = require('./middlewares/missedPayments');
const {startWorker}=require('./middlewares/worker')
// Create an HTTP server
const server = http.createServer(app);
const EventEmitter = require("events");
const eventEmitter = new EventEmitter();
// Initialize Socket.io with CORS configuration
const io = new Server(server, {
  cors: {
    origin: [
      "http://localhost:4200",
      "https://api.dcjewellers.org",
      "http://api.dcjewellers.org",
      "https://nexo-admin.aarkal.com",
      "https://admin.dcjewellers.org",
      "http://admin.dcjewellers.org",
      "http://3.109.5.153:8082",
      "https://nexooai.ramcarmotor.com",
      "http://reqres.akilajewellers.com"
    ],
    methods: ["GET", "POST", "PUT", "PATCH", "DELETE"],
    credentials: true,
  },
});
const {registerSocketEvents, orderMetaMap}=require('./utils/socket')

module.exports = { io, eventEmitter, server };
// Import routes
const authRoutes = require("./routes/authRoutes");
const registerRoutes = require("./routes/registerRoutes");
const userRoutes = require("./routes/userRoutes");
const rateRoutes = require("./routes/rateRoutes");
const schemeRoutes = require("./routes/schemeRoutes");
const chitchRoutes = require("./routes/chitRoutes");
const branchRoutes = require("./routes/branchRoutes");
const investmentRoutes = require("./routes/investmentRoutes");
const videoRoutes = require("./routes/videoRoutes");
const offerRoutes = require("./routes/offerRoutes");
const kycRoutes = require("./routes/kycRoutes");
const paymentRoutes = require("./routes/paymentRoutes");
const policyRoutes = require("./routes/policyRoutes");
const analyticsRoutes = require("./routes/analyticsRoutes");
const schemesknowmore = require("./routes/schemesKnowmoreRoutes");
const homeRoutes = require("./routes/homeRoutes");
const transactionRoutes = require("./routes/transactionRoutes");
const notificationRoutes = require("./routes/notificationRoutes");
const adminUserRoutes = require("./routes/adminUserRoutes");
const roleRoutes = require("./routes/roleRouter");
const flashNewsRoutes = require("./routes/flashNewsRoutes");
const collectionRoutes = require("./routes/collectionRoutes");
const initialPopupRoutes = require("./routes/initialPopupRoutes");
const posterRoutes = require("./routes/posterRoutes");
const apiInfoRoutes = require("./routes/apiInfoRoutes");
const intoScreenRoutes=require("./routes/introScreenRoutes")
// Configure CORS for Express
const corsOptions = {
  origin: [
    "http://localhost:4200",
    "http://localhost:3000",
    "http://localhost:3001",
    "http://localhost:8080",
    "http://localhost:8081",
    "http://localhost:5173",
    "https://api.dcjewellers.org",
    "https://nexo-admin.aarkal.com",
    "https://admin.dcjewellers.org",
    "http://api.dcjewellers.org",
    "http://admin.dcjewellers.org",
    "http://3.109.5.153:8082",
    "https://3.109.5.153:8082",
    "https://nexooai.ramcarmotor.com",
    "http://reqres.akilajewellers.com"
  ],
  methods: ["GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"],
  allowedHeaders: ["Content-Type", "Authorization", "Accept", "Origin", "X-Requested-With"],
  exposedHeaders: ["Content-Length", "Content-Type"],
  credentials: true,
  maxAge: 86400,
};

// Export `io` so it can be imported in other files
console.log = (...args) => logger.info(args.join(' '));
console.error = (...args) => logger.error(args.join(' '));
// Call the cron job function
trackMissedPaymentsNew();
startWorker();
registerSocketEvents(io)
// 📝 HTTP request logs
app.use(morgan('combined', {
  stream: {
    write: message => logger.info(message.trim())
  }
}));
app.set("views", path.join(__dirname, "views"));
app.set("view engine", "ejs");
app.use(express.static(path.join(__dirname, "public")));
// Middleware setup
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(cors(corsOptions));
app.get("/loading", (req, res) => {
  res.render("loading", { orderId: req.query.orderId || "N/A" });
});
// Set the WebSocket instance for later use
app.set("trust proxy", true);
const paymentController = require("./controllers/paymentController");
paymentController.eventEmitter = eventEmitter;
// Route handlers
app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(specs, swaggerOptions));

// API Routes
app.use("/auth", authRoutes);
app.use("/register", registerRoutes);
app.use(userRoutes);
app.use("/intro-screens",intoScreenRoutes)
app.use("/rates", rateRoutes);
app.use("/schemes", schemeRoutes);
app.use("/chits", chitchRoutes);
app.use("/branches", branchRoutes);
app.use("/investments", investmentRoutes);
app.use("/videos", videoRoutes);
app.use(offerRoutes);
app.use("/kyc", kycRoutes);
app.use("/payments", paymentRoutes);
app.use("/policies", policyRoutes);
app.use("/analytics", analyticsRoutes);
app.use(schemesknowmore);
app.use("/home", homeRoutes);
app.use("/transactions", transactionRoutes);
app.use("/notifications", notificationRoutes);
app.use("/admin/users", adminUserRoutes);
app.use("/roles", roleRoutes);
app.use("/flash-news", flashNewsRoutes);
app.use("/collections", collectionRoutes);
app.use("/initial-popups", initialPopupRoutes);
app.use("/posters", posterRoutes);
app.use("/api-info", apiInfoRoutes);
// Static file routes
app.use("/uploads", express.static(path.join(__dirname, "uploads")));

// WebSocket event handlers
io.on("connection", (socket) => {
  console.log("New WebSocket connection:", socket.id);

  socket.on("updatePaymentStatus", (data) => {
    console.log("Received payment status update:", data);
    io.emit("paymentStatusUpdate", data);
  });

  socket.on("disconnect", () => {
    console.log("WebSocket disconnected:", socket.id);
  });

  socket.on("error", (error) => {
    console.error("WebSocket error:", error);
  });
});

// Handle eventEmitter events
eventEmitter.on("payment_status_update", (data) => {
  console.log("Emitting payment status update:", data);
  io.emit("payment_status_update", data);
});

// Start the server
const PORT = process.env.PORT || 3001;
server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});

// Set server timeout
server.timeout = 60000;

// Testing Socket.IO from the backend
const socketTest = require("socket.io-client").connect(
  `http://localhost:${PORT}`
);

socketTest.on("connect", () => {
  console.log("Connected to Socket.IO server");
  socketTest.emit("testEvent", { message: "Hello from the backend!" });
});

// Error handling middleware
app.use((err, req, res, next) => {
  logger.error('Error:', err);
  
  if (err.name === 'MulterError') {
    return res.status(400).json({
      success: false,
      message: err.message
    });
  }

  if (err.name === 'ValidationError') {
    return res.status(400).json({
      success: false,
      message: err.message
    });
  }

  if (err.name === 'UnauthorizedError') {
    return res.status(401).json({
      success: false,
      message: 'Unauthorized access'
    });
  }

  res.status(500).json({
    success: false,
    message: process.env.NODE_ENV === 'development' ? err.message : 'Something went wrong!'
  });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({
    success: false,
    message: `Route not found: ${req.method} ${req.originalUrl}`
  });
});
