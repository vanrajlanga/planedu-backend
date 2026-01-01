require('dotenv').config();

const app = require('./src/app');
const { pool } = require('./src/config/database');

const PORT = process.env.PORT || 3000;
const NODE_ENV = process.env.NODE_ENV || 'development';

// Start server
const server = app.listen(PORT, async () => {
  console.log('========================================');
  console.log('PlanEdu API Server');
  console.log('========================================');
  console.log(`Server running on port: ${PORT}`);
  console.log(`Environment: ${NODE_ENV}`);
  console.log(`Started at: ${new Date().toLocaleString()}`);
  console.log('========================================');

  // Test database connection
  try {
    await pool.query('SELECT NOW()');
    console.log('Database connection established');
  } catch (error) {
    console.error('Database connection failed:', error.message);
    process.exit(1);
  }
});

// Graceful shutdown
const gracefulShutdown = async (signal) => {
  console.log(`\n${signal} received. Shutting down...`);

  server.close(async () => {
    try {
      await pool.end();
      console.log('Shutdown completed');
      process.exit(0);
    } catch (error) {
      console.error('Shutdown error:', error);
      process.exit(1);
    }
  });

  setTimeout(() => process.exit(1), 10000);
};

process.on('SIGTERM', () => gracefulShutdown('SIGTERM'));
process.on('SIGINT', () => gracefulShutdown('SIGINT'));
process.on('uncaughtException', (error) => {
  console.error('Uncaught Exception:', error);
  gracefulShutdown('UNCAUGHT_EXCEPTION');
});
process.on('unhandledRejection', (reason) => {
  console.error('Unhandled Rejection:', reason);
  gracefulShutdown('UNHANDLED_REJECTION');
});
