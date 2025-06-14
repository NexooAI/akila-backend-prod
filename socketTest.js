// socketTest.js
const socketClient = require('socket.io-client');  // Import Socket.IO client
const { server } = require('./index');  // Import the server instance to connect

const PORT = 3001;  // The port your server is listening on

// Connect to the Socket.IO server running on the specified port
const socketTest = socketClient.connect(`http://localhost:${PORT}`);

socketTest.on('connect', () => {
    console.log('Connected to Socket.IO server');

    // Emit a test event to the server
    socketTest.emit('updatePaymentStatus', { orderId: 'order_123', status: 'success' });
});

// Listen for server events (this should match events being emitted by your server)
socketTest.on('paymentStatusUpdate', (data) => {
    console.log('Received payment status update:', data);
});

// Listen for disconnection
socketTest.on('disconnect', () => {
    console.log('Disconnected from server');
});
