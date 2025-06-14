const fs = require('fs');
const { Juspay, APIError } = require('expresscheckout-nodejs');
require('dotenv').config();

// Read Juspay keys
const publicKey = fs.readFileSync(process.env.PUBLIC_KEY_PATH);
const privateKey = fs.readFileSync(process.env.PRIVATE_KEY_PATH);

// Initialize Juspay SDK
const juspay = new Juspay({
    merchantId: process.env.MERCHANT_ID,
    baseUrl: process.env.SANDBOX_BASE_URL, 
    jweAuth: {
        keyId: process.env.KEY_UUID,
        publicKey,
        privateKey
    }
});

// Create a payment session
exports.createPaymentSession = async (orderId, amount, returnUrl,userId,investment_id,schemeId,userName,userEmail,userMobile,signature) => {
    try {
        console.log("userid",userId)
        return await juspay.orderSession.create({
            order_id: orderId,
            amount,
            payment_page_client_id: process.env.PAYMENT_PAGE_CLIENT_ID,
           //customer_id: 'hdfc-testing-customer-one',
            customer_id:userId,
            customer_name: userName, // Pass customer name
            customer_email: userEmail, // Pass email
            customer_phone: userMobile, // Pass phone number
            action: 'paymentPage',
            return_url: returnUrl,
            currency: 'INR',
            metadata: {
                investment_id: investment_id,  // Pass custom investment ID
                schemeId: schemeId               // Pass custom chit ID
            },
            signature
        });
    } catch (error) {
        console.log("error",error)
        throw error instanceof APIError ? error.message : "Payment session error";
    }
};

// Check payment status
exports.checkPaymentStatus = async (orderId) => {
    try {
         
        const statusResponse = await juspay.order.status(orderId)
        const orderStatus = statusResponse.status
        let message = ''
        switch (orderStatus) {
            case "CHARGED":
                message = "order payment done successfully"
                break
            case "PENDING":
            case "PENDING_VBV":
                message = "order payment pending"
                break
            case "AUTHORIZATION_FAILED":
                message = "order payment authorization failed"
                break
            case "AUTHENTICATION_FAILED":
                message = "order payment authentication failed"
                break
            default:
                message = "order status " + orderStatus
                break
        }

        // removes http field from response, typically you won't send entire structure as response
        return makeJuspayResponse(statusResponse)
    } catch (error) {
        throw error instanceof APIError ? error.message : "Payment status check error";
    }
};

exports.handlePayResponse = async (orderId) => {
    
    const orderIds = orderId

    if (orderIds == undefined) {
        return makeError('order_id not present or cannot be empty')
    }

    try {
        const statusResponse = await juspay.order.status(orderIds)
        const orderStatus = statusResponse.status
       
        let message = ''
        switch (orderStatus) {
            case "CHARGED":
                message = "order payment done successfully"
                break
            case "PENDING":
            case "PENDING_VBV":
                message = "order payment pending"
                break
            case "AUTHORIZATION_FAILED":
                message = "order payment authorization failed"
                break
            case "AUTHENTICATION_FAILED":
                message = "order payment authentication failed"
                break
            default:
                message = "order status " + orderStatus
                break
        }

        // removes http field from response, typically you won't send entire structure as response
        return makeJuspayResponse(statusResponse,message)
    } catch(error) {
        if (error instanceof APIError) {
            // handle errors comming from juspay's api,
            return makeError(error.message)
        }
        return makeError()
    }
};
// function makeJuspayResponse(successRspFromJuspay) {
//     if (successRspFromJuspay == undefined) return successRspFromJuspay
//     if (successRspFromJuspay.http != undefined) delete successRspFromJuspay.http
//     return successRspFromJuspay
// }
const makeError = (message = 'Something went wrong') => {
    return {
        success: false,
        message: message
    };
};

// Helper to format Juspay API responses
const makeJuspayResponse = (statusResponse,message) => {
    // Format the Juspay status response (if needed)
   
    return {
        message: message,
        statusResponse: statusResponse
    };
}
// function makeJuspayResponse(successRspFromJuspay) {
//     if (successRspFromJuspay == undefined) return successRspFromJuspay
//     if (successRspFromJuspay.http != undefined) delete successRspFromJuspay.http
//     return successRspFromJuspay
// }