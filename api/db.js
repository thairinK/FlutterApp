const mysql = require('mysql2');
const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: '',      // ใส่ของคุณ
  database: 'demo',
});
module.exports = pool.promise();
