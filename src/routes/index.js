const express = require('express');
const router = express.Router();

// 基础路由
router.get('/', (req, res) => {
  res.json({ message: '欢迎使用API服务' });
});

// 在这里添加其他路由
// router.use('/users', require('./userRoutes'));
// router.use('/auth', require('./authRoutes'));

module.exports = router;
