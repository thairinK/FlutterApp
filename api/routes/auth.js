const express = require('express');
const bcrypt = require('bcrypt');
const db = require('../db');
const router = express.Router();

router.post('/register', async (req, res) => {
  const { name, email, password } = req.body;
  if (!name || !email || !password)
    return res.json({ success: false, message: 'กรุณากรอกครบทุกช่อง' });

  const [existing] = await db.execute('SELECT id FROM users WHERE email = ?', [email]);
  if (existing.length > 0)
    return res.json({ success: false, message: 'อีเมลนี้ลงทะเบียนไปแล้ว' });

  const hash = await bcrypt.hash(password, 10);
  await db.execute('INSERT INTO users (user, email, password) VALUES (?, ?, ?)', [name, email, hash]);
  res.json({ success: true, message: 'สมัครสมาชิกเรียบร้อยแล้ว' });
});

router.post('/login', async (req, res) => {
  const { email, password } = req.body;
  if (!user || !password)
    return res.json({ success: false, message: 'กรุณากรอก email และ password' });

  const [rows] = await db.execute('SELECT * FROM users WHERE email = ?', [email]);
  if (rows.length === 0)
    return res.json({ success: false, message: 'ไม่พบบัญชีนี้' });

  const user = rows[0]
  const ok = await bcrypt.compare(password, user.password);
  if (!ok)
    return res.json({ success: false, message: 'รหัสผ่านไม่ถูกต้อง' });

  res.json({ success: true, message: 'Login สำเร็จ!' });
});

module.exports = router;
