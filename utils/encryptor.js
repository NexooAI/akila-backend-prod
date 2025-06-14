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

module.exports = { encrypt, decrypt };
