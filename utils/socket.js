// socket.js
const orderMetaMap = new Map();

function registerSocketEvents(io) {
  io.on("connection", (socket) => {
    console.log("Socket connected 1:", socket.id);

    socket.on("store_payment_metadata", (meta) => {
      console.log("Received metadata:", JSON.stringify(meta))
      const { orderId, investmentId, userId, schemeId, chitId, amount, isManual,utr_reference_number,accountNumber,accountName } = meta;
      orderMetaMap.set(orderId, {
        investmentId,
        userId,
        schemeId,
        chitId,
        paymentAmount: amount,
        isManual,
        utr_reference_number,
        accountNumber,
        accountName
      });
     console.log("Stored metadata for:",orderMetaMap, JSON.stringify(Array.from(orderMetaMap.entries()), null, 2));
    });

    socket.on("disconnect", () => {
      console.log("Socket disconnected:", socket.id);
    });
  });
}

module.exports = { registerSocketEvents, orderMetaMap };
