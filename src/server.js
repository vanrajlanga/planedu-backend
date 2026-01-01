const fs = require('fs');
const path = require('path');

// Log file path
const logFile = path.join(__dirname, '../logs/server.log');

// Ensure logs directory exists
const logsDir = path.join(__dirname, '../logs');
if (!fs.existsSync(logsDir)) {
  fs.mkdirSync(logsDir, { recursive: true });
}

// Logger function
const log = (level, message, error = null) => {
  const timestamp = new Date().toISOString();
  const logMessage = `[${timestamp}] [${level}] ${message}${error ? '\n' + (error.stack || error) : ''}\n`;

  // Console output
  console.log(logMessage);

  // File output
  try {
    fs.appendFileSync(logFile, logMessage);
  } catch (e) {
    console.error('Failed to write to log file:', e.message);
  }
};

log('INFO', '========== SERVER STARTUP BEGIN ==========');
log('INFO', `Initial PORT from environment: ${process.env.PORT}`);

// Store Passenger/Plesk port before dotenv overwrites it
const PASSENGER_PORT = process.env.PORT;
log('INFO', `PASSENGER_PORT captured: ${PASSENGER_PORT}`);

try {
  require('dotenv').config();
  log('INFO', 'dotenv loaded successfully');
  log('INFO', `PORT after dotenv: ${process.env.PORT}`);
} catch (error) {
  log('ERROR', 'Failed to load dotenv', error);
  process.exit(1);
}

let app, pool;

try {
  app = require('./app');
  log('INFO', 'App module loaded successfully');
} catch (error) {
  log('ERROR', 'Failed to load app module', error);
  process.exit(1);
}

try {
  const db = require('./config/database');
  pool = db.pool;
  log('INFO', 'Database module loaded successfully');
} catch (error) {
  log('ERROR', 'Failed to load database module', error);
  process.exit(1);
}

// Use Passenger's port if available, otherwise use .env PORT or default
const PORT = PASSENGER_PORT || process.env.PORT || 3000;
const NODE_ENV = process.env.NODE_ENV || 'development';

log('INFO', `Final PORT: ${PORT}`);
log('INFO', `NODE_ENV: ${NODE_ENV}`);

// Start server
let server;
try {
  server = app.listen(PORT, async () => {
    log('INFO', '========================================');
    log('INFO', 'PlanEdu API Server Started');
    log('INFO', '========================================');
    log('INFO', `Server running on port: ${PORT}`);
    log('INFO', `Environment: ${NODE_ENV}`);
    log('INFO', `Started at: ${new Date().toLocaleString()}`);
    log('INFO', '========================================');

    // Test database connection
    try {
      await pool.query('SELECT NOW()');
      log('INFO', 'Database connection established');
    } catch (error) {
      log('ERROR', 'Database connection failed', error);
      process.exit(1);
    }
  });

  server.on('error', (error) => {
    log('ERROR', 'Server error', error);
    process.exit(1);
  });

} catch (error) {
  log('ERROR', 'Failed to start server', error);
  process.exit(1);
}

// Graceful shutdown
const gracefulShutdown = async (signal) => {
  log('INFO', `${signal} received. Starting graceful shutdown...`);

  if (server) {
    server.close(async () => {
      log('INFO', 'HTTP server closed');

      try {
        await pool.end();
        log('INFO', 'Database pool closed');
        log('INFO', 'Graceful shutdown completed');
        process.exit(0);
      } catch (error) {
        log('ERROR', 'Error during graceful shutdown', error);
        process.exit(1);
      }
    });
  }

  // Force shutdown after 10 seconds
  setTimeout(() => {
    log('ERROR', 'Forcing shutdown after timeout');
    process.exit(1);
  }, 10000);
};

// Handle shutdown signals
process.on('SIGTERM', () => gracefulShutdown('SIGTERM'));
process.on('SIGINT', () => gracefulShutdown('SIGINT'));

// Handle uncaught exceptions
process.on('uncaughtException', (error) => {
  log('ERROR', 'Uncaught Exception', error);
  gracefulShutdown('UNCAUGHT_EXCEPTION');
});

// Handle unhandled promise rejections
process.on('unhandledRejection', (reason, promise) => {
  log('ERROR', `Unhandled Rejection: ${reason}`);
  gracefulShutdown('UNHANDLED_REJECTION');
});
