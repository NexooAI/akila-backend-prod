// utils/encryptor.js
const crypto = require('crypto');

function encrypt(text, workingKey) {
  const key = crypto.createHash('md5').update(workingKey).digest();
  const iv = Buffer.alloc(16, '\0'); // 16 null bytes
  const cipher = crypto.createCipheriv('aes-128-cbc', key, iv);
  let encrypted = cipher.update(text, 'utf8', 'hex');
  encrypted += cipher.final('hex');
  return encrypted;
}
// function encrypt(text, workingKey) {
//   const key = crypto.createHash('md5').update(workingKey).digest();
//   const iv = Buffer.alloc(16, '\0'); // 16 null bytes
//   const cipher = crypto.createCipheriv('aes-128-cbc', key, iv);
//   let encrypted = cipher.update(text, 'utf8', 'hex');
//   encrypted += cipher.final('hex');
//   return encrypted;
// }

function decrypt(encText, workingKey) {
  const key = crypto.createHash('md5').update(workingKey).digest();
  const iv = Buffer.alloc(16, '\0');
  const decipher = crypto.createDecipheriv('aes-128-cbc', key, iv);
  let decrypted = decipher.update(encText, 'hex', 'utf8');
  decrypted += decipher.final('utf8');
  return decrypted;
}
function getAlgorithm(keyBase64) {
    var key = Buffer.from(keyBase64, 'base64');
    switch (key.length) {
        case 16:
            return 'aes-128-cbc';
        case 32:
            return 'aes-256-cbc';

    }
    throw new Error('Invalid key length: ' + key.length);
}

function encryptcc(plainText, keyBase64, ivBase64) {

    const key = Buffer.from(keyBase64, 'base64');
    const iv = Buffer.from(ivBase64, 'base64');

    const cipher = crypto.createCipheriv(getAlgorithm(keyBase64), key, iv);
    let encrypted = cipher.update(plainText, 'utf8', 'hex')
    encrypted += cipher.final('hex');
    return encrypted;
}

function decryptcc(messagebase64, keyBase64, ivBase64) {
    try
    {
    const key = Buffer.from(keyBase64, 'base64');
    const iv = Buffer.from(ivBase64, 'base64');

    const decipher = crypto.createDecipheriv(getAlgorithm(keyBase64), key, iv);
    let decrypted = decipher.update(messagebase64, 'hex');
    decrypted += decipher.final();
    return decrypted;
    }
    catch(error)
    {
        console.error("Decryption failed:", error.toString());
    }
   
}


module.exports = { encrypt, decrypt,decryptcc,encryptcc };
