const express = require('express');
const router = express.Router();

/**
 * @swagger
 * tags:
 *   name: API Info
 *   description: API information and available endpoints
 */

/**
 * @swagger
 * /api-info:
 *   get:
 *     summary: Get API information and available endpoints
 *     tags: [API Info]
 *     responses:
 *       200:
 *         description: API information retrieved successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 message:
 *                   type: string
 *                 data:
 *                   type: object
 */
router.get('/', (req, res) => {
  const apiInfo = {
    success: true,
    message: 'API endpoints information',
    data: {
      baseUrl: `${req.protocol}://${req.get('host')}`,
      endpoints: {
        // Admin Flows
        admin: {
          description: 'Admin management endpoints',
          routes: [
            'GET /admin/users - Get all admin users',
            'POST /admin/users - Create admin user',
            'PUT /admin/users/:id - Update admin user',
            'DELETE /admin/users/:id - Delete admin user',
            'GET /admin/dashboard - Get admin dashboard stats',
            'GET /admin/analytics - Get admin analytics',
            'GET /admin/reports - Get admin reports'
          ]
        },
        // Mobile App Flows
        mobile: {
          description: 'Mobile app specific endpoints',
          routes: [
            'GET /mobile/user/profile - Get user profile',
            'PUT /mobile/user/profile - Update user profile',
            'GET /mobile/investments - Get user investments',
            'GET /mobile/schemes - Get available schemes',
            'GET /mobile/payments - Get payment history',
            'POST /mobile/payments - Make payment',
            'GET /mobile/notifications - Get user notifications',
            'GET /mobile/kyc - Get KYC status',
            'POST /mobile/kyc - Submit KYC documents'
          ]
        },
        // Existing endpoints
        videos: {
          description: 'Video management endpoints',
          routes: [
            'GET /videos - Get all videos',
            'GET /videos/:id - Get video by ID',
            'POST /videos - Create new video',
            'PUT /videos/:id - Update video',
            'DELETE /videos/:id - Delete video'
          ],
          legacy: [
            'GET /videos/video - Get all videos (legacy)',
            'GET /videos/video/:id - Get video by ID (legacy)'
          ]
        },
        schemes: {
          description: 'Scheme management endpoints',
          routes: [
            'GET /schemes - Get all schemes',
            'GET /schemes/:id - Get scheme by ID',
            'POST /schemes - Create new scheme'
          ],
          legacy: [
            'GET /schemes/schemes - Get all schemes (legacy)',
            'GET /schemes/schemes/:id - Get scheme by ID (legacy)'
          ]
        },
        investments: {
          description: 'Investment management endpoints',
          routes: [
            'GET /investments - Get all investments',
            'GET /investments/:id - Get investment by ID',
            'GET /investments/user/:userId - Get investments by user ID',
            'POST /investments - Create new investment',
            'PUT /investments/:id - Update investment',
            'DELETE /investments/:id - Delete investment'
          ],
          legacy: [
            'GET /investments/investments - Get all investments (legacy)',
            'GET /investments/user_investments/:userId - Get user investments (legacy)'
          ]
        },
        posters: {
          description: 'Poster management endpoints',
          routes: [
            'GET /posters - Get all posters',
            'GET /posters/active - Get active posters',
            'GET /posters/:id - Get poster by ID',
            'POST /posters - Create new poster',
            'DELETE /posters/:id - Delete poster'
          ]
        },
        auth: {
          description: 'Authentication endpoints',
          routes: [
            'POST /auth/login - User login',
            'POST /auth/logout - User logout',
            'POST /auth/refresh - Refresh token',
            'POST /auth/forgot-password - Forgot password',
            'POST /auth/reset-password - Reset password',
            'POST /auth/verify-otp - Verify OTP'
          ]
        },
        users: {
          description: 'User management endpoints',
          routes: [
            'GET /users - Get all users',
            'GET /users/:id - Get user by ID',
            'PUT /users/:id - Update user',
            'DELETE /users/:id - Delete user',
            'GET /users/kyc/:id - Get user KYC details',
            'PUT /users/kyc/:id - Update user KYC'
          ]
        }
      },
      authentication: {
        type: 'Bearer Token',
        header: 'Authorization: Bearer <your-token>',
        note: 'Most endpoints require authentication'
      },
      documentation: '/api-docs'
    }
  };

  res.status(200).json(apiInfo);
});

module.exports = router; 