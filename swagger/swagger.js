const swaggerJsdoc = require("swagger-jsdoc");
const swaggerUi = require("swagger-ui-express");
// const baseUrl = "http://localhost:3001";
// const baseUrl='https://nexooai.ramcarmotor.com/'
const baseUrl = "http://reqres.akilajewellers.com";

const options = {
  definition: {
    openapi: "3.0.0",
    info: {
      title: "DC Gold Flexi",
      version: "1.0.0",
      description: "API for managing offers with image uploads",
    },
    servers: [{ url: baseUrl, description: "Development server" }],
    components: {
      securitySchemes: {
        bearerAuth: {
          type: "http",
          scheme: "bearer",
          bearerFormat: "JWT",
          description: "Enter your JWT token in the format: Bearer <token>"
        }
      }
    },
    security: [{
      bearerAuth: []
    }]
  },
  apis: ["./routes/*.js"],
};

// Configure Swagger UI options to collapse endpoints by default
const swaggerOptions = {
  docExpansion: "list", // Collapse endpoints by default
  defaultModelsExpandDepth: -1, // Collapse/hide models
  defaultModelExpandDepth: 1, // Adjust model expansion depth as desired
  plugins: [],
  swaggerOptions: {
    persistAuthorization: true,
    displayRequestDuration: true,
    filter: true,
    tryItOutEnabled: true
  }
};

const specs = swaggerJsdoc(options);

module.exports = { swaggerUi, specs, swaggerOptions };
