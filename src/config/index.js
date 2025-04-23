// 配置文件
// 从环境变量中获取配置信息

module.exports = {
  database: {
    url: process.env.DATABASE_URL || 'mongodb://localhost:27017/backend',
  },
  jwt: {
    secret: process.env.JWT_SECRET || 'your-secret-key',
    expiresIn: process.env.JWT_EXPIRES_IN || '1d',
  },
  server: {
    port: process.env.PORT || 3000,
  }
};
